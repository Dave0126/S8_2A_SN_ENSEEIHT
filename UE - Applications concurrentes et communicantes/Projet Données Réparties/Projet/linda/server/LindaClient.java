package linda.server;

import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;
import java.util.Collection;

import linda.Callback;
import linda.Linda;
import linda.Tuple;

/** Client part of a client/server implementation of Linda.
 * It implements the Linda interface and propagates everything to the server it is connected to.
 * */
public class LindaClient implements Linda {

    protected LindaServer server;

    /** Initializes the Linda implementation.
     *  @param serverURI the URI of the server, e.g. "rmi://localhost:4000/LindaServer" or "//localhost:4000/LindaServer".
     */
    public LindaClient(String serverURL) {
        try {
            this.server = (LindaServer) Naming.lookup(serverURL);
        } catch (MalformedURLException | RemoteException | NotBoundException e) {
            System.err.println("Linda Client could not connect to server on " + serverURL);
            System.exit(0);
        }
    }

    @Override
    public void write(Tuple t) {
        try {
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
            res = server.read(template);
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
            res = server.tryRead(template);
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
