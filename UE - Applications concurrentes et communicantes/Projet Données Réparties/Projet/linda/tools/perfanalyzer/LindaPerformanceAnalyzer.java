package linda.tools.perfanalyzer;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

import linda.Linda;
import linda.Tuple;
import linda.cache.LindaCachedClient;
import linda.server.LindaClient;
import linda.shm.CentralizedLinda;

public class LindaPerformanceAnalyzer {
    private Metrics metrics;
    private int nbQueries;
    private int nbTake;
    private int nbRead;
    private int nbWrite;
    private Linda linda;
    private ArrayList<Thread> runningThreads;

    public LindaPerformanceAnalyzer(Linda linda) {
        this.linda = linda;
        this.metrics = new Metrics();
        this.nbQueries = 0;
        this.runningThreads = new ArrayList<>();
    }

    // MAIN SCRIPT --------------------------------------------------
    // Example of usage
    public static void main(String[] args) {
        String url = null;
        
        // PARSING ARGUMENTS 
        if(args.length == 5) {
            url = args[4];
        } else if (args.length != 4) {
            System.out.println("\nUsage: NbQueries %Take %Read %Write Url");
            System.out.println("If 'Url' not specified, will run on local Linda.");
            return;
        }
        
        // NbQueries
        int nbQueries;
        try {
            nbQueries = Integer.parseInt(args[0]);
        } catch (Exception e) {
            System.out.println("Please provide a valid integer value for NbQueries.");
            return;
        }
        
        // Percentages
        int pTake;
        int pRead;
        int pWrite;
        try {
            pTake = Integer.parseInt(args[1]);
            pRead = Integer.parseInt(args[2]);
            pWrite = Integer.parseInt(args[3]);
            
            if((pTake + pRead + pWrite != 100)) {
                System.out.println("Sum of percentages must be 100.");
                return;
            };
        } catch (Exception e) {
            System.out.println("Please provide a valid integer value for percentages.");
            return;
        }
        
        // Linda Type
        LindaPerformanceAnalyzer perfAnalyzer;
        Linda linda;
        
        if(url != null) {
            linda = new LindaClient(url);
    
            if(linda.type().equals(Linda.TYPE_CACHE)) {
                linda = new LindaCachedClient(url);
            }
        } else {
            linda = new CentralizedLinda();
        }
        
        perfAnalyzer = new LindaPerformanceAnalyzer(linda);

        // STARTING ANALYSIS
        String output = "/home/tdesprat/Documents/2A/TP_DONREP/Projet-Linda/linda/tools/perfanalyzer/report_date";
        perfAnalyzer.startAnalysis(nbQueries, pTake, pRead, pWrite, output);
    }

    // METHODS --------------------------------------------------------
    // Tools offered by Performance Analyzer
    public void startAnalysis(int nbQueries, int percTake, int percRead, int percWrite, String outputDir) {
        Tuple tuple = new Tuple("test", 1);

        this.nbTake = (int) ((percTake/100f) * nbQueries);
        this.nbRead = (int) ((percRead/100f) * nbQueries);
        this.nbWrite = (int) ((percWrite/100f) * nbQueries);
        this.nbQueries = nbTake + nbRead + nbWrite;

        // Starting threads
        if(nbTake != 0) {
            startTakeThread(linda, nbTake, tuple);
        }
        if(nbRead != 0) {
            startReadThread(linda, nbRead, tuple);
        }
        if(nbWrite != 0) {
            startWriteThread(linda, nbWrite, tuple);
        }

        // Waiting threads finition
        long start = System.nanoTime();
        for(int i = 0 ; i < runningThreads.size(); i++) {
            try {
                runningThreads.get(i).join();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        metrics.totalDuration = (System.nanoTime() - start) / 1000000f;

        // Computing memory usage
        startMemoryUsageComputation();

        // Printing results/metrics
        printAnalysisResult();

        // Cleaning server
        startServerClean(linda, tuple);

        // Generating output if required
        if(outputDir != null) {
            generateOutput(outputDir);
        }
    }

    // Starts a Thread running nbTake Take queries on specified Linda
    private void startTakeThread(Linda linda, int nbTake, Tuple target) {
        Thread takeThread = new TakeThread(linda, nbTake, target, metrics);

        runningThreads.add(takeThread);

        takeThread.start();
    }
    
    // Starts a Thread running nbRead Read queries on specified Linda
    private void startReadThread(Linda linda, int nbRead, Tuple target) {
        Thread readThread = new ReadThread(linda, nbRead, target, metrics);
        
        runningThreads.add(readThread);
        
        readThread.start();
    }

    // Starts a Thread running nbWrite Write queries on specified Linda
    private void startWriteThread(Linda linda, int nbWrite, Tuple target) {
        // Metrics
        Thread writeThread = new WriteThread(linda, nbWrite, target, metrics);

        runningThreads.add(writeThread);

        writeThread.start();
    }

    private void startMemoryUsageComputation() {
        int oneMB = 1024 * 1024;

        Runtime runtime = Runtime.getRuntime();
        metrics.memoryMax = runtime.maxMemory() / oneMB;
        metrics.memoryUsed = (runtime.totalMemory() - runtime.freeMemory()) / oneMB;
        metrics.memoryUsedPercent = (metrics.memoryUsed * 100f) / metrics.memoryMax;
    }

    private <T> void printMetricData(String metricName, String format, String unit, T[] metricData) {
        String formattedAvg;
        String formattedMin;
        String formattedMax;

        formattedAvg = String.format("avg="+format+" "+unit, metricData[Metrics.AVERAGE]);
        formattedMin = String.format("min="+format+" "+unit, metricData[Metrics.MINIMUM]);
        formattedMax = String.format("max="+format+" "+unit, metricData[Metrics.MAXIMUM]);
        System.out.format("%-24s %-16s %-16s %-16s", metricName, formattedAvg, formattedMin, formattedMax);
        System.out.println();
    }

    private void printAnalysisResult() {
        String formattedData;
        Integer[] intData;
        Double[] doubleData;

        System.out.println();
        System.out.println("---------------------------------------------------------------------------");
        System.out.println("Linda Performance Analyzer");
        System.out.println("Sent " + nbQueries + " queries in " + String.format("%.3f", metrics.totalDuration) + "ms (" 
        + nbTake + " Take / " + nbRead + " Read / " + nbWrite + " Write)");
        System.out.println("---------------------------------------------------------------------------");
        // Memory usage
        formattedData = String.format("%.3f%% (%d/%d Mb)", metrics.memoryUsedPercent, metrics.memoryUsed, metrics.memoryMax);
        System.out.format("%-24s %s", "Memory usage", formattedData);
        System.out.println();
        // Success (Read)
        formattedData = String.format("%.3f%% (%d/%d q)", (metrics.readSuccess / (float)nbRead)*100f, metrics.readSuccess, nbRead);
        System.out.format("%-24s %s", "Success (Read)", formattedData);
        System.out.println();
        // Success (Take)
        formattedData = String.format("%.3f%% (%d/%d q)", (metrics.takeSuccess / (float)nbTake)*100f, metrics.takeSuccess, nbTake);
        System.out.format("%-24s %s", "Success (Take)", formattedData);
        System.out.println();
        // Response time (Take)
        doubleData = Arrays.stream(metrics.takeResponseTime).boxed().toArray(Double[]::new);
        printMetricData("Response time (Take)", "%.3f", "ms", doubleData);
        // Response time (Read)
        doubleData = Arrays.stream(metrics.readResponseTime).boxed().toArray(Double[]::new);
        printMetricData("Response time (Read)", "%.3f", "ms", doubleData);
        // Throughput (Take)
        intData = Arrays.stream(metrics.takeThroughput).boxed().toArray(Integer[]::new);
        printMetricData("Throughput (Take)", "%d", "q/s", intData);
        // Throughput (Read)
        intData = Arrays.stream(metrics.readThroughput).boxed().toArray(Integer[]::new);
        printMetricData("Throughput (Read)", "%d", "q/s", intData);
        // Throughput (Write)
        intData = Arrays.stream(metrics.writeThroughput).boxed().toArray(Integer[]::new);
        printMetricData("Throughput (Write)", "%d", "q/s", intData);

        System.out.println();
        System.out.println('\n');
    }

    // Removes all target Tuple from linda Linda server
    private void startServerClean(Linda linda, Tuple target) {
        System.out.println("Cleaning server...");
        Tuple result = null;

        do {
            result = linda.tryTake(target);
        } while(result != null);
    }

    // Create a report directory containing results as CSV files and plot them
    private void generateOutput(String outputDir) {
        System.out.println("Generating output to " + outputDir + "...");

        // Creating output directory
        new File(outputDir).mkdirs();

        for (Map.Entry<String, ArrayList<?>> entry : metrics.allValues.entrySet()) {
            File csvFile = new File(outputDir+"/"+entry.getKey()+".csv");
            
            try {
                // Creating CSV
                csvFile.createNewFile();
                
                // Writing values in CSV
                BufferedWriter writer = new BufferedWriter(new FileWriter(csvFile));
                ArrayList<?> values = entry.getValue();

                writer.write("Query,Value");
                writer.newLine();
                for(int query = 0; query < values.size() ; query++) {
                    writer.write(query + "," + values.get(query));
                    writer.newLine();
                }
                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        plotOutput(outputDir);
    }

    private void plotOutput(String outputDir) {
        String pythonScript = new File("linda/tools/perfanalyzer/PlotOutput.py").getAbsolutePath();
        try{
            // Trying to execute python script
            // Dependencies: pandas, matplotlib
            Runtime.getRuntime().exec("python3 " + pythonScript + " " + outputDir);

        }catch(Exception e) {
            e.printStackTrace();
            System.out.println("Please add permissions (chmod 777) for file " + pythonScript);
        }
    }
}