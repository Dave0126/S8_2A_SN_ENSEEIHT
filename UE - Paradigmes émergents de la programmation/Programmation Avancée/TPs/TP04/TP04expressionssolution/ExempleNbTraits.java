
public class ExempleNbTraits {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Expression e1, e2, e3;
		Expression e4, e5, e6;
		Constante cte = new Constante(10);
		AccesVariable av = new AccesVariable("x");
		e1 = new ExpressionBinaire(new Addition(),
                new Constante(2),
                av);
		e2 = new ExpressionBinaire(new Multiplication(),
                e1,
                new Constante(3));
		
		e3 = new ExpressionBinaire(new Multiplication(),
                new Constante(7),
                e1) ;

		e4 = new ExpressionBinaire(new Addition(),
                new ExpressionBinaire(new Addition(),
                    new AccesVariable("x"), new AccesVariable("y")),
                new AccesVariable("z"));
		
		e5 = new ExpressionBinaire(new Addition(),
                new AccesVariable("x"),
                new ExpressionBinaire(new Addition(),
                    new AccesVariable("y"), new AccesVariable("z")));

		e6 = new ExpressionUnaire(new Negation(),
                new ExpressionUnaire(new Negation(),
                    e1));

		System.out.println(cte.nbTraits());	// 0
		System.out.println(av.nbTraits());	// 0
		System.out.println(e1.nbTraits());	// 2
		System.out.println(e2.nbTraits());	// 5
		System.out.println(e3.nbTraits());	// 5
		System.out.println(e4.nbTraits());	// 4
		System.out.println(e5.nbTraits());	// 4
		System.out.println(e6.nbTraits());	// 4
		
		

	}

}
