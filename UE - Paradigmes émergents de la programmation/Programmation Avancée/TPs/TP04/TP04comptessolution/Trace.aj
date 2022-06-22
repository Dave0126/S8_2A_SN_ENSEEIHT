
public aspect Trace {
	pointcut allPublicMethods():
		call(public * (CompteSimple||CompteCourant).*(..))
		|| call(public (CompteSimple||CompteCourant).new(..));
	
	before() : allPublicMethods() {
		// System.out.println("In : " + thisJoinPoint.getSignature());

		String message = "";
		
		// Définir la classe englobante
		String nomClasse = thisJoinPoint.getSignature().getDeclaringTypeName();
		
		// Ajouter le nom de la méthode
		String methodeName = thisJoinPoint.getSignature().getName();
		if (methodeName.equals("<init>")) {
			message += nomClasse;
		} else {
			message += nomClasse + "." + methodeName;
		}
		
		// Ajouter les paramètres
		message += "(";
		boolean premier = true;
		for (Object arg : thisJoinPoint.getArgs()) {
			if (! premier) {
				message += ", ";
			}
			premier = false;
			message += arg; // + " : " + arg.getClass().getName();
		}
		message += ")";
		
		// Afficher le message
		System.out.println("Appel : " + message);
	}

}
