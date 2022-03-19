# Project - Sémantique et TDL

## Mini - Project : MiniML

#### Author

**EL BSITA Yassir** and **DAI Guohao** in **Group Binome L12 - 14,** 2A - SN.



#### Description

This is a mini project of UE - Sémantique et Tradution des Langages. It is an interpreter for a simple programming language based on a mini subset of OCaml, and is written in OCaml.



#### File Structure

- `Ast.ml` contains all the interfaces of type, like binary operators, unary operators and abstract syntaxic tree ;
- `parser.mly` is a parser ;
- `lexer.mll` is a lexical analyzer ;
- `Types.ml` contains definitions of type and type analyis of miniML ; 
- `Semantics.ml` declares the code of miniML semantic analysis ;
- `MiniML.ml` is the entrance of programme. It load the test file in `/exemples/` and strat to anlayze each token ;
- `Main.ml`  is the main function. It will print the result of analyzer ;
- `Test.ml` contains all the test files in `/exemples/` , some could be found in the comments ;
- `/exemples/*` are all the test files of MiniML project.



#### How to compile?

- `dune build` to build the whole Ocaml project ; 
- `dune runtest` to build and execute inline test ;
- `dune utop` to launch the `utop` tool for testing some functions ;
- `dune clean` to clean up the files generated in folder  `/_build/*` .