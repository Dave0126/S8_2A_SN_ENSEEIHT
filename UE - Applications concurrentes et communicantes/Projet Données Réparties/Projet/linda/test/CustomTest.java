package linda.test;

import linda.Tuple;
import linda.cache.LindaCachedClient;


public class CustomTest {

    public static void main(String[] a) {
        final LindaCachedClient linda = new linda.cache.LindaCachedClient("//localhost:4000/LindaServer");

        new Thread() {
            public void run() {
                LindaCachedClient lindaClient2 = new linda.cache.LindaCachedClient("//localhost:4000/LindaServer");

                lindaClient2.write(new Tuple(5));

                lindaClient2.debug("ServerCleint2");
                lindaClient2.cache.debug("CacheClient2");
            }
        }.start();

        new Thread() {
            public void run() {
                Tuple t = null;

                linda.cache.write(new Tuple("ok"));

                linda.debug("Server");
                linda.cache.debug("Cache");

                Tuple motifClient2 = new Tuple(Integer.class);
                Tuple motif = new Tuple(Integer.class, String.class);
                Tuple motifCache = new Tuple(String.class);


                linda.write(new Tuple(5, "ecriture"));

                linda.debug("Server");
                linda.cache.debug("Cache");

                t = linda.read(motif);
                System.out.println("Got from cache : " + t);

                t = linda.read(motifCache);
                System.out.println("Got from cache : " + t);

                t = linda.read(motifClient2);
                System.out.println("Got from serveur : " + t);

            }
        }.start();
    }
}
