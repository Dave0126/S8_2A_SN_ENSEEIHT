Semantique et Traduction des Langages
================================

## Introduction
Informatique: Science du traitement de l'information
Computer Science: Science de la "machine a caculer"

### Architecture generale

#### Presentation
- Information brute: on cherche un commentaire avec une ligne commancant par "//"
- Par bloc: on divise le texte brut en mot, sous mot, ...
  $\Rightarrow$ structure d'un outil

```flow
st=>start: （程序）Programme
lex=>operation: （词法分析）Analyse Lexicale
syn=>operation: （语法分析）Analyse Syntaxique
sem=>operation: （语义分析）Analyse Semantique
e=>end: （结果）Resultats

st->lex->syn->sem->e
```

#### Analyse Structure Programme
```flow
lex=>operation: (词法分析) Analyse Lexicale
syn=>operation: (词法单元) Unite Lexicale
sem=>operation: (语义分析) Analyse Semantique

lex(right)->syn(right)->sem
```

#### Analyse Signification Programme
```flow
inf=>operation: Information
	       Table des Symboles
ges=>operation: Gestion des erreurs
sem=>operation: Analyse Semantique

inf(right)->sem
sem(right)->ges
```

#### Definitions

+ 【字符】Caractere/Symbole: Unite elementaire d'information（信息的基本单位）
+ 【词法单元（单词）】Unite lexicale (lexeme, mot) : Sequence de caracteres（一个字符序列）
+ 【语法单元（ast）】Unite syntaxique (arbre syntaxique, synteme, arbre) : Arbre d'unite lexicale
+ Unite semantique diverse

#### Comment organiser l'information
$\rightarrow$ Semantique la plus simple possible: Role de l'arbre abstrait (AST)

+ Objectif: Exploitation de l'information
+ Regle: Choisir le bon niveau de precision
+ Unite lexicale: Bloc elementaire d'information pertinente
+ Unite syntaxique: Element structurant de l'information


### L'approche XML
Document bien forme: Structure arborescente
Document valide: Respect arborescence specifique (DTD, Schema, ...)

### Documents XML
Lien [Wikipedia][2]

## Representation des Langages
### Rappels
+ Expressions regulieres
+ Grammaire
+ ...

### Verification de Langages
Outils qui exploitent les langages (interpretation, verification, traduction) jouent un role essentiel en Informatique $\quad \to \quad$ contraintes fortes qualite
> Exemple execution C
> ```c
> (i++) + (--i)
> ```
> L'ordre  d'evaluation importe. De gauche a droite ou de droite a gauche donnent des resultats differents.（左结合 和 右结合 给出的结果是不同的）

**Probleme** : Pas de definition suffisamment precise du langage（没有足够精确的语言定义）
Meme si elle est assez precise mais qu'elle est ecrite en langage naturelle, il est difficile pour une langage complexe d'etre sur que le typage va bien detecter les erreurs souhaitees.
$\Rightarrow $ Il faut donc une definition formelle（因此我们需要一个正式的定义）.

### Definition formelle
Sous la forme de programmes:

+ Interprete de reference（解释器）
+ Compilateur de reference（编译器）
+ ...

En utilisant des methodes formelles :

+ coherence de la definition, chaque cas n'est traite qu'une fois（定义的一致性，每个案例只处理一次）
+ completude de la definition, chaque cas est traite au moins une fois（定义的完整性，每个案例至少处理一次）
+ generation automatique des outils de reference, teste la specification pour la valider（自动生成参考工具，测试规范以验证它）

### Semantiques formelles
##### Semantique operationnelle

**Definition**: Decrit l'execution d'un programme du langage. Utilise le langage comme support.
L'algorithme qui manipule les donnees du langage pour faire le calcul correspond a l'execution du programme. Il interprete.
Cette semantique est assez *proche du langage*, est *facile a lire*, mais n'est *pas assez abstraite* quand le langage est complexe.

#### Semantique denotationnelle
**Definition**: Decrit l'execution par traduction ddans un langage mathematique abstrait suffisament eloigne du langage considere. Il se compose de :

+ *λ-calcul*
+ *Arithmetique*
+ *theorie point fixe*

Cette semantique est *difficile a faire*, *difficile a lire*, *inadaptee aux outils*

#### Semantique translationelle
**Definition**: traduction vers un langage informatique plus proche.
On a ainsi:

+ un *gain en simplicite et en lisibilite*
+ une *perte en abstraction*

> **En pratique**

 > On fait le choix d'un noyau du langage. On traduit ensuite vers ce noyau. Puis on donne la semantique du noyau.
 > La complexite est ainsi maitrisee.
 > > **Exemple**: FeatherWeight Java
 > > La traduction se fait en plusieurs etapes
 > > Java --> JVM --> Processeur

#### Semantique par axiomatique
**Definition**: Description des mecaniques de preuves de proprietes pour les programmes de ce langage
> **Exemple**: Typage, Definitions derivables, Logique de Hoore

### Coherence des formes
On cherche a montrer que ces formes sont coherentes. Il y a donc la possibilite de faire une preuve.
> **Exemple**: CompCert, compilateur C optimiseur developpe en [Coq][1]

## Interpretation - Semantique Operationnelle

> **Exemple**: MiniML

> + **Syntaxe cours**
> > $E \rightarrow cte$
> > $E \rightarrow E\ opBin\ E$
> > $E \rightarrow E\ opUn\ E$
> > $E \rightarrow (E)$
> > $E \rightarrow identificateur$

> + **Syntaxe TD**
> > $E \rightarrow let\ identificateur=E\ in\ E$
> > $E \rightarrow function\  identificateur \rightarrow E$
> > $E \rightarrow (E\ E)$ : appel de fonction (fonction puis parametres)
> > $E \rightarrow if\ E\ then\ E\ else\ E$
> > $E \rightarrow let\ sec\ identificateur=E\ in\ E$
> > **Probleme**: grammaire ambigue

Afin de simplifier ces differentes grammaire, on utilise un arbre abstrait (AST)
Structure de donnee contenant les informations necessaires a la definition de l'interprete.

```ocaml
type ast = BinaryNode of ast * binary * ast
                | UnaryNode  of unary * ast
                | IntegerNode  of int
                | TrueNode  | FalseNode
                | ...
```

### Procedure d'ecriture d'une semantique
#### Etape 1
Analyseur lexical/syntaxique qui construit l'arbre abstrait.
> **Exemple**: role de Xtext

#### Etape 2
Calculer la valeur d'une expression
##### Definition des valeurs
```ocaml
type value Type = IntegerValue of int
                | BooleanValue of bool
                | ErrorValue of errorType

type errorType = TypeMismatchError
               | UnbenoumIndentError
               | RuntimeError
```
##### Definition des regles de calcul
```ocaml
let rec value_of_expression expression env = 
match expression with
	(* Definition de la notion de constante *)
	| TrueNode -> (BooleanValue true)
	| FalseNode -> (BooleanValue false)
	| (IntegerNode v) -> (IntegerValue v)
	| (UnaryNode op par) ->
		(* Propagation des erreurs *)
		match (value_of_expression par) with
		| (ErrorValue en) -> (ErrorValue en)
		| (BooleanValue b) ->
			match op with
			| Negate -> (BooleanValue (not b))
			| Opposite -> (ErrorValue TypeMismatchError)
```
**Probleme**: toutes les regles d'evaluation sont surchargees dans une fonction

Notation plus abstraite pour separer les differents cas: regles de deduction
Jugement: $\gamma \vdash e \Rightarrow v$ dans l'environnement $\gamma$ l'expression $e$ s'evalue avec la valeur $v$

Annexes: 
> $\gamma \vdash boolean \Rightarrow boolean$
> $\gamma \vdash integer(v) \Rightarrow integer(v)$

$op$ est une operation predefinie de calcul sur les valeurs. Table de verite pour les boolean, arithmetique, ...
$\gamma \vdash integer(v) \Rightarrow integer(v),\ v \in dom(op),\ r=op(v)$
$\gamma \vdash op\ e \Rightarrow r$

### Erreurs
|        Erreur        | Caracteristique                                              | Classification   |
| :------------------: | ------------------------------------------------------------ | ---------------- |
|  **$\bot_{undef}$**  | identificateur non defini                                    | Analyse Statique |
|  **$\bot_{type}$**   | incompatibilite des types                                    | Analyse Statique |
| **$\bot_{runtime}$** | erreurs de calcul : division par zeros, depassement de capacite | Execution        |
|                      | gestion des ressources : memoire, temps de calcul, stockage, affichage |                  |
|                      | securite                                                     |                  |

**Analyse statique**: sans executer le programme

Remarque: $\gamma \vdash e \Rightarrow v$ s'appelle une semantique a grand pas (big step semantics). Passage de l'expression a sa valeur en 1 etape.

### Semantique a petit pas
> **Exemple**
> $\vdash 2 \Rightarrow 2 \ \ \vdash 3 \Rightarrow 3$
> $\vdash 1 \Rightarrow 1 \ \ \vdash 2\times3 \Rightarrow 6$
> $\vdash 1+2\times3 \Rightarrow 7$

```
tant que exp≠val faire
	exp := etape(expr)
fait
```
$$<exp, env> \rightarrow <exp', env>$$$$<exp_0, env_0> \rightarrow <exp_1, env_1> \rightarrow ...  \rightarrow <exp_n, env_n>$$
Cette semantique est similaire au systeme de transition.

$$\frac{<e_1, \gamma> \rightarrow <e_1', \gamma'>}{<e_1\mathbin{\!/\mkern-5mu/\!}e_2, \gamma> \rightarrow <e_1'\mathbin{\!/\mkern-5mu/\!}e_2, \gamma'>}$$

$$<\mathrm{if}\ true\ \mathrm{then}\ e_1\ \mathrm{else}\ e_2, \gamma>\rightarrow <e_1, \gamma>$$$$<\mathrm{if}\ false\ \mathrm{then}\ e_1\ \mathrm{else}\ e_2, \gamma>\rightarrow <e_2, \gamma>$$

$$\frac{e_1 \notin \mathrm{valeur}\ <e_1, \gamma> \rightarrow <e_1', \gamma'>}{<\mathrm{if}\ e_1\ \mathrm{then}\ e_2\ \mathrm{else}\ e_3, \gamma>\rightarrow <\mathrm{if}\ e_1'\ \mathrm{then}\ e_2\ \mathrm{else}\ e_3, \gamma'>}$$

La semantique a petit pas possede un plus grand nombre de regles, mais au detriment d'une gestion plus complexe de l'environnement.
Selon le langage, on utilise la semantique la plus adaptee.

## Typage, Semantique axiomatique
**Objectif**: Decrire comment prouver des proprietes de programmes

Peut etre generique: Preuve de n'importe quelle propriete: Logique de Hoore pour langages imperatifs
$$\mathrm{jugement: } \left\{ \phi \right\}\mathrm{P}\left\{ \psi \right\}$$
$\phi$ et $\psi$ decrivent l'eat de la memoire.
$$\frac{\left\{ \psi\land C \right\}\mathrm{P}\left\{ \phi \right\}}{\left\{ \phi \right\} \mathrm{while}\ C\ \mathrm{do}\ P\ \mathrm{od}\ \left\{ \phi\land \neg C \right\}}\ \phi\ \mathrm{invariant}$$

Peut etre specifique a certaines proprietes.

> **Exemple** : Absence de certaines erreurs a l'execution
> $\forall e, \forall v\ \mathrm{si}\ \vdash e \Rightarrow v\ \mathrm{alors}\ v \neq \bot$
> Langage sans erreurs: quasiement impossible ou sans interet pratique
> $\forall e, \forall v,\ \mathrm{si}\ \vdash \phi\left(e\right) \mathrm{et} \vdash e \Rightarrow v\ \mathrm{alors}\ v \neq \bot$
> $e$ est bien typee et ne contient pas de variables non definie

**Question**: Comment construire $\phi\left(e\right)$ selon l'erreur que l'on veut eliminer?

#### Etape 1
Distinguer dans les regles de semantique, celles qui peuvent faire apparaitre l'erreur que l'on souhaite eliminer.

> **Exemple**
> Pour les variables non definies: $$\frac{x \notin \gamma}{\gamma \vdash x \Rightarrow \bot_{undef}}$$

Il faut donc prouver dans $\phi\left(e\right)$ que $x\notin \gamma$ ne peut pas se produire
$\gamma \vdash e\ : OK/KO$
$$\frac{x \notin \gamma}{\gamma \vdash x : KO}\ \ \frac{x \in \gamma}{\gamma \vdash x : OK}$$

#### Etape 2
Definir un jugement de verification
$\gamma \vdash e\ : OK/KO$
> **Exemple**
> Typage $\gamma \vdash e : \delta$
> $\delta$ est le type de $e$ peut etre $OK$ avec type ou $KO$ si erreur de type

#### Etape 3
Adapter les regles d'evaluation a la preuve de cette propriete.
$\rightarrow$ Definir une execution abstraite
Il s'agit de l'interpretation abstraite (UE Certification Logiciel, Cours Verification par Analyse Statique). CF travaux de Patric Courot

$$\frac{\gamma \vdash \mathrm{par} \Rightarrow \mathrm{val}\ \mathrm{val}\in dom\left(\mathrm{op}\right)\ \mathrm{res}=\mathrm{op}\left(\mathrm{val}\right)}{\gamma \vdash \mathrm{op\ par} \Rightarrow \mathrm{res}}$$$$\frac{\gamma \vdash \mathrm{par} \Rightarrow \mathrm{val}\ \mathrm{val}\in dom\left(\mathrm{op}\right)}{\gamma \vdash \mathrm{op\ par} \Rightarrow \bot_{type}}$$

Plus de sens : fusion des deux regles.

$$\frac{\gamma \vdash \mathrm{par} : OK}{\gamma \vdash \mathrm{op\ par} : OK}$$$$\frac{\gamma \vdash \mathrm{par} : KO}{\gamma \vdash \mathrm{op\ par} : KO}$$$$\frac{\gamma \vdash \mathrm{par} : \bot}{\gamma \vdash \mathrm{op\ par} : \bot}$$
Toutes sont identiques donc fusionnee

$$\frac{\gamma \vdash e_1 : OK\ \gamma \vdash e_2 : OK\ \gamma \vdash e_3 : OK}{\gamma \vdash \mathrm{if}\ e_1\ \mathrm{then}\ e_2\ \mathrm{else}\ e_3 : OK}$$$$\frac{\exists i \in \left\{1,2,3\right\}\ \gamma \vdash e_i : KO}{\gamma \vdash \mathrm{if}\ e_1\ \mathrm{then}\ e_2\ \mathrm{else}\ e_3 : KO}$$

Faisons desormais une seule regle.

> **Remarque**
> La partie $KO$ peut etre representee comme le complementaire de la partie $OK$, il suffit donc de decrire la partie $OK$

$$\gamma \vdash \mathrm{fun}\ x \rightarrow e \Rightarrow \left<\mathrm{fun}\ x \rightarrow e, \gamma\right>$$
On va transferer a la definition de la fonciton. Ceci va touours donner le meme resultat.
$$\frac{\gamma_{eval} \vdash e_1 \Rightarrow\left<\mathrm{fun}\ x \rightarrow e_3, \gamma_{def}\right>\ \gamma_{eval} \vdash e_2 \Rightarrow \mathrm{val}\ \gamma_{def} \cup\left\{x\rightarrow \mathrm{val}\right\} \vdash e_3 \Rightarrow \mathrm{res}}{}$$
Peut-on le faire en une seule fois au lieu de le refaire a chaque appel de fonction.
> *Definition de fonction*
> $$\frac{\gamma \cup \left\{x\right\} \vdash e : OK}{\gamma \vdash \mathrm{fun}\ x\rightarrow e : OK}$$
> *Appel de fonction*
> $$\frac{\gamma \vdash e_1 : OK\ \gamma \vdash e_2 : OK}{\gamma \vdash \left(e_1,e_2\right) : OK}$$

$$\frac{\gamma \cup \left\{f \vdash \left<\mathrm{let\ rec}\ f=e_1\ \mathrm{in}\ e_2, \gamma\right>\right\} \vdash e_2 \Rightarrow v}{\gamma \vdash \mathrm{let\ rec}\ f=e_1\ \mathrm{in}\ e_2 \Rightarrow v}$$$$\frac{f \in \gamma_{eval}\ \gamma_eval\left(f\right) = \left<e,\gamma_{def}\right>\ \gamma_{def} \vdash e \Rightarrow v}{\gamma_{eval} \vdash f \Rightarrow v}$$$$\frac{\gamma \cup \left\{f\right\} \vdash e_1 : OK\ \gamma \cup \left\{f\right\}\vdash e_2 : OK}{\gamma \vdash \mathrm{let\ rec}\ f=e_1\ \mathrm{in}\ e_2 : OK}$$

En Caml:
```ocaml
let rec def_of_expr expr env = 
	match expr with
		| IntegerNode(-) ->  true
		| UnaryNode(-, par) -> (def_of_expr par)
```

### Cas du typage
Un type est un regroupement de valeurs compatibles vis a vis des erreurs de typage $\bot_{type}$.

#### Etape 2
Reperer les regles qui font apparaitre les erreurs de type
$$\frac{\gamma \vdash \mathrm{par} \Rightarrow \mathrm{val}\ \mathrm{val}\notin dom\left(\mathrm{op}\right)}{\gamma \vdash \mathrm{op\ par} \Rightarrow \bot_{type}}$$$$\frac{\gamma \vdash e_1 \mathrm{val}\ \mathrm{val} \notin \left\{true, false\right\}}{\gamma \vdash \mathrm{if}\ e_1\ \mathrm{then}\ e_2\ \mathrm{else}\ e_3 \Rightarrow \bot_{type}}$$

> **Dans ce cas**
> $\delta ::=\mathrm{bool\ |\ int\ |}\ \delta\rightarrow \delta$
> **Valeur associees**
> $\left[\mathrm{bool}\right] = \left\{true, false, \bot_{runtime}\right\}$
> $\left[\mathrm{int}\right] = \mathbb{Z} \cup \left\{\bot_{runtime}\right\}$

#### Etape 2
Jugement du typage $\sigma \vdash expr : \delta$
$\left\{x_i, \delta_i\right\}$ l'environnement associe un type a chaque variable

#### Etape 3
Construire les regles de typage a partir des regles d'evaluation

## Semantique attribuee, Grammaire attribuee
**Objectif**: Methode de conception d'outils semantiques et formalisme de description de ces outils pour les generer automatiquement

```flow
en=>start: Flux de caracteres
lex=>operation: Analyse Lexicale
syn=>operation: Flux d'Unites Lexicales
sem=>operation: Analyse Syntaxique
as=>operation: Arbre Syntaxique
caa=>operation: Construction de l'Arbre Abstrait
ast=>operation: Abstract Syntax Tree
typ=>operation: Typage
so=>end: Interpretation

en->lex->syn->sem->as->caa->ast->typ->so
```
La grammaire ainsi produite n'est pas $LL(1)$.
Il faudrait donc l'adapter de la maniere suivante:
| $E \rightarrow T \quad S_T$   | $T \rightarrow F \quad S_F$     |
| ----------------------------- | ------------------------------- |
| $T \rightarrow + T \quad S_T$ | $S_F \rightarrow x F \quad S_F$ |
| $T \rightarrow \Lambda$       | $S_F \rightarrow \Lambda$       |

Avec une grammaire $LL(1)$, l'arbre syntaxique est difficile a exploiter directement. Il est necessaire de construire l'arbre abstrait avant d'ecrire les etapes suivantes de semantique.

> **Bilan**
> L'arbre syntaxique est produie de l'arbre abstrit, les etapes suivantes manipulent larbre syntaxique, sinon il faudrait une etape de construction de l'arbre abstrait.

Des lors, pour obtenir la semantique, on procede ainsi:
```flow
an=>start: Analyse de la Forme
ar=>condition: Arbre
sy=>operation: Syntaxique
ab=>operation: Abstrait

an->ar
ar->sy
ar->ab
```

La definition d'une semantique s'appuie donc sur une structure d'arbre (plus generalement de [*graphe enracine*][3])
> **Definition**: Graphe enracinee
> Il existe un noeud du graphe a partir duquel on peut atteindre tous les autres noeuds
> Le graphe est connexe, et donc il existe un arbre de recouverment dont la racine est le noeud considere.

La semantique peut etre definie comme une caracteristique, une propriete de cet arbre. En particulier, de la racine de l'arbre.
> **Exemple**
> | Semantique souhaitee |   Arbre    |
> | :------------------: | :--------: |
> |         type         | expression |
> |        valeur        | expression |

On cherche alors

> **Definition**: Attribut semantique
> Information semantiques associees aux noeuds de l'arbre

```ocaml
+ type = int   valeur = 7 = 1+6
└─── 1 type = int   valeur = 1
└─── x type = int   valeur = 6 = 2x3
│   └─── 2 type = int   valeur = 2
│   └─── 3 type = int   valeur = 3
```
Il s'agit d'un arbre decore/attribue ce qui correspond moralement a un arbre syntaxique/abstrait avec la valeurs des attributs semantiques.

### Conception d'une semantique
#### Etape 1
1. Prendre exemples sous la forme d'arbres.
2. Decorer ces exemples.

#### Etape 2
1. Identifier pour chaque noeud les relations entre ses attributs semantiques et les attribus semantiques de ses fils et de son pere.
$\Rightarrow$ dependance entre les valeurs des attributs
2. Identifier les regles de calculs

$$\frac{\gamma \vdash e_1 \Rightarrow v_1\ \gamma \vdash e_2 \Rightarrow v_2}{\gamma \vdash e_1+e_2 \Rightarrow v_1 \Rightarrow v_1+v_2}$$

Noeud addition:
```ocaml
type ast =
	BinaryExpression of ast*binary*ast
match exp with
	| BinaryExpression(e1, Addition, e2) ->
		let v1 = (value_of_expr e1) in
		let v2 = (value_of_expr e2) in
```

```java
class Addition {
	/**
	 * gauche: correspond a e1
	 * droite: correspond a e2
	 */
	private Expression gauche, droite;
	
	/**
	 * gauche.value(): correspond a v1
	 * droite.value(): correspond a v2
	 */
	public int value() {
		return gauche.value() + droite.value();
	}
}
```

Choix d'une forme plus abstraite que les programmes : **equations semantiques** associees aux noeuds de l'arbre.

Pour cela, nous utiliserons la grammaire la plus simple possible des expressions: $E \rightarrow E_1 + E_2$ ($E_1$, $E_2$ fils de $E$)
On a donc la relation suivantes entre les attributs semantiques de $E$, $E_1$, $E_2$: $E\cdot\mathrm{valeur} \rightarrow E_1\cdot\mathrm{valeur} + E_2\cdot\mathrm{valeur}$

#### Etape 3
1. Pour chaque noeud de l'arbre, ecrire une regle de production qui fait apparaitre les fils du noeud telle que l'arbre abstrait et l'arbre syntaxique soient isomorphes structurellement.
2. Ecrire les equations semantiques liant les valeurs des attributs semantiques du noeud et de ses fils.

> **Exemple**
>
>  + $E \rightarrow E_1 \times E_2$
>  $E\cdot\mathrm{valeur} \rightarrow E_1\cdot\mathrm{valeur} \times E_2\cdot\mathrm{valeur}$
>  + $E \rightarrow - E_1$
>  $E\cdot\mathrm{valeur} \rightarrow - E_1\cdot\mathrm{valeur}$
>  + $E \rightarrow \mathrm{constante}$ Unite lexicale correspondant a une chaine de caractere. Attribut predefini: texte
>  $E\cdot\mathrm{valeur} \rightarrow \mathrm{conversionTexteEntier}\left( \mathrm{constante} \cdot \mathrm{texte}\right)$

On arrive ainsi a la definition suivante
> **Definition**: Grammaire attribuee
> $\left( A, V, S, \left\{ X_i \rightarrow \alpha_i \right\} \right)$
> $A$: alphabet terminaux avec attribut $\mathrm{texte}$
> $V$: non terminaux
> $S \in V$: axiome
> $X_i \rightarrow \alpha_i$: regles de production

Chaque non terminal possede des attributs semantiques.
Chaque regle de production possede des equations semantiques.

> **Remarque**
> Touts les generateurs d'analyseurs syntaxiques exploitent des grammaires attribuees. Les equations sont ecrites dans le langage genere.

**Probleme**: La grammaire sera contrainte par les outils d'analyse syntaxique ($LR$ opur *Yacc*, $LL$ pour *ANTLR*).

|                        Avec ambiguite                        |                        Sans ambiguite                        |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| $$E \rightarrow E_1 + E_2$$$$E\cdot\mathrm{valeur} \rightarrow E_1\cdot\mathrm{valeur} + E_2\cdot\mathrm{valeur}$$ | $$E \rightarrow E_1 + T$$$$E\cdot\mathrm{valeur} \rightarrow E_1\cdot\mathrm{valeur} + T\cdot\mathrm{valeur}$$ |

Ensuite, li faut encore passer a une version $LL(1)$.
$$E \rightarrow + T \quad S_T$$$$S_T\cdot\mathrm{valeur\_heritee} \rightarrow T\cdot\mathrm{valeur}$$$$S_T \rightarrow + T \quad S_{T_1}$$$$S_{T_1}\cdot\mathrm{valeur\_heritee} \rightarrow S_T\cdot\mathrm{valeur\_heritee} + T\cdot\mathrm{valeur}$$$$S_T \rightarrow \Lambda$$$$S_T\cdot\mathrm{valeur} = S_T\cdot\mathrm{valeur\_heritee}$$
Cette version est clairement trop complexe.
La **solution** est de faire une grammaire attribuee pour construire l'arbre abstrait puis exploiter l'arbre abstrait ensuite.

Grammaire S-attribuee. On calcule de bas en haut selon un processus simple. Les attributs sont dit synthetises.
```ocaml
E valeur = 7 = 1+6
└─── E valeur = 1
│   └─── T valeur = 1
│   │   └─── F valeur = 1
└─── +
└─── T valeur = 6 = 2x3
│   └─── T valeur = 2
│   │   └─── F valeur = 2
│   └─── x
│   └─── F valeur = 3
```

> **Definition** 
> 2 natures pour des attributs semantiques
>
> + herites: calcul de haut en bas: parents $\rightarrow$ fils
> + synthetises: calcul de bas en haut: fils $\rightarrow$ parents
>
> On declare ainsi l'ecriture de la grammaire. Cela impose des contraintes sur la forme des equations.
> La valeur d'un attribut heritee est calculee pour les noeuds fils.
> $E \rightarrow T \quad S_T$
> $S_T \cdot \mathrm{valeur\_heritee} = T \cdot \mathrm{valeur}$ partie droite: fils de $E$
> $E \cdot \mathrm{valeur} = S_T \cdot \mathrm{valeur}$ partie gauche: noeud lui-meme
> La valeur d'un attribut est calculee pour le noeud lui meme.

Le outils de la familles $LR$ (Yacc et Compagnie) ne peuvent traiter que des grammaire S-attribuees (attributs synthetises). Les outils de la famille $LL$ peuvent traiter des grammaires L-attribuees (attributs synthetises et herites).

> Attribut semantique: valeur pour $E$
> $E \rightarrow \mathrm{ident}$
> Si $\mathrm{ident}\cdot{texte} \in \gamma(\mathrm{ident}\cdot\mathrm{texte})$
> alors $E\cdot\mathrm{valeur}=\gamma(\mathrm{ident}\cdot\mathrm{texte})$
> alors $E\cdot\mathrm{valeur}=\mathrm{Erreur}(\mathrm{Ident Not Defined})$
> Il s'agit d'un attribut semantique : environnement pour E

### Avantage Grammaire attribuee
Notation generale pour specifier/ implanter des semantiques.
$E \rightarrow E_1 + E_2$
1. $E_1 \cdot \mathrm{env} = E \cdot \mathrm{env}$ *avant $E_1$ car initialise attribut heritee $\mathrm{env}$*
2. $E_2 \cdot \mathrm{env} = E \cdot \mathrm{env}$ *avant $E_2$ car initialise attribut heritee $\mathrm{env}$*
3. $E \cdot \mathrm{val} = E_1 \cdot \mathrm{val} + E_2 \cdot \mathrm{val}$ *apres $E_1$ car utilise  $E_1 \cdot \mathrm{val}$* et *apres $E_2$ car utilise  $E_2 \cdot \mathrm{val}$*

> **Definition**: Schema de Traduction sequencement des equations
> Ordre dans lequel il faut executer les equations semantiques

### Methode pour definir semantique attribuee
#### Etape 1
Identifier les informations disponibles pour calculer semantique

+ attribut semantiques des terminaux (feuille arbre) (synthetises)
+ attributs semantqieus herites par la racine de l'arbre
$S \rightarrow E$ attribut herite pour $S$ environnement
$E\rightarrow \mathrm{constante}$ attribut synthetise pour $\mathrm{constante}$ texte

Identifier les informations calculees par
+ semantique
+ attributs synthetises pour racine

#### Etape 2
Identifier les intermediaires de calcul
attributs de chaque noeud de l'arbre
+ attribut herite pour $E$: environnement
+ attribut synthetise pour $E$: valeur

Pour cela, on utilise des exemples simples mais representatifs. Ils ont pour but d'illustrer les differents noeuds possibles dans l'arbre: au moins appliquer chaque regle de production
> **Exemple**: $x+2\times(3)$

#### Etape 3
Ecrire les equations semantiques
$E \rightarrow E_1 \times E_2$
$E \cdot \mathrm{val} = E_1 \cdot \mathrm{val} E_2 \cdot \mathrm{val}$

#### Etape 4
Annoter les regles de production avec l'ordre de calcul des equations
Ordre de calcul des equations

#### Etape 5
Implanter la semantique attribuee avec un outil

+ Si travail sur arbre abstrait une fonciton de parcours de l'arbre abstrait

```ocaml
let rec value_of_expr expr env =
	match expr with
	| BinaryNode (left, op, right) ->
	... (* equations semantiques *)
```

```java
class Addition extends {
	
	/**
	 * equations semantiques
	 */
	int value(Environnement env) {
		return left.value() + right.value();
	}
}
```

+ si travail sur arbre syntacique: outil generateur d'analyseur syntaxique
+ famille $LR$ (Yacc, Lison, OcamlYacc, ...) *uniquement des attributs synthetises*

> **en Yacc (actions code C)**
> ```yacc
> %%
> E : E PLUS E \{\$\$ = \$1 + \$3;}
> | INTEGER  {\$\$ = atoi(\$1);}
> ```

+ famille $LL$ (ANTLR, EGG)
> Grammaire $L$-attribuee: calcul des actions de gauche a droite
> calcul des actions de gauche a droite
> attributs herite et sunthetises
> **MAIS** grammaire $LL$
>
>  + pas de recursivite a gauche
>  factorisationa gauche
>     $E \rightarrow T \ S_T$
>     $S_T \cdot \mathrm{valeur} = T \cdot \mathrm{valeur}$
>     $E \cdot \mathrm{valeur} = S_T \cdot \mathrm{valeur}$
>     $T \rightarrow F \ S_F$
>     $S_F \cdot \mathrm{valeur\_heritee} = F \cdot \mathrm{valeur}$
>     $T \cdot \mathrm{valeur} = S_F \cdot \mathrm{valeur}$
>     $S_T \rightarrow + T \ S_{T_1}$
>     $S_{T_1} \cdot \mathrm{valeur\_heritee} = S_T \cdot \mathrm{valeur\_heritee} + T \cdot \mathrm{valeur}$
>     $S_T \cdot \mathrm{valeur} = S_{T_1} \cdot \mathrm{valeur}$
>     $S_T \rightarrow \Omega$
>     $S_T \cdot \mathrm{valeur} = S_T \cdot \mathrm{valeur\_heritee}$

#### Etat de l'art actuel
Generateur analyseur syntaxique avec grammaire attribuee pour construire un arbre abstrait avec l'outil *EGG*
Puis exploitation de l'arbre abstrait en *Java*

### Arbres abstraits

> **Objectif**: modele de donnes des informations necessaires pour implanter la semantique
> >**Remarque**: dans le cas d'un generateur de code, tout est necessaire
>
> $\mathrm{ast}$: attributs synthetises pour $E$ et $S$
> $S \rightarrow E$ $S \cdot \mathrm{ast} \rightarrow E \cdot \mathrm{ast}$
> $E \rightarrow E_1 + E_2$ $ E \cdot \mathrm{ast} = E  \cdot \mathrm{factory}\cdot \mathrm{createFactoryExpression}\left(E_1 \cdot \mathrm{ast}, addition, E_2  \cdot \mathrm{ast}\right)$
> $E \rightarrow \left( E_1 \right)$ $E \cdot \mathrm{ast} \rightarrow \left( E_1  \cdot \mathrm{ast}\right)$
> $E \rightarrow \mathrm{constante}$ $ E \cdot \mathrm{ast} = E  \cdot \mathrm{factory}\cdot \mathrm{createIntegerValue}\left(\mathrm{cst}: \mathrm{texte}\right)$
> $\mathrm{factory}$: attribut herite pour $E$ et $S$
> *EGG* permet l'heritage automatiqe des attributs herites qui ne sont pas modifies explicitement

Arbre abstrait contenant juste les informations necesssaires pour la semantique

> **Exemple**: verification definition des identificateurs

Information necessaire: liste des identificateurs definis et utilises

> **Exemple**
> ```ocaml
> { int i = 0;
> print i+1;
> }
> ```

Pour eviter de rechercher plusieurs fois la declaration d'une variation a chacune de ses utilisations, il serait utile de construire un lien entre utilisation et declaration.
On partage ainsi certaine parties de l'arbre abstrait complet.
Le graphe abstrait est constitue de l'abre abstrait et des liens entre declarations et utilisations.

Lors de la construction de ce graphe abstrait (que l'on nomme toujours arbre) pour chaque utilisation d'une variable, il faudra retrouver la declaration associee et construire le lien.
Pour eviter de parcourir a chaque recherche la structure d'ordre, nous utilisaons une table de symboles qui collecte les definitions.

### Table de symboles - Espace de noms

> **Definition**: Table des symboles
> Structure de donnees qui associe a chaque identifiacteur sa definition

Il peut y avoir differentes categories d'identificateurs (paquetage, interface, classe, ...)
> **Remarque**
> Un identificateur peuvent avoir des regles d'utilisations differentes.
> *Peut-on utiliser un identificateur pour des definitions de natures differentes?*
>
> > **Exemples**
> > 	>
> > 	> + Utiliser un meme identificateur pour une interface et une classe?
> > 	> En `Java` non sauf si ils sont dans des paquetages differents.
> > 	> + utiliser un meme identificateur pour un paquetage et un attribut?
> > 	> En `Java` on ne sait pas
> > 	> + utiliser un meme identificateur pour un attribut, un parametre, une variab le locale?
> > 	> En `Java` oui

Les regles d'utilisation des identifications (de reutilisation souvent), de visibilite (lorsque nous utilisons un identificateur, quelle est la definition referencee) font partie de la semantique statique du langage.

> **Exemple**
> Une definition de classe Java est visible dans son paquetage de definition et dans les elements qui importent le paquetage ou cette classe.

Un **espace de noms** est donc un groupe d'identificateurs ayant une meme portee, une meme visibilite.

> **Exemple**
> paquetage Java ayant un espace de nom pour interface, classe, enumeration
> classe Java ayant un espace de nom pour attributs, methodes, constructeurs, parametres.

Une table des symboles est une structure de donnees qui permet de gerer les espaces de noms.

**Question**: Comment gerer une table de symboles pour le langage suivant
`class X {int a; void m(boolean a) {float a; if (...) char a;}}

+ Reponse 1: Gerer comme une pile et depiler en sortant de l'espace de nom
+ Reponse 2: Imbriquer les espaces de noms

> Espace nom classe
> > XXX: Espace de nom des attributs, methodes, constructeurs
> > > a
> > > m
> > > > Espace de nom des parametres
> > > > a
> > > > bloc : espace de nom des variables locales
> > > > > a

La recherche dans un espace de nom, table des symboles commence dans l'espace courant puis rtemonte recursivement dans les espaces englobants jusqu'a la racine de cette hierarchie (en Java les paquetages).

> **Probleme**
> ```java
> {int a; boolean a;};
> ```
> Interdit en Java car lors de l'analyse d'une nouvelle definition, on recherche si elle existe deja et on signale une erreur de redefinition.

On a donc 2 methodes de recherhce

+ Une locale a l'espace de noms
+ Une globale a la hierarchie d'espace de noms.

Chercher global si chercher local alors succes sinon englobant chercher global.

> **Exemple**
> $E \rightarrow E\ \mathrm{op}\ E$
> $E \rightarrow \mathrm{op}\ E$
> $E \rightarrow \mathrm{constante}$
> $E \rightarrow \left( E \right)$
> $E \rightarrow \mathrm{ident}$

Objet de la gestion de la table des symboles:

+ Verifier qu'une variable est bien definie
+ Acceder a sa definition

Donnee en entree: table des symboles attributs herite pour $E$
Action semantique : transmission de la table des symboles.
$E \rightarrow E_1\ \mathrm{op}\ E_2$ devient $E_1\cdot \mathrm{tds}=E\cdot \mathrm{tds}$ et $E_2\cdot \mathrm{tds}=E\cdot \mathrm{tds}$
$E \rightarrow \mathrm{op}\ E_1$ devient $E_1\cdot \mathrm{tds}=E\cdot \mathrm{tds}$
$E \rightarrow \left( E_1 \right)$ devient $E_1\cdot \mathrm{tds}=E\cdot \mathrm{tds}$

> *EGG* automatise l'heritage

```flow
pg=>start: Programme
lx=>operation: Lexical Syntaxique
aa=>operation: Arbre abstrait
Table des Symboles
ty=>operation: Typage
am=>operation: Allocation Memoire
gc=>end: Generation de code

pg->lx->aa->ty->am->gc
```

#### Representation des types

![Typage](https://github.com/thibmeu/enseeiht/raw/master/2IMA/SemantiqueEtTraductionDesLangages/typage.png)

+ **merge**: plus petite borne superieure de 2 type dans la relation de sous-typage

#### Calcul des types: les valeurs ont un type

Verification du bon typage: les instructions manipulent des valeurs, il faut verifier les compatibilites des types des valeurs manipulees

+ affectations
+ passage de parametres

Il existe **differentes** forme de typage. Le typage est une approximation de l'execution

+ **Type reel**: type de creation de la valeur
+ **Type apparent**: type declare/calcule des variables
```java
Point p = condition ? (new PointNomme()) : (new PointColore());
```

> **Cas des faux positifs**
> ```java
> if (condition) {
> 	(condition ? (new PointNomme()) : (new PointColore())).getNom();
> }
> ```
> Rejet par le compilateur alors qu'il n'y a pas d'erreurs. A cause de l'approximation introduit par le typage, il peut apparaitre des "*faux positif*" (erreur imaginaires) dectecte lors du typage.

Il faut donc faire un compromis entre la correction du typage et la limitation des "*faux positifs*"

+ **typage fort**: aucune erreur a l'execution
+ **typage faible**: aucun faux positif $\rightarrow$ verification a l'execution
+ **typage statique**: avant execution
+ **typage dynamique**: pendant l'execution
+ **typage intermediare**: typage "*souple*", on fait un peu des deux

#### Polymorphisme
> **Definition**
> Autoriser une forme de melange des types pour faciliter la programmation, rendre le langage plus expressif

On denombre plusieurs sortes de polymorphismes:

+ **universel**: infinite de type compatible $\rightarrow$ similarite dans la representation des valeurs
	+ *parametrique*: variables de type / genericite
	+ *sous typage*: introduit une relarion de compatibilite (ordre partiel)
+ **ad hoc**: nombre fini de types compatibles $\rightarrow$ format des donnees heterogenes et fonction de conversion
	+ *coercition*: foncitons de conversion d'un type a l'autre
	+ *surcharge*: nombre fini de definition d'un meme symbole

#### Relation de compatibilite et effets de bords
> **Rappel**
> La compatibilite est la fait qu'un type reel soit compatible avec le type apparent

+ **checkType** de affectation
$T_G\ x_G;$
$T_D\ x_D;$
$x_G=x_D; \quad T_D \leq T_G$
+ **checkType** de appel de fonction
$T_R\ f(T_P);$
$x_G=f(x_D);$
$T_D\ x_D$
$T_D \leq T_P$
$T_G \leq T_R$

$$\frac{\sigma \vdash x : T_G\ \sigma \vdash E : T_D \ T_D \leq T_G}{\sigma \vdash x=E}$$$$\frac{\sigma \vdash f : T_P \rightarrow T_R \ \sigma \vdash E : T_E \ T_E \leq T_P}{\sigma \vdash f\left(E\right):T_R}$$

> **Remarque**
> Les fonctions sont des valeurs donc il y a une compatibilite de type sur les fonctions

$f: T_{P_1} \rightarrow T_{R_1}$
$g: T_{P_2} \rightarrow T_{R_2}$
$f=g;$
$x_G=f\left(x_D\right);$
$T_{P_2} \rightarrow T_{R_2} \leq T_{P_1} \rightarrow T_{R_1}$
$T_D \leq T_{P_1}$
$T_{R_1} \leq T_G$

> **Remarque**
> 1. Tous les parametres que $f$ accepte doivent etre acceptes par $g$: $T_{P_1} \leq T_{P_2}$.
>  Par transitivite: $T_D \leq T_{P_1} \land T_{P_1} \leq T_{P_2} \Rightarrow T_D \leq T_{P_2}$
> 2. Tous les resultats de $g$ doivent etre compatibles avec les resultats de $f$: $T_{R_2} \leq T_{R_1}$
> Par transitivite: $T_{P_2} \rightarrow T_{R_2} \leq T_{P_1} \rightarrow T_{R_1}$

#### Contravariance du sous typage des fonctions
$T_{P_2} \rightarrow T_{R_2} \leq T_{P_1} \rightarrow T_{R_1} \Leftrightarrow T_{P_1} \leq T_{P_2} \land T_{R_2} \leq T_{R_1}$

Redefinition des methodes:
```java
class Point {
	boolean equals(Point);
}
class PointColore extends Point {
	boolean equals(Point /*PointColore*/);
	/* On aurait aime mettre le equals pour des pointcolores mais le typage impose de mettre Point --> instanceof*/
}
```

> **Plantage historique de Java**
> ```java
> PointColore tabC[] = new PointColore[10];
> Point tab[] = tabC;
> tab[0] = new PointColore(...);
> (tab[0]).getCouleur();
> /* Dans les versions actuelles de Java la ligne suivante leve une ClassCastException grace a un typage souple */
> tab[0] = new Point(...);
> tabC[0].getCouleur();
> ```
> Les createurs du langage avait defini le sous typage des tableaux ainsi
> $\mathrm{PointColore}\left[\right] \leq \mathrm{Point}\left[\right]$
> Pour resoudre ce probleme, Java est passe a une typage statique moins contraignant et a une verification statique a l'execution.

$T_G\ tabG\left[\right];$
$T_D\ tabD\left[\right];$
$tabG=tabD; \quad T_D\left[\right] \leq T_G\left[\right]$
$tabG\left[0\right] = v;$
$r = tabG\left[0\right];$
$T_V \leq T_G \leq T_D$: transitivite pour la correction des affectations (ecriture)
$T_D \leq T_G \leq T_R$: transitivite pour la correction des lectures

$T_D\left[\right] \leq T_G\left[\right] \Leftrightarrow T_D=T_G$

> **Remarque**: pointeur = tableau a une case
> $T_D\ast \leq T_G\ast \Leftrightarrow T_D=T_G$
>
> **Attention**: Cela ne veut pas dire qu'il est interdit de manipuler des adresses. Le probleme est lie a la lecture et ecriture dans une zone memoire a travers deux adresses de type different. Il n'y a aucun probleme a faire des acces en lecture seule.

### Traitement des fonctions
```c
int f(int x) {
    return x+1;
}
```

```tam
print f(1);
LOADL 1		;empiler parametre reel
CALL -f		;appeler la fonction qui depile 1 et empile le resultat 2
SUBR Iout	;afficher l'entier en sommet de pile
```

```tam
-f
    ;lire la valeur de x
    LOAD (1) -4[LB]
    ;valeur 1
    LOADL 1
    SUBR IADD
    ;enlever parametre
    ;mettre le resultat a la place
    return (1) 1 ;meme principe que push
```

Sur le meme principe, comment faire la fonction suivante
```c
int f(int x) {
    if (x == 0) {
        return 0;
    } else {
        return (1+f(x-1));
    }
}
```
```tam
-f
    ;lire la valeur de x
    LOAD (1) -4[LB]
    ;valeur 1
    LOADL 1
    SUBR IADD
    ;enlever parametre
    ;mettre le resultat a la place
    return (1) 1 ;meme principe que push
```

### Travaux pratiques
L'ensemble des travaux pratiques est disponible sur Github a l'adresse suivante: [TP Semantique des traducitons des langages](https://github.com/thibmeu/enseeiht/tree/master/2IMA/SemantiqueEtTraductionDesLangages). Les fichiers de corrections sont donnes a titre indicatif et peuvent ne pas s'averer complets.


[1]: https://en.wikipedia.org/wiki/Coq
[2]: https://en.wikipedia.org/wiki/Xml
[3]: https://fr.wikipedia.org/wiki/Arbre_enracin%C3%A9