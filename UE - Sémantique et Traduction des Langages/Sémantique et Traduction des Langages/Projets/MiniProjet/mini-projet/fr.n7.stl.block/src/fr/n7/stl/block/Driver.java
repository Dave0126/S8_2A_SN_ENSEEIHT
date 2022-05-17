package fr.n7.stl.block;

class Driver {

	public static void main(String[] args) throws Exception {
		Parser parser = null;
		if (args.length == 0) {
			// Test sans erreur
			//parser = new Parser( "input1.txt" );
			//parser = new Parser( "input2.txt" );
			//parser = new Parser( "input3.txt" );
			//parser = new Parser( "input4.txt" );
			//parser = new Parser( "input5.txt" );
			//parser = new Parser( "input6.txt" );
			//parser = new Parser( "input7.txt" );
			parser = new Parser( "input8.txt" );
			// Test avec erreur 
			//parser = new Parser( "input1KO.txt" );
			//parser = new Parser( "input2KO.txt" );
			//parser = new Parser( "input3KO.txt" );
			//parser = new Parser( "input4KO.txt" );
			//parser = new Parser( "input5KO.txt" );
			//parser = new Parser( "input6KO.txt" );
			//parser = new Parser( "input7KO.txt" );
			parser.parse();
		} else {
			for (String name : args) {
				parser = new Parser( name );
				parser.parse();
			}
		}
	}
	
}