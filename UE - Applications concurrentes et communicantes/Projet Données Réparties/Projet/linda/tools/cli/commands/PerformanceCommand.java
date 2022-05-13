package linda.tools.cli.commands;

import linda.Linda;
import linda.tools.perfanalyzer.*;

import picocli.CommandLine.Command;
import picocli.CommandLine.Option;
import picocli.CommandLine.Parameters;

@Command(
    name="perf",
    description="Runs a performance analysis of the server."
)
public class PerformanceCommand implements Runnable {

    private Linda linda;

    @Option(
        names={"-o", "--output"},
        description="Output analysis report as CSV in specified directory"
    )
    private String outputFile = null;

    @Parameters(
        description="Number of queries to send",
        defaultValue="50000"
    )
    private Integer nbQueries;

    @Parameters(
        description="Percentage of Take queries",
        defaultValue="25"
    )
    private Integer pTake;

    @Parameters(
        description="Percentage of Read queries",
        defaultValue="25"
    )
    private Integer pRead;

    @Parameters(
        description="Percentage of Write queries",
        defaultValue="50"
    )
    private Integer pWrite;

    public PerformanceCommand(Linda linda) {
        this.linda = linda;
    }

    @Override
    public void run(){
        if((pTake + pRead + pWrite == 100)) {
            LindaPerformanceAnalyzer analyzer = new LindaPerformanceAnalyzer(linda);
            analyzer.startAnalysis(nbQueries, pTake, pRead, pWrite, outputFile);
        } else {
            System.out.println("Sum of percentages must be 100.");
        }
    }

}
