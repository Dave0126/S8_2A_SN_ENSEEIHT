// Java program to demonstrate
// unmodifiableList() method

import java.util.*;

public class liste_de_entiers {
	public static void main(String[] argv)
		throws Exception
	{
		try {

			// creating object of ArrayList<Character>
			List<Integer> list = new ArrayList<Integer>();

			// populate the list
			list.add(2);
			list.add(3);
            list.add(5);
            list.add(8);

			// printing the list
			System.out.println("Initial list: " + list);

			// getting unmodifiable list
			// using unmodifiableList() method
			List<Integer> immutablelist = Collections
												.unmodifiableList(list);

			// Adding element to new Collection
			System.out.println("\nTrying to add(10) in the unmodifiablelist");
			immutablelist.add(10);

		}

		catch (UnsupportedOperationException e) {
			System.out.println("Exception thrown : " + e);
		}

	}
}
