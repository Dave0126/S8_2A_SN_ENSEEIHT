package pack;

import java.util.ArrayList;
import java.util.List;

public class Personne {
	int id;
	String nom, prenom;
	Adresse addr;
	
	List<Adresse> address = new ArrayList<Adresse>();
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getId() {
		return this.id;
	}
	
	public void setNom(String nom) {
		this.nom = nom;
	}
	
	public String getNom() {
		return this.nom;
	}
	
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	
	public String getPrenom() {
		return this.prenom;
	}
	
	public Adresse getAdresse() {
		return this.addr;
	}
	
	public void setAdresse(Adresse addr) {
		this.addr = addr;
	}
}
