package linda.test.CachedClient;

import linda.Tuple;
import linda.cache.LindaCachedClient;

public class TestCachedClient {
    public static void main(String[] args) {

        LindaCachedClient lindaClient1 = new LindaCachedClient("//localhost:4000/LindaServer");;
        LindaCachedClient lindaClient2 = new LindaCachedClient("//localhost:4000/LindaServer");;

        new Thread() {
            public void run() {
                lindaClient2.write(new Tuple(5));
                lindaClient2.write(new Tuple(7));

                lindaClient2.debug("ServerCleint2");
                lindaClient2.cache.debug("CacheClient2");                
            }
        }.start();

        new Thread() {
            public void run() {

                try {
                    Thread.sleep(2);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                lindaClient1.read(new Tuple(5));
                
                lindaClient1.cache.debug("CacheClient1 after read");
                lindaClient2.cache.debug("CacheClient2 after read");

                lindaClient1.take(new Tuple(5));

                lindaClient1.debug("ServerCleint1");
                lindaClient2.cache.debug("CacheClient2 after take");
            }
        }.start();
    }
}
