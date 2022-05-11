package fr.n7.sat;

import java.io.*;
import com.microsoft.z3.*;

class SudokuFromFileMain {

    public static void main(String[] args) throws OutOfBoundsException, IOException {
        Sudoku            sudoku = Sudoku.loadSudoku(args[0], false);
        InputStreamReader aux    = new InputStreamReader(System.in);
        BufferedReader    in     = new BufferedReader(aux);

        while (true) {
            if (sudoku.solve() == Status.SATISFIABLE) {
                System.out.println("Solution found!\n");

                sudoku.print();

                sudoku.addCurrentSolutionAsCube();

                System.out.print("Enter y to try to find another solution: ");

                if (! in.readLine().equals("y")) {
                    break;
                } else {
                    System.out.println("trying to find another solution...");
                }

            } else {
                System.out.println("No solution found!\n");

                break;
            }
        }
    }
}
