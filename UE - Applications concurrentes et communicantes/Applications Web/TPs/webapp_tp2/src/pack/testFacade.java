package pack;

public class testFacade {
	public static void main(String[] agrs) {	
		Facade f = new Facade();
		
		f.ajoutPersonne("xiao", "ming");
		f.ajoutAdresse("Road n°2", "Toulouse");
		
		f.associer(1, 1);
		
		System.out.println(f.personne.get(1).getId());
		System.out.println(f.personne.get(1).getNom());
		System.out.println(f.personne.get(1).getPrenom());
		System.out.println(f.personne.get(1).getAdresse().getId());
		System.out.println(f.personne.get(1).getAdresse().getRue());
		System.out.println(f.personne.get(1).getAdresse().getVille());
		
		System.out.println(f.listePersonne());
	}
}
