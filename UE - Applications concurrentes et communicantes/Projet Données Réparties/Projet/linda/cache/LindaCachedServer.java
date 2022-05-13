package linda.cache;

import java.rmi.RemoteException;

import linda.Tuple;
import linda.server.LindaServer;
import linda.server.RemoteCallback;

public interface LindaCachedServer extends LindaServer {
    /**
     * Register client callback in order to keep the cache up to date.
     * @param cb
     */
    public void clientRegister(RemoteCallback cb) throws RemoteException;

    /**
     * Cache invalidation protocol of a Tuple among connected clients
     * @param t
     */
    public void invalidate(Tuple t) throws RemoteException;
}
