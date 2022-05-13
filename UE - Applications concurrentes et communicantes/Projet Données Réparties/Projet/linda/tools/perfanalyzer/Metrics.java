package linda.tools.perfanalyzer;

import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class Metrics {
    // Constants
    public static final int AVERAGE = 0;
    public static final int MINIMUM = 1;
    public static final int MAXIMUM = 2;

    // Duration (ms)
    public double totalDuration;

    // Memory Usage (Mb)
    public long memoryUsed;
    public long memoryMax;
    public double memoryUsedPercent;

    // Successfull queries
    public ArrayList<Long> takeSuccessValues = new ArrayList<>();
    public ArrayList<Long> readSuccessValues = new ArrayList<>();
    public long takeSuccess = -1;
    public long readSuccess = -1;

    // Response time (ms)
    public ArrayList<Double> takeResponseTimeValues = new ArrayList<>();
    public ArrayList<Double> readResponseTimeValues = new ArrayList<>();
    public double[] takeResponseTime = {-1, -1, -1};
    public double[] readResponseTime = {-1, -1, -1};

    // Throughput (queries/s)
    public ArrayList<Integer> takeThroughputValues = new ArrayList<>();
    public ArrayList<Integer> readThroughputValues = new ArrayList<>();
    public ArrayList<Integer> writeThroughputValues = new ArrayList<>();
    public int[] takeThroughput = {-1, -1, -1};
    public int[] readThroughput = {-1, -1, -1};
    public int[] writeThroughput = {-1, -1, -1};

    // All recorded values
    public Map<String,ArrayList<?>> allValues = Stream.of(new Object[][] {
        {"Take-Success", takeSuccessValues},
        {"Read-Success", readSuccessValues},
        {"Take-ResponseTime", takeResponseTimeValues},
        {"Read-ResponseTime", readResponseTimeValues},
        {"Take-Throughput", takeThroughputValues},
        {"Read-Throughput", readThroughputValues},
        {"Write-Throughput", writeThroughputValues}
    }).collect(Collectors.toMap(data -> (String)data[0], data -> (ArrayList<?>)data[1]));
}
