package fr.n7.sat;

import java.io.*;
import java.util.*;
import com.microsoft.z3.*;

class SudokuInteractiveMain {

    public static void main(String[] args) {
        System.out.print("Grid dimension? ");

        InputStreamReader aux = new InputStreamReader(System.in);
        BufferedReader    in  = new BufferedReader(aux);

        try {
            String s      = in.readLine().trim();
            Sudoku sudoku = new Sudoku(Integer.parseInt(s),
                                       System.getProperty("fr.n7.sat.log", "false").equals("true"));

            boolean stop = false;

            while (!stop) {
                System.out.println("Enter value in the form X Y V or quit: ");

                s = in.readLine().trim();

                if (s.equals("quit")) {
                    stop = true;
                } else {
                    try {
                        Scanner sc = new Scanner(s);
                        sudoku.addValue(sc.nextInt(), sc.nextInt(), sc.nextInt());
                    } catch (OutOfBoundsException e) {
                        System.err.println("Wrong entry: " + e.getMessage());
                    } catch (NoSuchElementException e) {
                        System.err.println("Wrong format: " + s);
                        e.printStackTrace();
                    }
                }
            }

            if (sudoku.solve() == Status.SATISFIABLE) {
                System.out.println("Solution found!\n");

                sudoku.print();
            } else {
                System.out.println("No solution found!\n");
            }
        } catch (NumberFormatException e) {
            System.err.println("Please enter an integer...");
        } catch (IOException e) {
            System.err.println("IO error...");
        }
    }

}
