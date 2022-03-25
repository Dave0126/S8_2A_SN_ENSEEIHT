package pack;

public class testAddrPer {
	public static void main(String[] agrs) {
		Personne per = new Personne();
		Adresse addr = new Adresse();
		
		per.setId(1);
		per.setNom("DAI");
		per.setPrenom("Guohao");
		
		addr.setId(1);
		addr.setRue("Road n°1");
		addr.setVille("Toulouse");
		
		per.setAdresse(addr);
		
		System.out.println(per.getId());
		System.out.println(per.getNom());
		System.out.println(per.getPrenom());
		System.out.println(per.getAdresse().getId());
		System.out.println(per.getAdresse().getRue());
		System.out.println(per.getAdresse().getVille());
	}
}
