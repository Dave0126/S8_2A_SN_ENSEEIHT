/**
 * 
 */
package fr.n7.stl.block.ast.instruction;

import java.util.Optional;

import fr.n7.stl.block.ast.Block;
import fr.n7.stl.block.ast.SemanticsUndefinedException;
import fr.n7.stl.block.ast.expression.Expression;
import fr.n7.stl.block.ast.scope.Declaration;
import fr.n7.stl.block.ast.scope.HierarchicalScope;
import fr.n7.stl.block.ast.type.AtomicType;
import fr.n7.stl.block.ast.type.Type;
import fr.n7.stl.tam.ast.Fragment;
import fr.n7.stl.tam.ast.Register;
import fr.n7.stl.tam.ast.TAMFactory;
import fr.n7.stl.util.Logger;

/**
 * Implementation of the Abstract Syntax Tree node for a conditional instruction.
 * @author Marc Pantel
 *
 */
public class Conditional implements Instruction {

	protected Expression condition;
	protected Block thenBranch;
	protected Block elseBranch;
	public static int nbConditionnel =0;

	public Conditional(Expression _condition, Block _then, Block _else) {
		this.condition = _condition;
		this.thenBranch = _then;
		this.elseBranch = _else;
	}

	public Conditional(Expression _condition, Block _then) {
		this.condition = _condition;
		this.thenBranch = _then;
		this.elseBranch = null;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "if (" + this.condition + " )" + this.thenBranch + ((this.elseBranch != null)?(" else " + this.elseBranch):"");
	}
	
	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.instruction.Instruction#collect(fr.n7.stl.block.ast.scope.Scope)
	 */
	@Override
	public boolean collectAndBackwardResolve(HierarchicalScope<Declaration> _scope) {
		boolean ok = thenBranch.collect(_scope);
		if (elseBranch != null) {
			ok = ok && elseBranch.collect(_scope);
		}
		ok = ok && condition.collectAndBackwardResolve(_scope);
		return ok;
	}
	
	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.instruction.Instruction#resolve(fr.n7.stl.block.ast.scope.Scope)
	 */
	@Override
	public boolean fullResolve(HierarchicalScope<Declaration> _scope) {
		return true;
	}

	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.Instruction#checkType()
	 */
	@Override
	public boolean checkType() {
		Type te = condition.getType();
		boolean ok = thenBranch.checkType();
		if (this.elseBranch != null) {
			ok = ok && elseBranch.checkType();
		}
		
		if (!(te == AtomicType.BooleanType)) {
			Logger.error("Error Type");
			return false;
		} else {
			return ok;
		}
	}

	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.Instruction#allocateMemory(fr.n7.stl.tam.ast.Register, int)
	 */
	@Override
	public int allocateMemory(Register _register, int _offset) {
		thenBranch.allocateMemory(_register, _offset);
		System.out.println("test " + _register+ " "+ _offset);
		elseBranch.allocateMemory(_register, _offset);
		return  _offset;
	}

	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.Instruction#getCode(fr.n7.stl.tam.ast.TAMFactory)
	 */
	@Override
	public Fragment getCode(TAMFactory _factory) {
		String label_then = "condition_then_" + _factory.createLabelNumber();
		String label_else = "condition_else_" + _factory.createLabelNumber();
		String label_end = "condition_end_" + _factory.createLabelNumber();
		
		Fragment _result = condition.getCode(_factory);
		
		_result.add(_factory.createJumpIf(label_then, 0));
		Fragment else_result = elseBranch.getCode(_factory);
		else_result.addPrefix(label_else);
		_result.append(else_result);
		
		_result.add(_factory.createJump(label_end));
		Fragment then_result = thenBranch.getCode(_factory);
		then_result.addPrefix(label_then);
		then_result.addSuffix(label_end);
		_result.append(then_result);
		return _result;
	}

}
