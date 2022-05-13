package linda.tools.serverstarter;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.rmi.Naming;
import java.net.MalformedURLException;
import java.rmi.AlreadyBoundException;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import linda.Linda;
import linda.cache.LindaCachedServerImpl;
import linda.server.LindaServer;
import linda.server.LindaServerImpl;
import picocli.CommandLine;
import picocli.CommandLine.Command;
import picocli.CommandLine.Option;
import picocli.CommandLine.Parameters;

@Command(
    name = "server",
    description = "Starts one or more Linda server with specified configuration."
)
public class LindaServerStarter implements Runnable {
    private static final int EXIT_SUCCESS = 0;
    private static final int EXIT_FAIL = 1;

    @Option(
        names={"-f", "--file"},
        description="Starts servers from configuration file",
        help=true
    )
    private String fileName;

    @Option(
        names={"-n", "--no-multiserver"},
        description="Disables interconnection if multiple servers are created"
    )
    private boolean disableMultiserver;

    @Option(
        names={"-h", "--help"},
        description="Shows help message",
        usageHelp=true
    )
    private boolean helpRequested;

    @Parameters(
        description = "Server name",
        index = "0"
    )
    private String servName;

    @Parameters(
        description = "Server address",
        defaultValue = "127.0.0.1:4000",
        index = "1"
    )
    private String servNetwork;


    @Parameters(
        description = "Server type",
        defaultValue = "Basic",
        index = "2"
    )
    private String servType;

    private ArrayList<LindaServer> startedServers;

    // MAIN -----------------------------
    public static void main(String[] args) {
        new CommandLine(new LindaServerStarter()).execute(args);
    }

    // RUN -----------------------------
    @Override
    public void run() {
        startedServers = new ArrayList<>();

        if(fileName != null) {
            runServerFile(fileName);
        } else {
            runServerParams(servName+" "+servNetwork+" "+servType);
        }

        if(!disableMultiserver) {
            startInterconnection();
        }
    }

    private void runServerFile(String fileName) {
        try {
            File file = new File(fileName);
            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
            
            for(String input = br.readLine() ; (input != null) ; input = br.readLine()) {
                tryStartConfig(input);
            }

            br.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Cannot open file " + fileName);
        }
    }

    private void runServerParams(String config) {
        tryStartConfig(config);
    }

    private void startInterconnection() {
        for(LindaServer serv : startedServers) {
            for(LindaServer neigh : startedServers) {
                if(!serv.equals(neigh)) {
                    try {
                        serv.addNeighbor(neigh);
                    } catch (Exception e) {
                        e.printStackTrace();
                        try {
                            System.out.println("Error: Could not establish connection between " + serv.getUrl() + " and " + neigh.getUrl());
                        } catch (RemoteException e1) {
                            e1.printStackTrace();
                        }
                    }
                }
            }
        }

        System.out.println("\nInterconnected servers !");
    }

    // UTILS -----------------------------
    private int tryStartConfig(String config) {
        List<String> lindaTypes = Arrays.asList(Linda.TYPE_BASIC, Linda.TYPE_PARALLEL, Linda.TYPE_CACHE);
        String[] serverConfig = config.split(" ", 3); // [0]: name [1]: network [2]: type
        String[] serverNetwork = serverConfig[1].split(":", 2); // [0]: addr [1]: port

        // PARSING
        
        // Server Config
        if(serverConfig.length != 3) {
            System.out.println("Error: '" + config + "' is not a correct server configuration (ex: 'LindaServer localhost:4000')");
            return EXIT_FAIL;
        }
        
        // Server Network
        if(serverNetwork.length != 2) {
            System.out.println("Error: '" + config + "' has not a correct network configuration (ex: 'localhost:4000')");
            return EXIT_FAIL;
        }

        String serverName = serverConfig[0];
        String serverAddr = serverNetwork[0];
        String serverPort = serverNetwork[1];
        int port = -1;
        String serverType = serverConfig[2];

        // Server Name
        if(!serverName.matches("^[a-zA-Z0-9]*$")) {
            System.out.println("Error: '" + config + "' has not a correct server name (only alphanumerics)");
            return EXIT_FAIL;
        }

        // Server Address
        if(!serverAddr.matches("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$") && !serverAddr.equals("localhost")) {
            System.out.println("Error: '" + config + "' has not a correct server address (ex: '127.0.0.1')");
            return EXIT_FAIL;
        }

        // Server Port
        try {
            port = Integer.parseInt(serverPort);
            if(port < 1 || port > 65535) {
                System.out.println("Error: '" + config + "' has not a correct server port (must be in range [1 - 65535])");
                return EXIT_FAIL;
            }
        } catch (NumberFormatException e) {
            System.out.println("Error: '" + config + "' has not a correct server port (ex: 4000)");
            return EXIT_FAIL;
        }

        // Server Type
        if(lindaTypes.contains(serverType)) {
            startServer(serverType, serverName, serverAddr, port);
        } else {
            System.out.println("Error: '" + config + "' has not a correct Linda type (" + lindaTypes + ")");
            return EXIT_FAIL;
        }
        
        return EXIT_SUCCESS;
    }

    private void startServer(String type, String name, String adr, int port) {
        LindaServer lindaServer = null;
        String prefix = "[" + name + " (" + type + ")] - ";
        String url = "//" + adr + ":" + port + "/" + name;
        
        try {
            // Creating server
            if(type.equals(Linda.TYPE_BASIC) || type.equals(Linda.TYPE_PARALLEL)) {
                lindaServer = new LindaServerImpl(type, url, null);
            } else if (type.equals(Linda.TYPE_CACHE)) {
                lindaServer = new LindaCachedServerImpl(url, null);
            }

            // Creating registry
            try {
                LocateRegistry.createRegistry(port);
            } catch (RemoteException e) {
                // Port already used
                System.out.println("Error: Could not start server at " + url + " (port " + port + " is not available)");
                return;
            }

            // Binding
            Naming.bind(url, lindaServer);
            System.out.println(prefix + "Server started at " + url);

            startedServers.add(lindaServer);

        } catch (MalformedURLException | AlreadyBoundException | RemoteException e) {
            System.out.println("Error: Could not start server at " + url);
            e.printStackTrace();
            return;
        }
    }
}
