package pack;

import java.util.Collection;
import java.util.HashMap;

public class Facade {
	HashMap<Integer, Personne> personne = new HashMap<Integer, Personne>();
	HashMap<Integer, Adresse> adresse = new HashMap<Integer, Adresse>();
	int idP = 0;
	int idA = 0;
	
	public void ajoutPersonne(String n, String p) {
		Personne per = new Personne();
		per.setNom(n);
		per.setPrenom(p);
		per.setId(idP++);
		personne.put(idP, per);
	}
	
	public void ajoutAdresse(String r, String v) {
		Adresse addr = new Adresse();
		addr.setRue(r);
		addr.setVille(v);
		addr.setId(idA++);
		adresse.put(idA, addr);
	}
	
	Collection<Personne> listePersonne() {
		return personne.values();
	}
	
	Collection<Adresse> listeAdresse() {
		return adresse.values();
	}
	

	public void associer(int idP, int idA) {
		Personne p = personne.get(idP);
		Adresse a = adresse.get(idA);
		p.setAdresse(a);
	}
	
}
