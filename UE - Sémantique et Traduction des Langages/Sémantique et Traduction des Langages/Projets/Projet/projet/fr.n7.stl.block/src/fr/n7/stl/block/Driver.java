package fr.n7.stl.block;

import java.util.ArrayList;

class Driver {

	public static void main(String[] args) throws Exception {
		Parser parser = null;
		if (args.length == 0) {
			String url;
			ArrayList<String> vrais = new ArrayList<String>();
			for (int i=0; i<=103; i++) {
				try {
					if (i<10) {
						url = "tests-miniC-2021/test0"+Integer.toString(i)+".bloc";
					} else {
						url = "tests-miniC-2021/test"+Integer.toString(i)+".bloc";
					}
					parser = new Parser(url);
					parser.parse();
					vrais.add("Test num "+i+" passe");
				} catch (Exception e) {
					vrais.add("Test num "+i+" ne passe pas avec l'erreur "+e.toString());
				}
			}
			for (int k=0; k<vrais.size(); k++) {
				System.out.println(vrais.get(k));
			}
			// Test sans erreur
			//parser = new Parser( "input1.txt" );
			//parser = new Parser( "input2.txt" );
			//parser = new Parser( "input3.txt" );
			//parser = new Parser( "input4.txt" );
			//parser = new Parser( "input5.txt" );
			//parser = new Parser( "input6.txt" );
			//parser = new Parser( "input7.txt" );
			//parser = new Parser( "input8.txt" );
			// Test avec erreur 
			//parser = new Parser( "input1KO.txt" );
			//parser = new Parser( "input2KO.txt" );
			//parser = new Parser( "input3KO.txt" );
			//parser = new Parser( "input4KO.txt" );
			//parser = new Parser( "input5KO.txt" );
			//parser = new Parser( "input6KO.txt" );
			//parser = new Parser( "input7KO.txt" );
			//parser.parse();
		} else {
			for (String name : args) {
				parser = new Parser( name );
				parser.parse();
			}
		}
	}
	
}