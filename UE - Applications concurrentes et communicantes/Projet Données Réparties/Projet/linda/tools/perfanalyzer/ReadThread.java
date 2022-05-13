package linda.tools.perfanalyzer;

import linda.Linda;
import linda.Tuple;

public class ReadThread extends Thread {
    private Linda linda;
    private int nbRead;
    private Tuple target;
    private Metrics metrics;

    public ReadThread(Linda linda, int nbRead, Tuple target, Metrics metrics) {
        this.linda = linda;
        this. nbRead = nbRead;
        this.target = target;
        this.metrics = metrics;
    }

    public void run() {
        double totalResponseTime = 0f;
        double totalTime = 0f;
        long successfullReads = 0;
        int throughput = 0;
        long oneSecChrono = 0;
        
        System.out.println("Sending Read queries...");

        long startOneSecChrono = System.nanoTime();
        for(int i = 0 ; i < nbRead ; i++) {
            long startRead = System.nanoTime();
            Tuple result = linda.tryRead(target);
            long endRead = System.nanoTime();
            
            double durationRead = (endRead - startRead) / 1000000f;
            
            // Successful read
            if(result != null) {
                successfullReads++;
                totalResponseTime += durationRead;
                
                // Updating Response Time
                if(durationRead < metrics.readResponseTime[Metrics.MINIMUM]
                || metrics.readResponseTime[Metrics.MINIMUM] < 0) {
                    metrics.readResponseTime[Metrics.MINIMUM] = durationRead;
                }
                if(durationRead > metrics.readResponseTime[Metrics.MAXIMUM]
                || metrics.readResponseTime[Metrics.MAXIMUM] < 0) {
                    metrics.readResponseTime[Metrics.MAXIMUM] = durationRead;
                }

                // Saving value
                metrics.readResponseTimeValues.add(durationRead);
            }

            long endOneSecChrono = System.nanoTime();
            oneSecChrono = endOneSecChrono - startOneSecChrono;
            if((oneSecChrono/1000000000f) >= 1f
            || i == nbRead - 1) {
                totalTime += oneSecChrono;
                throughput = i - throughput; // number of queries in 1 sec
                
                // Updating Throughput
                if(throughput < metrics.readThroughput[Metrics.MINIMUM]
                || metrics.readThroughput[Metrics.MINIMUM] < 0) {
                    metrics.readThroughput[Metrics.MINIMUM] = throughput;
                }
                if(throughput > metrics.readThroughput[Metrics.MAXIMUM]
                || metrics.readThroughput[Metrics.MAXIMUM] < 0) {
                    metrics.readThroughput[Metrics.MAXIMUM] = throughput;
                }

                // Restarting chrono
                startOneSecChrono = endOneSecChrono;
                oneSecChrono = 0;
            }

            // Saving values
            metrics.readSuccessValues.add(successfullReads);
            metrics.readThroughputValues.add(throughput);
        }

        System.out.println("Sending Read queries done.");

        metrics.readResponseTime[Metrics.AVERAGE] = (successfullReads != 0) ?
            (totalResponseTime / successfullReads) : (-1f);

        metrics.readSuccess = successfullReads;

        totalTime = (totalTime / 1000000000f);
        if(totalTime < 1f) {
            metrics.readThroughput[Metrics.AVERAGE] = nbRead;
            metrics.readThroughput[Metrics.MINIMUM] = nbRead;
            metrics.readThroughput[Metrics.MAXIMUM] = nbRead;
        } else {
            metrics.readThroughput[Metrics.AVERAGE] = (int) (nbRead / totalTime);
        }
    }
}
