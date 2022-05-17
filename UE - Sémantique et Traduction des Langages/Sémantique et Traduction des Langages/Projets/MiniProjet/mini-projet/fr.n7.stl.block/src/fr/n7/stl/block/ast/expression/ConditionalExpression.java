/**
 * 
 */
package fr.n7.stl.block.ast.expression;

import fr.n7.stl.block.ast.SemanticsUndefinedException;
import fr.n7.stl.block.ast.expression.accessible.AccessibleExpression;
import fr.n7.stl.block.ast.instruction.Conditional;
import fr.n7.stl.block.ast.scope.Declaration;
import fr.n7.stl.block.ast.scope.HierarchicalScope;
import fr.n7.stl.block.ast.type.Type;
import fr.n7.stl.tam.ast.Fragment;
import fr.n7.stl.tam.ast.TAMFactory;

/**
 * Abstract Syntax Tree node for a conditional expression.
 * @author Marc Pantel
 *
 */
public class ConditionalExpression implements Expression {

	/**
	 * AST node for the expression whose value is the condition for the conditional expression.
	 */
	protected Expression condition;
	
	/**
	 * AST node for the expression whose value is the then parameter for the conditional expression.
	 */
	protected Expression thenExpression;
	
	/**
	 * AST node for the expression whose value is the else parameter for the conditional expression.
	 */
	protected Expression elseExpression;
	
	/**
	 * Builds a binary expression Abstract Syntax Tree node from the left and right sub-expressions
	 * and the binary operation.
	 * @param _left : Expression for the left parameter.
	 * @param _operator : Binary Operator.
	 * @param _right : Expression for the right parameter.
	 */
	public ConditionalExpression(Expression _condition, Expression _then, Expression _else) {
		this.condition = _condition;
		this.thenExpression = _then;
		this.elseExpression = _else;
	}

	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.expression.Expression#collect(fr.n7.stl.block.ast.scope.Scope)
	 */
	@Override
	public boolean collectAndBackwardResolve(HierarchicalScope<Declaration> _scope) {
		boolean ok1 = condition.collectAndBackwardResolve(_scope);
		boolean ok2 = thenExpression.collectAndBackwardResolve(_scope);
		boolean ok3 = elseExpression.collectAndBackwardResolve(_scope);
		return ok1 && ok2 && ok3 ;
	}

	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.expression.Expression#resolve(fr.n7.stl.block.ast.scope.Scope)
	 */
	@Override
	public boolean fullResolve(HierarchicalScope<Declaration> _scope) {
		return true;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "(" + this.condition + " ? " + this.thenExpression + " : " + this.elseExpression + ")";
	}
	
	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.Expression#getType()
	 */
	@Override
	public Type getType() {
		return thenExpression.getType();
	}

	/* (non-Javadoc)
	 * @see fr.n7.stl.block.ast.Expression#getCode(fr.n7.stl.tam.ast.TAMFactory)
	 */
	@Override
	public Fragment getCode(TAMFactory _factory) {
		Fragment _result = this.condition.getCode(_factory);
		if (this.condition instanceof AccessibleExpression) {
			_result.add(_factory.createLoadI(this.condition.getType().length()));
		}
		int nb = Conditional.nbConditionnel++;
		_result.add(_factory.createJumpIf("elseBranch_" + nb,0));
		_result.append(this.thenExpression.getCode(_factory));
		if (this.thenExpression instanceof AccessibleExpression) {
			_result.add(_factory.createLoadI(this.thenExpression.getType().length()));
		}
		_result.add(_factory.createJump("finIf_" + nb));
		Fragment _result_else = _factory.createFragment();
		_result_else.append(this.elseExpression.getCode(_factory));
		if (this.elseExpression instanceof AccessibleExpression) {
			_result_else.add(_factory.createLoadI(this.elseExpression.getType().length()));
		}
		_result.append(_result_else);
		return _result;
	}

}
