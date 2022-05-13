package linda.tools.perfanalyzer;

import linda.Linda;
import linda.Tuple;

public class WriteThread extends Thread {
    private Linda linda;
    private int nbWrite;
    private Tuple target;
    private Metrics metrics;
    
    public WriteThread(Linda linda, int nbWrite, Tuple target, Metrics metrics) {
        this.linda = linda;
        this.nbWrite = nbWrite;
        this.target = target;
        this.metrics = metrics;
    }

    public void run() {
        double totalTime = 0f;
        int throughput = 0;
        long oneSecChrono = 0;

        System.out.println("Sending Write queries...");

        long startOneSecChrono = System.nanoTime();
        for(int i = 0 ; i < nbWrite ; i++) {
            linda.write(target);

            long endOneSecChrono = System.nanoTime();
            oneSecChrono = endOneSecChrono - startOneSecChrono;
            if((oneSecChrono/1000000000f) >= 1f
            || i == nbWrite - 1) {
                totalTime += oneSecChrono;
                throughput = i - throughput; // number of queries in 1 sec
                
                // Updating Throughput
                if(throughput < metrics.writeThroughput[Metrics.MINIMUM]
                || metrics.writeThroughput[Metrics.MINIMUM] < 0) {
                    metrics.writeThroughput[Metrics.MINIMUM] = throughput;
                }
                if(throughput > metrics.writeThroughput[Metrics.MAXIMUM]
                || metrics.writeThroughput[Metrics.MAXIMUM] < 0) {
                    metrics.writeThroughput[Metrics.MAXIMUM] = throughput;
                }

                // Restarting chrono
                startOneSecChrono = endOneSecChrono;
                oneSecChrono = 0;
            }
            
            // Saving values
            metrics.writeThroughputValues.add(throughput);
        }

        System.out.println("Sending Write queries done.");

        totalTime = (totalTime / 1000000000f);
        if(totalTime < 1f) {
            metrics.writeThroughput[Metrics.AVERAGE] = nbWrite;
            metrics.writeThroughput[Metrics.MINIMUM] = nbWrite;
            metrics.writeThroughput[Metrics.MAXIMUM] = nbWrite;
        } else {
            metrics.writeThroughput[Metrics.AVERAGE] = (int) (nbWrite / totalTime);
        }
    }
}
