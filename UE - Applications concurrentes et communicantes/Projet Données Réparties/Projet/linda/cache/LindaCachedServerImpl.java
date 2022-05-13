package linda.cache;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Collection;

import linda.Linda;
import linda.Tuple;
import linda.server.LindaServer;
import linda.server.LindaServerImpl;
import linda.server.RemoteCallback;

public class LindaCachedServerImpl extends LindaServerImpl implements LindaCachedServer {

    private ArrayList<RemoteCallback> cachedClients;

    public LindaCachedServerImpl(String url, Collection<LindaServer> neighbors) throws RemoteException {
        super(Linda.TYPE_BASIC, url, neighbors);
        cachedClients = new ArrayList<RemoteCallback>();
    }

    @Override
    public Tuple take(Tuple template) throws RemoteException {
        Tuple res = super.take(template);
        invalidate(res);
        return res;
    }

    @Override
    public Tuple tryTake(Tuple template) throws RemoteException {
        Tuple res = super.tryTake(template);
        if(res != null) {
            invalidate(res);
        }

        return res;
    }

    @Override
    public Collection<Tuple> takeAll(Tuple template) throws RemoteException {
        Collection<Tuple> res = super.takeAll(template);
        for (Tuple t : res) {
            if(t != null) {
                invalidate(t);
            }
        }

        return res;
    }

    @Override
    public void clientRegister(RemoteCallback cb) throws RemoteException {
        cachedClients.add(cb);
    }

    @Override
    public void invalidate(Tuple t) throws RemoteException {
        for(RemoteCallback rCb : cachedClients) {
            rCb.call(t);
        }
    }

    @Override
    public String type() throws RemoteException {
        return Linda.TYPE_CACHE;
    }
}
