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



###### Definition (equivalent formulas)

Two wffs φ and ψ are equivalent iff for every interpretation $\mathcal{I}$, 
$$
[φ]\mathcal{I} = [ψ]\mathcal{I}
$$
This is denoted by $φ ≡ ψ$





##### Exercise

###### 1

$$
\Sigma = \begin{cases}
	tr = bus \lor train \\
	tr = bus \lor car \to late \land miss \\
	\neg late
\end{cases} \\
\phi = t \\
bus \lor train \triangleq \{ bus \to late, bus \to miss, car \to late, car \to miss\}\\
\Sigma \models ? \phi
$$


$$
{\frac{tr = bus \lor train \quad \neg train}{b} R}
$$


2. skolem standard

$$
\forall x (H(x) \to ((\exist yF(x,y)) \land (\exist z M(x,z))) \rightsquigarrow \begin{aligned} 
\forall x \exist y \exist z \quad H(x) \to (F(x,y) \land M(x,z))\\
\forall x \exist y \exist z \quad \neg H(x) \lor (F(x,y) \land M(x,z))\\
\forall x \exist y \exist z \quad \neg (H(x) \lor F(x,y)) \land (\neg H(x) \lor M(x,z))\\
\forall x \exist y \exist z \quad \neg (H(x) \lor F(x,f_y(x))) \land (\neg H(x) \lor M(x,f_z(x)))\\
\forall x \exist y \exist z \quad \neg (H(x_1) \lor F(x,f_y(x_1))) \land (\neg H(x_2) \lor M(x,f_z(x_2))) \end{aligned}
$$

