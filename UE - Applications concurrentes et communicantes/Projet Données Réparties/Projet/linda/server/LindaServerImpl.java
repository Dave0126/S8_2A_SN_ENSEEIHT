package linda.server;

import linda.Linda;
import linda.Tuple;
import linda.Linda.eventMode;
import linda.Linda.eventTiming;
import linda.shm.CentralizedLinda;
import linda.shm.CentralizedLinda2;

import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.ArrayList;
import java.util.Collection;

public class LindaServerImpl extends UnicastRemoteObject implements LindaServer {
    protected String type;
    protected String url;
	protected Linda localLinda;
    protected Collection<LindaServer> neighbors;
    protected boolean hasNeighbors;

    private long startTime;

    public LindaServerImpl(String lindaType, String url, Collection<LindaServer> neighbors) throws RemoteException {
        switch (lindaType) {
            case Linda.TYPE_BASIC:
                localLinda = new CentralizedLinda();
                break;
            case Linda.TYPE_PARALLEL:
                localLinda = new CentralizedLinda2();
                break;
            default:
                break;
        }

        this.type = lindaType;
        this.url = url;

        if(neighbors != null) {
            this.neighbors = new ArrayList<>(neighbors);
            this.hasNeighbors = (neighbors.size() != 0);
        } else {
            this.neighbors = new ArrayList<>();
            this.hasNeighbors = false;
        }

        this.startTime = System.currentTimeMillis();;
    }

    @Override
    public void write(Tuple t) throws RemoteException {
        localLinda.write(t);
    }

    @Override
    public Tuple take(Tuple template) throws RemoteException {
        Tuple res = localLinda.tryTake(template);

        // Asking neighbors if available
        if(res == null && hasNeighbors) {
            for(LindaServer neigh : neighbors) {
                res = neigh.tryTake(template);
                if (res != null) {
                    return res;
                }
            }
        }

        return localLinda.take(template);
    }

    @Override
    public Tuple read(Tuple template) throws RemoteException {
        Tuple res = localLinda.tryRead(template);
        
        // Asking neighbors if available
        if(res == null) {
            for(LindaServer neigh : neighbors) {
                res = neigh.tryRead(template);
                if (res != null) {
                    return res;
                }
            }
        }

        return localLinda.read(template);
    }

    @Override
    public Tuple tryTake(Tuple template) throws RemoteException {
        return localLinda.tryTake(template);
    }

    @Override
    public Tuple tryRead(Tuple template) throws RemoteException {
        return localLinda.tryRead(template);
    }

    @Override
    public Collection<Tuple> takeAll(Tuple template) throws RemoteException {
        return localLinda.takeAll(template);
    }

    @Override
    public Collection<Tuple> readAll(Tuple template) throws RemoteException {
        return localLinda.readAll(template);
    }

    @Override
    public void eventRegister(eventMode mode, eventTiming timing, Tuple template, RemoteCallback remoteCallback) throws RemoteException {
        localLinda.eventRegister(mode, timing, template, new ServerAsynchronousCallback(remoteCallback));
    }

    @Override
    public void addNeighbor(LindaServer neighbor) {
        if(!neighbors.contains(neighbor)) {
            neighbors.add(neighbor);
            hasNeighbors = true;
        }
    }

    @Override
    public String status() throws RemoteException {
		StringBuilder sb = new StringBuilder();
		String format = "%-12s %s\n";

		// Header
		sb.append(url + "\n"
        + "---------------------------\n");

        // Time alive
		sb.append(String.format(format, "Time alive:", getTimeAliveState()));

        // Neighbors
        sb.append(String.format(format, "Neighbors:", getNeighborsState()));
        
        // Footer
		sb.append("\n");

        // Linda Core
        sb.append(localLinda.status());

        return sb.toString();
    }

    @Override
    public void debug(String prefix) throws RemoteException {
        localLinda.debug(prefix);
    }

    @Override
    public String type() throws RemoteException {
        return type;
    }

    @Override
    public String getUrl() throws RemoteException {
        return url;
    }

    // Status & informations
    private String getTimeAliveState() {
		int secSinceStart = (int) ((System.currentTimeMillis() - startTime) / 1000);
		return String.format("%d:%02d:%02d", secSinceStart / 3600, (secSinceStart % 3600) / 60, (secSinceStart % 60));
	}

    private String getNeighborsState() {
        if(!hasNeighbors) {
            return "No neighbors";
        }

		StringBuilder sb = new StringBuilder();
        try {
            int i = 0;
            for (LindaServer neigh : neighbors) {
                String neighUrl = neigh.getUrl();
                if(i == 0) {
                    sb.append(String.format("%s\n", neighUrl));
                } else {
                    sb.append(String.format("%12s %s\n", "", neighUrl));
                }
                i++;
            }
        } catch (RemoteException e) {
            e.printStackTrace();
        }

        return sb.toString();
	}
}