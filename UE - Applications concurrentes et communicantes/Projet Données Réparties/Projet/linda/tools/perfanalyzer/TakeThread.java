package linda.tools.perfanalyzer;

import linda.Linda;
import linda.Tuple;

public class TakeThread extends Thread {
    private Linda linda;
    private int nbTake;
    private Tuple target;
    private Metrics metrics;

    public TakeThread(Linda linda, int nbTake, Tuple target, Metrics metrics) {
        this.linda = linda;
        this.nbTake = nbTake;
        this.target = target;
        this.metrics = metrics;
    }

    public void run() {
        double totalResponseTime = 0f;
        double totalTime = 0f;
        long successfullTakes = 0;
        int throughput = 0;
        long oneSecChrono = 0;
        
        System.out.println("Sending Take queries...");

        long startOneSecChrono = System.nanoTime();
        for(int i = 0 ; i < nbTake ; i++) {
            long startTake = System.nanoTime();
            Tuple result = linda.tryTake(target);
            long endTake = System.nanoTime();
            
            double durationTake = (endTake - startTake) / 1000000f;
            
            // Successful Take
            if(result != null) {
                successfullTakes++;
                totalResponseTime += durationTake;
                
                // Updating Response Time
                if(durationTake < metrics.takeResponseTime[Metrics.MINIMUM]
                || metrics.takeResponseTime[Metrics.MINIMUM] < 0) {
                    metrics.takeResponseTime[Metrics.MINIMUM] = durationTake;
                }
                if(durationTake > metrics.takeResponseTime[Metrics.MAXIMUM]
                || metrics.takeResponseTime[Metrics.MAXIMUM] < 0) {
                    metrics.takeResponseTime[Metrics.MAXIMUM] = durationTake;
                }

                // Saving value
                metrics.takeResponseTimeValues.add(durationTake);
            }

            long endOneSecChrono = System.nanoTime();
            oneSecChrono = endOneSecChrono - startOneSecChrono;
            if((oneSecChrono/1000000000f) >= 1f
            || i == nbTake - 1) {
                totalTime += oneSecChrono;
                throughput = i - throughput; // number of queries in 1 sec
                
                // Updating Throughput
                if(throughput < metrics.takeThroughput[Metrics.MINIMUM]
                || metrics.takeThroughput[Metrics.MINIMUM] < 0) {
                    metrics.takeThroughput[Metrics.MINIMUM] = throughput;
                }
                if(throughput > metrics.takeThroughput[Metrics.MAXIMUM]
                || metrics.takeThroughput[Metrics.MAXIMUM] < 0) {
                    metrics.takeThroughput[Metrics.MAXIMUM] = throughput;
                }

                // Restarting chrono
                startOneSecChrono = endOneSecChrono;
                oneSecChrono = 0;
            }

            // Saving values
            metrics.takeSuccessValues.add(successfullTakes);
            metrics.takeThroughputValues.add(throughput);
        }

        System.out.println("Sending Take queries done.");

        metrics.takeResponseTime[Metrics.AVERAGE] = (successfullTakes != 0) ?
        (totalResponseTime / successfullTakes) : (-1f);

        metrics.takeSuccess = successfullTakes;

        totalTime = (totalTime / 1000000000f);
        if(totalTime < 1f) {
            metrics.takeThroughput[Metrics.AVERAGE] = nbTake;
            metrics.takeThroughput[Metrics.MINIMUM] = nbTake;
            metrics.takeThroughput[Metrics.MAXIMUM] = nbTake;
        } else {
            metrics.takeThroughput[Metrics.AVERAGE] = (int) (nbTake / totalTime);
        }
    }
}
