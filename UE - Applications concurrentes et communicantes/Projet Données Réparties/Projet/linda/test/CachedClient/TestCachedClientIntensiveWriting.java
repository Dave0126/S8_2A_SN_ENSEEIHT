package linda.test.CachedClient;

import linda.Tuple;
import linda.cache.LindaCachedClient;

public class TestCachedClientIntensiveWriting {

    // Launch a thread writing nbWriting elements 
    private static void launchWriter(int nbWriting) {
        LindaCachedClient lindaClient = new linda.cache.LindaCachedClient("//localhost:4000/LindaServer");

        new Thread() {
            public void run() {
                long startTime = System.nanoTime();
                for(int i = 0; i < nbWriting; i++){
                    lindaClient.write(new Tuple(i));
                }
                long time = System.nanoTime() - startTime;
                System.out.println(time * Math.pow(10, -9));
            }
        }.start();
    }

    public static void main(String[] args) {


        int nbWriting = 100000;
        int nbWriter = 30;

        for(int i = 0; i < nbWriter; i++){
            launchWriter(nbWriting);
        }
    }
}
