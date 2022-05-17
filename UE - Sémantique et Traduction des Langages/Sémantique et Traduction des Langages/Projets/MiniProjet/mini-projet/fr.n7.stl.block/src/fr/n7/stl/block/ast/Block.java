/**
 * 
 */
package fr.n7.stl.block.ast;

import java.util.List;

import fr.n7.stl.block.ast.instruction.Instruction;
import fr.n7.stl.block.ast.instruction.Return;
import fr.n7.stl.block.ast.instruction.declaration.ParameterDeclaration;
import fr.n7.stl.block.ast.instruction.declaration.VariableDeclaration;
import fr.n7.stl.block.ast.scope.Declaration;
import fr.n7.stl.block.ast.scope.HierarchicalScope;
import fr.n7.stl.block.ast.scope.Scope;
import fr.n7.stl.block.ast.scope.SymbolTable;
import fr.n7.stl.block.ast.type.Type;
import fr.n7.stl.tam.ast.Fragment;
import fr.n7.stl.tam.ast.Register;
import fr.n7.stl.tam.ast.TAMFactory;

/**
 * Represents a Block node in the Abstract Syntax Tree node for the Bloc language.
 * Declares the various semantics attributes for the node.
 * 
 * A block contains declarations. It is thus a Scope even if a separate SymbolTable is used in
 * the attributed semantics in order to manage declarations.
 * 
 * @author Marc Pantel
 *
 */
public class Block {

	/**
	 * Sequence of instructions contained in a block.
	 */
	protected List<Instruction> instructions;
	
	
	protected HierarchicalScope<Declaration> _scope2;

	/**
	 * Constructor for a block.
	 */
	public Block(List<Instruction> _instructions) {
		this.instructions = _instructions;
	}
	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		String _local = "";
		for (Instruction _instruction : this.instructions) {
			_local += _instruction;
		}
		return "{\n" + _local + "}\n" ;
	}
	
	/**
	 * Inherited Semantics attribute to collect all the identifiers declaration and check
	 * that the declaration are allowed.
	 * @param _scope Inherited Scope attribute that contains the identifiers defined previously
	 * in the context.
	 * @return Synthesized Semantics attribute that indicates if the identifier declaration are
	 * allowed.
	 */
	public boolean collect(HierarchicalScope<Declaration> _scope) {
		this._scope2 = new SymbolTable(_scope);
		boolean ok = true;
		for( Instruction instr : this.instructions) {
			ok = ok && instr.collectAndBackwardResolve(_scope2) ;
		}
		System.out.println("Locales : " + _scope);
		return ok;
	}
	
	/**
	 * Inherited Semantics attribute to check that all identifiers have been defined and
	 * associate all identifiers uses with their definitions.
	 * @param _scope Inherited Scope attribute that contains the defined identifiers.
	 * @return Synthesized Semantics attribute that indicates if the identifier used in the
	 * block have been previously defined.
	 */
	public boolean resolve(HierarchicalScope<Declaration> _scope) {
		boolean ok = true;
		for( Instruction instr : this.instructions) {
			ok = ok && instr.fullResolve(this._scope2) ;
		}
		
		return ok;
		
	}

	/**
	 * Synthesized Semantics attribute to check that an instruction if well typed.
	 * @return Synthesized True if the instruction is well typed, False if not.
	 */	
	public boolean checkType() {
		boolean ok =true;
		for( Instruction instr : this.instructions) {
			ok = ok == instr.checkType();
			if (ok == false) {
				return ok;
			}
		}
		return ok;
	}
	
	public boolean checkType(Type type) {
		boolean ok = true;
		for( Instruction instr : this.instructions) {
			if ( instr instanceof Return) {
				ok = ok == ((Return) instr).checkType(type);
			} else {
				ok = ok ==  instr.checkType();
			}
			if (ok == false) {
				return ok;
			}
		}
		return ok;
	}

	/**
	 * Inherited Semantics attribute to allocate memory for the variables declared in the instruction.
	 * Synthesized Semantics attribute that compute the size of the allocated memory. 
	 * @param _register Inherited Register associated to the address of the variables.
	 * @param _offset Inherited Current offset for the address of the variables.
	 */	
	public void allocateMemory(Register _register, int _offset) {
		
		for( Instruction instr : this.instructions) {
			_offset = instr.allocateMemory(_register, _offset);
			}
	}

	/**
	 * Inherited Semantics attribute to build the nodes of the abstract syntax tree for the generated TAM code.
	 * Synthesized Semantics attribute that provide the generated TAM code.
	 * @param _factory Inherited Factory to build AST nodes for TAM code.
	 * @return Synthesized AST for the generated TAM code.
	 */
	public Fragment getCode(TAMFactory _factory) {
		Fragment _result = _factory.createFragment();
		for( Instruction instr : this.instructions) {
			_result.append(instr.getCode(_factory));
			}
		return _result;
	}

}
