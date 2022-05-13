package linda.shm;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

import linda.Callback;
import linda.Linda;
import linda.Tuple;

// Version avec Threads (Executor API):
// Parallelise: write, tryTake, tryRead, takeAll, readAll

/** Shared memory implementation of Linda. */
public class CentralizedLinda2 implements Linda {
	// Espace des tuples : K=taille, V=Liste de tuples de taille K
	private Hashtable<Integer, ArrayList<Tuple>> tuples;
	
	private HashMap<Tuple, ArrayList<Callback>> readCallbacks;
	private HashMap<Tuple, ArrayList<Callback>> takeCallbacks;
	
	private ReadWriteLock accesTuples;
	private ReadWriteLock accesCallbacks;

	private long[] nbQueries = {0, 0, 0}; // 0: Take, 1: Read, 2: Write

	private ExecutorService executor;
	
    public CentralizedLinda2() {
    	tuples = new Hashtable<>();
    	readCallbacks = new HashMap<>();
    	takeCallbacks = new HashMap<>();

		accesTuples = new ReadWriteLock();
		accesCallbacks = new ReadWriteLock();

		// Demarrage des threads
		executor = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());
    }

	// Retourne la liste des tuples correspondant a la taille du template
	// ou une liste vide si l'entree n'existe pas
	private ArrayList<Tuple> getTupleList(Tuple template) {
		Integer tSize = template.size();
		ArrayList<Tuple> tuplesList = null;

		try {
			accesTuples.lockRead();
			tuplesList = tuples.get(tSize);
			accesTuples.unlockRead();

			if(tuplesList != null) {
				return tuplesList;
			}
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		tuplesList = new ArrayList<Tuple>();
		return tuplesList;
	}

	// Ajoute le tuple dans la Hashtable des tuples
	private void addToTuples(Tuple t) {
		try {
			Integer tSize = t.size();

			ArrayList<Tuple> tuplesList = getTupleList(t);

			accesTuples.lockWrite();
			if(tuplesList.isEmpty()) {
				tuples.put(tSize, tuplesList);
			}
			tuplesList.add(t);
			accesTuples.unlockWrite();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	// Retourne la liste des callbacks abonnés à 'template' dans 'callbacksMap'
	private ArrayList<Callback> getCallbacks(Tuple template, HashMap<Tuple, ArrayList<Callback>> callbacksMap) {
		ArrayList<Callback> callbacks = null;

		try {
			accesCallbacks.lockRead();
			for(Tuple key : callbacksMap.keySet()) {
				if (template.matches(key)) {
					callbacks = callbacksMap.get(key);
					accesCallbacks.unlockRead();
					return callbacks;
				}
			}
			accesCallbacks.unlockRead();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		return callbacks;
	}

	@Override
	public void write(Tuple t) {
		nbQueries[2]++;
		executor.execute(new Runnable() {
			@Override
			public void run() {
				try {
					// Reveils des callbacks READ concernes
					ArrayList<Callback> cbList = getCallbacks(t, readCallbacks);
					accesCallbacks.lockRead();
					if (cbList != null && !cbList.isEmpty()) {
						ArrayList<Callback> toRemove = new ArrayList<>();
		
						for(Callback cb : cbList) {
							cb.call(t);
							toRemove.add(cb);
						}
		
						// Suppression des callbacks en mode Redacteur
						accesCallbacks.unlockRead();
						accesCallbacks.lockWrite();
						cbList.removeAll(toRemove);
						accesCallbacks.unlockWrite();
					} else {
						accesCallbacks.unlockRead();
					}
			
					// Reveil du plus ancien callback TAKE
					cbList = getCallbacks(t, takeCallbacks);
					accesCallbacks.lockRead();
					if (cbList != null && !cbList.isEmpty()){
						cbList.get(0).call(t);
		
						// Suppression du callback en mode Redacteur
						accesCallbacks.unlockRead();
						accesCallbacks.lockWrite();
						cbList.remove(0);
						accesCallbacks.unlockWrite();
					}
					accesCallbacks.unlockRead();
			
					// Aucun callback TAKE concerné : ajout du tuple à l'espace
					addToTuples(t);
				} catch(InterruptedException e) {
					e.printStackTrace();
				}
			}
		});
	}

	@Override
	public Tuple take(Tuple template) {
		Tuple alreadyPresent = this.tryTake(template);
		
		if (alreadyPresent == null) {
			// Recherche dans l'espace des tuples avec mode FUTURE
			SynchronousCallback cb = new SynchronousCallback();
			this.eventRegister(eventMode.TAKE, eventTiming.FUTURE, template, cb);

			// Attente du call
			synchronized(cb) {
				try {
					cb.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}

			// Reveil
			return cb.getResultat();
		} else {
			return alreadyPresent;
		}
	}

	@Override
	public Tuple read(Tuple template) {
		Tuple alreadyPresent = this.tryRead(template);

		if (alreadyPresent == null) {
			// Recherche dans l'espace des tuples avec mode FUTURE
			SynchronousCallback cb = new SynchronousCallback();
			this.eventRegister(eventMode.READ, eventTiming.FUTURE, template, cb);

			// Attente du call
			synchronized(cb) {
				try {
					cb.wait();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}

			// Reveil
			return cb.getResultat();
		} else {
			return alreadyPresent;
		}
	}

	@Override
	public Tuple tryTake(Tuple template) {
		nbQueries[0]++;
		Tuple tupleRes = null;

		Future<Tuple> future = executor.submit(new Callable<Tuple>() {
			@Override
			public Tuple call() throws Exception {
				// Recherche dans l'espace des tuples en mode Lecteur
				try {
					ArrayList<Tuple> tuplesList = getTupleList(template);
					
					accesTuples.lockRead();
					for (Tuple t : tuplesList) {
						if (t.matches(template)) {
							// Suppression du tuple en mode Redacteur
							accesTuples.unlockRead();
							accesTuples.lockWrite();
							tuplesList.remove(t);
							accesTuples.unlockWrite();
			
							return t;
						}
					}
					accesTuples.unlockRead();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				return null;
			}
		});

		try {
			tupleRes = future.get();
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}

		return tupleRes;
	}

	@Override
	public Tuple tryRead(Tuple template) {
		nbQueries[1]++;
		Tuple tupleRes = null;

		Future<Tuple> future = executor.submit(new Callable<Tuple>() {
			@Override
			public Tuple call() throws Exception {
				// Recherche dans l'espace des tuples en mode Lecteur
				try {
					ArrayList<Tuple> tuplesList = getTupleList(template);
		
					accesTuples.lockRead();
					for (Tuple t : tuplesList) {
						if (t.matches(template)) {
							accesTuples.unlockRead();
							return t;
						}
					}
					accesTuples.unlockRead();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
				return null;
			}
		});

		try {
			tupleRes = future.get();
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}

		return tupleRes;
	}

	@Override
	public Collection<Tuple> takeAll(Tuple template) {
		Collection<Tuple> tuplesRes = null;

		Future<Collection<Tuple>> future = executor.submit(new Callable<Collection<Tuple>>() {
			@Override
			public Collection<Tuple> call() throws Exception {
				ArrayList<Tuple> res = new ArrayList<>();
		
				// Recherche dans l'espace des tuples en mode Lecteur
				try {
					ArrayList<Tuple> tuplesList = getTupleList(template);
		
					accesTuples.lockRead();
					Iterator<Tuple> iter = tuplesList.iterator();
		
					while(iter.hasNext()) {
						Tuple t = iter.next();
		
						if (t.matches(template)) {
							res.add(t);
							// Suppression du tuple en mode Redacteur
							accesTuples.unlockRead();
							accesTuples.lockWrite();
							iter.remove();
							accesTuples.unlockWrite();
							accesTuples.lockRead();
						}
					}
					accesTuples.unlockRead();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
		
				return res;
			}
		});

		try {
			tuplesRes = future.get();
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}

		return tuplesRes;
	}

	@Override
	public Collection<Tuple> readAll(Tuple template) {
		Collection<Tuple> tuplesRes = null;

		Future<Collection<Tuple>> future = executor.submit(new Callable<Collection<Tuple>>() {
			@Override
			public Collection<Tuple> call() throws Exception {
				ArrayList<Tuple> res = new ArrayList<>();
		
				// Recherche dans l'espace des tuples
				try {
					ArrayList<Tuple> tuplesList = getTupleList(template);
		
					accesTuples.lockRead();
					for (Tuple t : tuplesList) {
						if (t.matches(template)) {
							res.add(t);
						}
					}
					accesTuples.unlockRead();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				
				return res;
			}
		});

		try {
			tuplesRes = future.get();
		} catch (InterruptedException | ExecutionException e) {
			e.printStackTrace();
		}

		return tuplesRes;
	}

	@Override
	public void eventRegister(eventMode mode, eventTiming timing, Tuple template, Callback callback) {
		Tuple res = null;
		ArrayList<Callback> cbList = null;
		if (timing == eventTiming.IMMEDIATE) {
			if (mode == eventMode.READ) {
				res = tryRead(template);
			} else if (mode == eventMode.TAKE) {
				res = tryTake(template);
			}
		}

		// Aucune correspondance : enregistrement du callback
		if (res == null) {
			if (mode == eventMode.READ) {
				try {
					// Obtention des callbacks read en mode Lecteur
					accesCallbacks.lockRead();
					cbList = readCallbacks.get(template);
					accesCallbacks.unlockRead();
	
					// Mise a jour en mode Redacteur
					accesCallbacks.lockWrite();
					if (cbList == null) {
						readCallbacks.put(template,new ArrayList<>(Arrays.asList(callback)));
					} else {
						cbList.add(callback);
					}
					accesCallbacks.unlockWrite();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			} else if (mode == eventMode.TAKE){
				try {
					// Obtention des callbacks take en mode Lecteur
					accesCallbacks.lockRead();
					cbList = takeCallbacks.get(template);
					accesCallbacks.unlockRead();
	
					// Mise a jour en mode Redacteur
					accesCallbacks.lockWrite();
					if (cbList == null) {
						takeCallbacks.put(template,new ArrayList<>(Arrays.asList(callback)));
					} else {
						cbList.add(callback);
					}
					accesCallbacks.unlockWrite();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		// Correspondance : reveil du callback
		} else {
			callback.call(res);
		}
	}

	// Instrumentation

	// Affiche les Tuples stockés
	@Override
	public void debug(String prefix) {
		StringBuilder sb = new StringBuilder(prefix + " Tuples : ");
		
		try {
			accesTuples.lockRead();
			if (tuples.isEmpty()) {
				sb.append("No Tuples stored");
			} else {
				sb.append(tuples.toString());
			}
			accesTuples.unlockRead();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		System.out.println(sb.toString());
	}

	@Override
	public String status() {
		StringBuilder sb = new StringBuilder();
		String format = "%-12s %s\n";

		// Header
		sb.append("Linda Core : " + type() + "\n"
			+ "---------------------------\n");
		// Tuple space
		sb.append(String.format(format, "Tuples:", getTupleSpaceState()));
		// Queries
		sb.append(String.format(format, "Queries:", getQueriesState()));
		// Callbacks
		sb.append(String.format(format, "Callbacks:", getCallbackState()));
		// Threads
		sb.append(String.format(format, "Threads:", getThreadState()));

		return sb.toString();
	}

	@Override
	public String type() {
		return Linda.TYPE_PARALLEL;
	}

	// Status & informations

	private String getQueriesState() {
		StringBuilder sb = new StringBuilder();

		sb.append(String.format("%-8s %d\n", "TAKE", nbQueries[0]));
		sb.append(String.format("%12s %-8s %d\n", "", "READ", nbQueries[1]));
		sb.append(String.format("%12s %-8s %d", "", "WRITE", nbQueries[2]));

		return sb.toString();
	}

	private String getTupleSpaceState() {
		int res = 0;

		try {
			accesTuples.lockRead();
			for(ArrayList<Tuple> t : tuples.values()) {
				res += t.size();
			}
			accesTuples.unlockRead();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		return String.valueOf(res);
	}

	private String getCallbackState() {
		StringBuilder sb = new StringBuilder();
		int[] res = {0, 0}; // 0: Take, 1: Read
		
		try {
			accesCallbacks.lockRead();
			for(ArrayList<Callback> c : takeCallbacks.values()) {
				res[0] += c.size();
			}
			
			for(ArrayList<Callback> c : readCallbacks.values()) {
				res[1] += c.size();
			}
			accesCallbacks.unlockRead();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		sb.append(String.format("%-8s %d\n", "TAKE", res[0]));
		sb.append(String.format("%12s %-8s %d", "", "READ", res[1]));

		return sb.toString();
	}

	private String getThreadState() {
		StringBuilder sb = new StringBuilder();
		Set<Thread> threadSet = Thread.getAllStackTraces().keySet();
		int i = 0;
		for (Thread t : threadSet) {
			if (t.getThreadGroup().getName().equals("main")) {
				if(i != 0) {
					sb.append(String.format("%12s %-20s %s\n", "", t.getName(), t.getState()));
				} else {
					sb.append(String.format("%-20s %s\n", t.getName(), t.getState()));
				}
				i++;
			}
		}

		return sb.toString();
	}
}
