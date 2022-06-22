
public aspect NbTraits {
	public abstract int Expression.nbTraits();
	
	public int Constante.nbTraits() {
		return 0;
	}
	
	public int AccesVariable.nbTraits() {
		return 0;
	}

	public int Addition.nbTraits() {
		return 2;
	}

	public int Negation.nbTraits() {
		return 1;
	}

	public int Multiplication.nbTraits() {
		return 3;
	}
	
	public int ExpressionBinaire.nbTraits() {
		return this.getOperandeGauche().nbTraits()
				+ this.getOperandeDroite().nbTraits()
				+ this.getOperateur().nbTraits();
	}

	public int ExpressionUnaire.nbTraits() {
		return this.getOperande().nbTraits()
				+ this.getOperateur().nbTraits();
	}
	
	public abstract int OperateurUnaire.nbTraits();
	public abstract int OperateurBinaire.nbTraits();
	
	
}
