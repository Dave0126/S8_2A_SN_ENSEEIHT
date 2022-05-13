package linda.cache;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Hashtable;
import java.util.List;

import linda.Tuple;

public class LindaClientCache {
    private Hashtable<Integer, ArrayList<Tuple>> tuples;

    public LindaClientCache() {
        this.tuples = new Hashtable<Integer, ArrayList<Tuple>>();
    }

    // Retourne la liste des tuples correspondant a la taille du template
	// ou une liste vide si l'entree n'existe pas
	private ArrayList<Tuple> getTupleList(Tuple template) {
		Integer tSize = template.size();
		ArrayList<Tuple> tuplesList = null;

		tuplesList = tuples.get(tSize);

		if(tuplesList != null) {
			return tuplesList;
		}

		tuplesList = new ArrayList<Tuple>();

		return tuplesList;
	}

    public void write(Tuple t) {
        ArrayList<Tuple> tupleList = getTupleList(t);

        if(tupleList.isEmpty()) {
            this.tuples.put(t.size(), tupleList);
        }

        tupleList.add(t);
    }

    public void write(Collection<Tuple> tuples) {
        List<Tuple> tuplesToList = Arrays.asList((Tuple[])tuples.toArray());
        ArrayList<Tuple> tupleList = getTupleList(tuplesToList.get(0));

        if(tupleList.isEmpty()) {
            this.tuples.put(tuplesToList.get(0).size(), tupleList);
        }

        for(Tuple t : tuplesToList) {
            tupleList.add(t);
        }
    }
    
    public Tuple tryRead(Tuple template) {
		ArrayList<Tuple> tuplesList = getTupleList(template);

		for (Tuple t : tuplesList) {
			if (t.matches(template)) {
				return t;
			}
		}
		
		return null;
	}

    public void invalidate(Tuple t) {
        ArrayList<Tuple> tupleList = getTupleList(t);

        tupleList.remove(t);
    }

    public void debug(String prefix) {
		StringBuilder sb = new StringBuilder(prefix + " Tuples in cache: ");

		if (tuples.isEmpty()) {
			sb.append("No Tuples stored in cache");
		} else {
            sb.append(tuples.toString());
        }

		System.out.println(sb.toString());
	}
}
