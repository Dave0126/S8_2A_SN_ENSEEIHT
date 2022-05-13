package linda.tools.cli.commands;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Collection;

import linda.Linda;
import linda.Tuple;
import picocli.CommandLine.Command;
import picocli.CommandLine.Option;

@Command(
    name="query",
    description="Sends queries interactively or from file to Linda server"
)
public class QueryCommand implements Runnable {
    private static final int EXIT_SUCCESS = 0;
    private static final int EXIT_FAIL = 1;
    
    private Linda linda;

    public QueryCommand(Linda linda) {
        this.linda = linda;
    }

    // RUN ----------------------------------------------
    @Option(names={"-i", "--inputfile"}, description="Run scenario in the specified file")
    private String fileName;

    @Override
    public void run() {
        if(fileName != null) {
            runQueryFile(fileName);
        } else {
            runQueryInteractive();
        }
    }

    // File reading mode
    private void runQueryFile(String fileName) {
        System.out.println("File mode.");
        System.out.println("Reading and executing queries from file " + fileName);
        System.out.println();
        try {
            File file = new File(fileName);
            // Stop at first error encountered
            // TODO: Should check correct formatting before executing queries ?
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
            readQueries(br);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Cannot open file " + fileName);
        }
    }

    // Interactive Mode
    private void runQueryInteractive() {
        System.out.println("Interactive mode (type 'exit' to leave).");
        System.out.println("Available actions : take, trytake, takeall, read, tryread, readall, write");
        System.out.println();
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        // Continue even if errors
        for(int exitCode = readQueries(br); exitCode != EXIT_SUCCESS; exitCode = readQueries(br)) { }
    }

    // Utils
    private int readQueries(BufferedReader br) {
        try {
            for(String input = br.readLine() ; (input != null) && (!input.equals("exit")) ; input = br.readLine()) {
                Tuple tuple = null;
                Tuple result = null;
                Collection<Tuple> results = null;
                String[] request = input.split(" ",2); // [0]: action [1]: tuple

                if(request.length != 2) {
                    System.out.println("Error: '" + input + "' has a wrong number of parameters (Usage: [ACTION] Tuple)");
                    return EXIT_FAIL;
                }

                // Parsing Tuple
                try {
                    tuple = Tuple.valueOf(request[1]);
                } catch (Exception e) {
                    System.out.println("Error: '" + request[1] + "' is not a correct Tuple (ex: [ 1 [ 'x' 2] ])");
                    return EXIT_FAIL;
                }

                // Parsing action
                switch (request[0]) {
                    case "take":
                        result = linda.take(tuple);
                        break;
                    case "trytake":
                        result = linda.tryTake(tuple);
                        break;
                    case "takeall":
                        results = linda.takeAll(tuple);
                        break;
                    case "read":
                        result = linda.read(tuple);
                        break;
                    case "tryread":
                        result = linda.tryRead(tuple);
                        break;
                    case "readall":
                        results = linda.readAll(tuple);
                        break;
                    case "write":
                        linda.write(tuple);
                        result = tuple;
                        break;
                    default:
                        System.out.println("Error: '" + input + "' is not a valid action");
                        return EXIT_FAIL;
                }

                // Printing result
                String resultString = "";

                if(result == null) {
                    if(results == null) {
                        resultString += "Null";
                    } else {
                        resultString += results;
                    }
                } else {
                    resultString += result;
                }

                System.out.format("%-8s %-32s --> %s %n", request[0], request[1], resultString);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return EXIT_SUCCESS;
    }
}
