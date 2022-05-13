package linda.test;

import linda.server.LindaClient;
import linda.Tuple;

public class MultiserverTest {

    public static void main(String[] args) {

        new Thread() {
            public void run() {
                LindaClient lindaClient = new LindaClient("//localhost:4000/LindaServer1");

                lindaClient.write(new Tuple(5));
                lindaClient.debug("[ServerClient 1]");
            }
        }.start();

        new Thread() {
            public void run() {
                LindaClient lindaClient2 = new LindaClient("//localhost:4001/LindaServer2");

                lindaClient2.debug("[ServerClient 2]");
                Tuple res = lindaClient2.take(new Tuple(5));
                System.out.println("[ServerClient 2] Got " + res);
            }
        }.start();
    }
}