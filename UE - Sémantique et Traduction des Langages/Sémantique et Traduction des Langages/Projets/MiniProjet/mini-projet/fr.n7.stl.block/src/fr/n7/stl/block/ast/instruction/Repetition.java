/**
 * 
 */
package fr.n7.stl.block.ast.instruction;

import fr.n7.stl.block.ast.Block;
import fr.n7.stl.block.ast.SemanticsUndefinedException;
import fr.n7.stl.block.ast.expression.Expression;
import fr.n7.stl.block.ast.instruction.declaration.ConstantDeclaration;
import fr.n7.stl.block.ast.scope.Declaration;
import fr.n7.stl.block.ast.scope.HierarchicalScope;
import fr.n7.stl.block.ast.scope.Scope;
import fr.n7.stl.block.ast.type.AtomicType;
import fr.n7.stl.block.ast.type.Type;
import fr.n7.stl.tam.ast.Fragment;
import fr.n7.stl.tam.ast.Register;
import fr.n7.stl.tam.ast.TAMFactory;
import fr.n7.stl.util.Logger;

/**
 * Implementation of the Abstract Syntax Tree node for a repetition instruction.
 * @author Marc Pantel
 *
 */
public class Repetition implements Instruction {

	protected Expression condition;
	protected Block body;

	public Repetition(Expression _condition, Block _body) {
		this.condition = _condition;
		this.body = _body;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "while (" + this.condition + ") " + this.body;
	}
	
	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.instruction.Instruction#collect(fr.n7.stl.block.ast.scope.Scope)
	 */
	@Override
	public boolean collectAndBackwardResolve(HierarchicalScope<Declaration> _scope) {
		
		return condition.collectAndBackwardResolve(_scope) && body.collect(_scope);

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
		if (!(te == AtomicType.BooleanType)) {
			Logger.error("Error Type");
			return false;
		} else {
			return body.checkType();
		}
	}


	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.Instruction#allocateMemory(fr.n7.stl.tam.ast.Register, int)
	 */
	@Override
	public int allocateMemory(Register _register, int _offset) {
		body.allocateMemory(_register, _offset);
		return  _offset;
	}

	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.Instruction#getCode(fr.n7.stl.tam.ast.TAMFactory)
	 */
	@Override
	public Fragment getCode(TAMFactory _factory) {
		String label_then = "condition_then_" + _factory.createLabelNumber();
		String label_end = "condition_end_" + _factory.createLabelNumber();
		String label_cond = "condition_" + _factory.createLabelNumber();
		
		Fragment _result = condition.getCode(_factory);
		_result.addSuffix(label_cond);
		
		_result.add(_factory.createJumpIf(label_then, 0));
		_result.add(_factory.createJump(label_end));
		
		Fragment then_result = body.getCode(_factory);
		then_result.addPrefix(label_then);
		then_result.addSuffix(label_end);
		then_result.add(_factory.createJump(label_cond));
		_result.append(then_result);
		
		return _result;
	}

}
