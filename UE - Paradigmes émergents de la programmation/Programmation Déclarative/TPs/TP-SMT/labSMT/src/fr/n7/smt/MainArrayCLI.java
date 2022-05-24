package fr.n7.smt;

public class MainArrayCLI {
    public static void main(String[] args) {
        ArraySwaps pb;

        if (args.length == 0) {
            // create dummy array
            int array[] = { 1, 4, 2, 3, 5 };

            pb = new ArraySwaps(5, array);

        } else {
            // use user input to create initial array
            int array[] = new int[args.length];

            for (int i = 0; i < args.length; i++) {
                try {
                    array[i] = Integer.parseInt(args[i]);
                } catch (NumberFormatException e) {
                    System.out.println(args[i] + " is not an integer!");
                    System.exit(1);
                }
            }

            pb = new ArraySwaps(args.length, array);
        }

        pb.solveAndPrint();
    }
}
