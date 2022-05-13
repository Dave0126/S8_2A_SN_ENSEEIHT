package linda.cache;

import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.Collection;

import linda.Callback;
import linda.Linda;
import linda.Tuple;
import linda.server.LindaClient;
import linda.server.RemoteCallback;
import linda.server.RemoteCallbackImpl;

/** Client part of a client/server implementation of Linda.
 * It implements the Linda interface and propagates everything to the server it is connected to.
 * */
public class LindaCachedClient extends LindaClient {
    public LindaClientCache cache;
    private LindaCachedServer server;

    private class InvalidateCallBack implements Callback {
        private LindaClientCache cache;

        public InvalidateCallBack(LindaClientCache cache){
            this.cache = cache;
        }

        public void call(Tuple t) {
            cache.invalidate(t);
        }
    }

    /** Initializes the Linda implementation.
     *  @param serverURI the URI of the server, e.g. "rmi://localhost:4000/LindaServer" or "//localhost:4000/LindaServer".
     */
    public LindaCachedClient(String serverURL) {
        super(serverURL);
        try {
            this.server = (LindaCachedServer) Naming.lookup(serverURL);
            this.cache = new LindaClientCache();
            this.server.clientRegister(new RemoteCallbackImpl(new InvalidateCallBack(cache)));
        } catch (MalformedURLException | RemoteException | NotBoundException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void write(Tuple t) {
        try {
            cache.write(t);
            server.write(t);
        } catch (RemoteException e) {
            System.out.println("Echec write");
            e.printStackTrace();
        }
    }

    @Override
    public Tuple take(Tuple template) {
        Tuple res = null;
        try {
            res = server.take(template);
        } catch (RemoteException e) {
            System.out.println("Echec take");
            e.printStackTrace();
        }

        return res;
    }

    @Override
    public Tuple read(Tuple template) {
        Tuple res = null;
        try {
            res = cache.tryRead(template);
            if(res == null) {
                res = server.read(template);
                cache.write(res);
            }
        } catch (RemoteException e) {
            System.out.println("Echec read");
            e.printStackTrace();
        }

        return res;
    }

    @Override
    public Tuple tryTake(Tuple template) {
        Tuple res = null;
        try {
            res = server.tryTake(template);
        } catch (RemoteException e) {
            System.out.println("Echec tryTake");
            e.printStackTrace();
        }

        return res;
    }

    @Override
    public Tuple tryRead(Tuple template) {
        Tuple res = null;
        try {
            res = cache.tryRead(template);
            if(res == null) {
                res = server.tryRead(template);

                if(res != null) {
                    cache.write(res);
                }
            }
        } catch (RemoteException e) {
            System.out.println("Echec tryRead");
            e.printStackTrace();
        }

        return res;
    }

    @Override
    public Collection<Tuple> takeAll(Tuple template) {
        Collection<Tuple> res = null;
        try {
            res = server.takeAll(template);
        } catch (RemoteException e) {
            System.out.println("Echec takeAll");
            e.printStackTrace();
        }

        return res;
    }

    @Override
    public Collection<Tuple> readAll(Tuple template) {
        Collection<Tuple> res = null;
        try {
            res = server.readAll(template);
            if(res != null) {
                cache.write(res);
            }
        } catch (RemoteException e) {
            System.out.println("Echec readAll");
            e.printStackTrace();
        }

        return res;
    }

    @Override
    public void eventRegister(eventMode mode, eventTiming timing, Tuple template, Callback callback) {
        // Thread d'abonnement pour éviter bloquage du client
        Thread waitForResult = new Thread() {
            public void run() {
                try {
                    RemoteCallback remoteCallback = new RemoteCallbackImpl(callback);
                    server.eventRegister(mode, timing, template, remoteCallback);
                } catch (RemoteException e) {
                    System.out.println("Echec eventRegister");
                    e.printStackTrace();
                }
            }
        };

        waitForResult.start();
    }

    @Override
    public String status() {
        String res = null;
        try {
            res = server.status();
        } catch (Exception e) {
            System.out.println("Echec status");
            e.printStackTrace();
        }

        return res;
    }

    @Override
    public void debug(String prefix) {
        try {
            server.debug(prefix);
        } catch (RemoteException e) {
            System.out.println("Echec debug");
            e.printStackTrace();
        }
    }

    @Override
    public String type() {
        String res = null;

        try {
            res = server.type();
        } catch (RemoteException e) {
            System.out.println("Echec type");
            e.printStackTrace();
        }

        return res;
    }

}
