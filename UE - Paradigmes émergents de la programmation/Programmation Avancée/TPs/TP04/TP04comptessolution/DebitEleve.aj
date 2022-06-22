import java.util.Random;

public aspect DebitEleve {
	
	private final double LIMITE = 450;
	private Random random = new Random();
	
	pointcut debitImportant(CompteSimple cs, double m) :
		target(cs)
		&& args(m)
		&& call(void *.debiter(double));
	// pourquoi call et non execution ?
	
	void around (CompteSimple cs, double montant)  : debitImportant(cs, montant) {
		boolean ok = true;
		if (montant > LIMITE) {
			System.out.println("Envoi SMS pour information : débit de " + montant);
			ok = random.nextInt(10) <= 2;
		}
		if (ok) {
			proceed(cs, montant);
		} else {
			System.out.println("Opération NON CONFIRMEE : REFUSEE");
			throw new OperationNonConfirmeeException("Débit non confirmé, montant=" + montant);
		}
	}

}
