import java.util.*;

public class ExempleUnmodifiableList {

	public static void main(String[] args) {
		List<Integer> nombres = new ArrayList<>();
		Collections.addAll(nombres, 2, 3, 5, 7);
		System.out.println("nombre = " + nombres);
		// nombres.remove(5); // Attention remove(int indice)
		nombres.remove(new Integer(5));	// remove(Integer element)
		System.out.println("nombre = " + nombres);

		List<Integer> nonModifiable = Collections.unmodifiableList(nombres);
		System.out.println("nonModifiable = " + nonModifiable);
		try {
			nonModifiable.add(new Integer(7));
		} catch (Exception e) {	// En fait : UnsupportedOperationException
			System.out.println("Impossible d'ajouter 7 : " + e);
		}
		try {
			nonModifiable.remove(0);
		} catch (Exception e) {	// En fait : UnsupportedOperationException
			System.out.println("Impossible de supprimer l'élément à l'indice 0 : " + e);
		}
		System.out.println("nonModifiable = " + nonModifiable);
	}

}
