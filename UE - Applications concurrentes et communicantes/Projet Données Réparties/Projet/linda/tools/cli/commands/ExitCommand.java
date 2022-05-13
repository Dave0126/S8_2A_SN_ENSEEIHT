package linda.tools.cli.commands;

import java.util.concurrent.Callable;

import linda.tools.cli.LindaCLI;
import picocli.CommandLine.Command;

@Command(
    name="exit",
    description="Exits the CLI"
)
public class ExitCommand implements Callable<Integer> {

    @Override
    public Integer call() throws Exception {
        return LindaCLI.EXIT_CODE;
    }
}
