import java.util.Observable;

public aspect CompteObserver {
	
	declare parents : CompteSimple extends Observable;

	private void CompteSimple.avertir(double montant) {
		this.setChanged();
		this.notifyObservers(montant);
	}

	pointcut changeSolde(CompteSimple cs, double m) :
		target(cs)
		&& args(m)
		&& (call(void CompteSimple.crediter(double))
				|| call(void CompteSimple.debiter(double)));
	// avec call au lieu de execution, on a une seule exécution de la notification au lieu de 2 !
	
	after (CompteSimple cs, double montant) : changeSolde(cs, montant) {
		// cs.setChanged();
		// cs.notifyObservers(montant);
		String methodName = thisJoinPoint.getSignature().getName();
		int facteur = (methodName.equals("debiter")) ? -1 : 1;
		cs.avertir(facteur * montant);
		System.out.println("Notification sur " + cs);
	}
	
		
		
	/*
	execution(void *.crediter(double))
			&& args(montant)
			&& target(cs)
	{
		cs.setChanged();
		cs.notifyObservers(montant);
	}
	 */

}
