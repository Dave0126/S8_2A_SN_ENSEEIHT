### Declarative Programming - CTD1

#### logic programming

programs are written as sentences in logic form

find a correct comclusion from to solve a problem
$$
\forall x \; add(zero,x) = x \\
\forall x \forall y \; (succ(x),y) = succ(add(x,y))
$$
Prolog use **first-order logic** as a formal language to write programs and a **formal system** called Resolution to answer queries on programs.



##### Syntax of proposition logic

Let $Var$ be a set of propositional variables. The syntax of well-formed formulas of LPL is given by the following EBNF:
$$
φ ::= 'A' | ’⊤’ | ’⊥’ | ¬φ | φ ∧ φ | φ ∨ φ | φ → φ | φ ↔ φ
$$
where $A ∈ Var$.



**Definition (equivalent formulas)**

Two wffs φ and ψ are equivalent iff for every interpretation $\mathcal{I}$, 
$$
[φ]\mathcal{I} = [ψ]\mathcal{I}
$$
This is denoted by $φ ≡ ψ$



