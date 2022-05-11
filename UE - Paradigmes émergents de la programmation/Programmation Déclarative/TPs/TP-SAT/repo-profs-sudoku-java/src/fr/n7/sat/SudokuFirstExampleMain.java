package fr.n7.sat;

import com.microsoft.z3.*;

class SudokuFirstExampleMain {
    public static void main(String[] args) throws OutOfBoundsException {
        Sudoku sudoku = new Sudoku(3, System.getProperty("fr.n7.sat.log", "false").equals("true"));

        sudoku.addValue(1, 6, 8);
        sudoku.addValue(1, 7, 5);
        sudoku.addValue(1, 8, 1);
        sudoku.addValue(2, 3, 1);
        sudoku.addValue(2, 5, 2);
        sudoku.addValue(2, 7, 9);
        sudoku.addValue(2, 8, 4);
        sudoku.addValue(3, 5, 8);
        sudoku.addValue(4, 4, 3);
        sudoku.addValue(4, 6, 6);
        sudoku.addValue(4, 7, 4);
        sudoku.addValue(5, 0, 5);
        sudoku.addValue(5, 3, 6);
        sudoku.addValue(5, 7, 7);
        sudoku.addValue(5, 8, 3);
        sudoku.addValue(6, 0, 6);
        sudoku.addValue(7, 1, 4);
        sudoku.addValue(7, 2, 3);
        sudoku.addValue(7, 3, 7);
        sudoku.addValue(7, 4, 2);
        sudoku.addValue(8, 1, 2);
        sudoku.addValue(8, 2, 9);
        sudoku.addValue(8, 3, 8);
        sudoku.addValue(8, 6, 3);

        if (sudoku.solve() == Status.SATISFIABLE) {
            System.out.println("Solution found!\n");

            sudoku.print();
        } else {
            System.out.println("No solution found!\n");
        }
    }
}
