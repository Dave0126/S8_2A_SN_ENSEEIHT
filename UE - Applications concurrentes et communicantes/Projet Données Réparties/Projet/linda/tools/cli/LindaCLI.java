package linda.tools.cli;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import linda.Linda;
import linda.cache.LindaCachedClient;
import linda.server.LindaClient;
import linda.tools.cli.commands.ExitCommand;
import linda.tools.cli.commands.PerformanceCommand;
import linda.tools.cli.commands.QueryCommand;
import linda.tools.cli.commands.StatusCommand;
import picocli.CommandLine;
import picocli.CommandLine.Command;

@Command(
    name = "",
    description = "Command Line Interface to run queries and retrieve informations from a Linda server."
)
public class LindaCLI {
    public static final int EXIT_CODE = 1;

    private LindaClient linda;
    private CommandLine cli;

    public LindaCLI(String lindaUrl) {
        System.out.println("Connecting to Linda server...");
        this.linda = new LindaClient(lindaUrl);
        if(this.linda.type().equals(Linda.TYPE_CACHE)) {
            this.linda = new LindaCachedClient(lindaUrl);
        }
        this.cli =  new CommandLine(this)
            .addSubcommand(new picocli.CommandLine.HelpCommand())
            .addSubcommand(new QueryCommand(this.linda))
            .addSubcommand(new StatusCommand(this.linda))
            .addSubcommand(new PerformanceCommand(this.linda))
            .addSubcommand(new ExitCommand());
    }

    public void startCLI() {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String[] input = {"help"};
        
        // Flushing terminal
        System.out.print("\033[H\033[2J");  
        System.out.flush();

        cli.getCommandSpec().parser().collectErrors(true); // Unable error throwing

        for(int exitCode = cli.execute(input); exitCode != LindaCLI.EXIT_CODE ; ) {
            try {
                // Executing help before each new command to display commands
                if(!input[0].equals("help") && (cli.parseArgs(input).errors().size() < 1)) {
                    System.out.print("\nDone (press Return)");
                    br.readLine();
                    System.out.println();
                    cli.execute("help");
                }
                // Waiting for user command input
                System.out.print("\nCommand: ");
                input = br.readLine().split(" ");
                // Flushing terminal
                System.out.print("\033[H\033[2J");  
                System.out.flush();
                // Executing command
                exitCode = cli.execute(input);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        try {
            br.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // MAIN ------------------------------------------------------------

    public static void main(String[] args) {
        if(args.length != 1) {
            System.out.println("Usage : LindaCLI url");
            return;
        }
        
        LindaCLI cli = new LindaCLI(args[0]);
        cli.startCLI();
    }
}