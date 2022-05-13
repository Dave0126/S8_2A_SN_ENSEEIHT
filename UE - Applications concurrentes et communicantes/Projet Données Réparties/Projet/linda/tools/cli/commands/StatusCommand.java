package linda.tools.cli.commands;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.concurrent.TimeUnit;

import linda.server.LindaClient;
import picocli.CommandLine.Command;

@Command(
    name="status",
    description="Shows current Linda server status and informations"
)
public class StatusCommand implements Runnable {

    private LindaClient linda;

    public StatusCommand(LindaClient linda) {
        this.linda = linda;
    }

    @Override
    public void run() {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        long refreshRate = 1000;

        for(;true;) {
            try {
                if (br.ready()) {
                    return;
                }
                // Flushing terminal
                System.out.print("\033[H\033[2J");
                System.out.flush();
                // Printing infos
                System.out.println("(Press Return to exit)\n");
                System.out.println(linda.status());
                // Waiting
                TimeUnit.MILLISECONDS.sleep(refreshRate);
            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
