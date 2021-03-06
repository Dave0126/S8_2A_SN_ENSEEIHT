### 算数
最基本的整数算数运算包含在 TLA+ 的 `Integers module` 里面，主要就是常用的 `+`，`-`，`*`，`^`，`%` 这些，还包括 `>`，`<`，`>=`，`<=` 等。

`Integers module` 同时定义了：

- `Int`：所有整数
- `Nat`：所有自然数
- `..`：`m..n` 表示了从 `m` 到 `n` 之间的所有整数集合
对于 `/`，则是在 Real module 里面定义了。Real module 也同时定义了`Real`用来表示所有的实数。

### 逻辑
在 TLA+ 里面，`TRUE` 表示真，而 `FALSE` 则是假。譬如 1 + 1 = 2 的值是 TRUE，而 1 + 1 = 3 的值是 FALSE。

### 命题逻辑
跟整数有加减乘除运算符一样，布尔也有相关的命题逻辑运算符，我们需要知道如下 5 个：

- `/\`：and，当且只有 F 和 G 都等于 TRUE，`F /\ G` 等于 TRUE
- `\/`：or，当且只有 F 或者 G 一个等于 TRUE（或者都为 TRUE），`F \/ G` 等于 TRUE
- `~`：negation，当且只有 `F` 等于 FALSE，`~F` 等于 TRUE
- `=>`：implication，当且只有 F 等于 FALSE 或者 G 等于 TRUE（或者 F 和 G 都为 TRUE 或者 FALSE），`F => G` 等于 TRUE
- `<=>`：equivalence，当且只有 F 和 G 都为 TRUE 或者都为 FALSE，`F <=> G` 等于 TRUE
这里我们可能对 `=>` 的定义感到困惑，为什么只有 F 为 TRUE 并且 G 为 FALSE 的时候 `F => G` 才为 FALSE，我们可以通过 `(n > 5) => (n > 3)` 来说明，对于整数 n 来说，如果 n 为 6，`n > 5` 就是 TRUE，自然 `n > 3` 也是 TRUE，也就是 `(n > 5)` 蕴含着 `(n > 3)`，我们可以将 n 设置为 1，4 这些值在自行推导。

### 谓语逻辑
在命题逻辑基础上，谓语逻辑扩展了两个运算符，我们叫做量词。一个是`全称量词 \A`，另一个则是`存在量词 \E`。
- 对于公式 `\A x \in S: P(x)` 来说，在集合 `S` 里面所有的 `x`，`P(x)` 都必须等于 TRUE，那么该公式值才是 TRUE。
- 而对于 `\E x \in S: P(x)` 来说，只要 `S` 里面一个 `x` 存在 `P(x)` 等于 TRUE，那么该公式的值就是 TRUE。

### CHOOSE
CHOOSE 操作符类似于上面说的 `\E`。对于公式 `\E x \in S : P(x)` 来说，如果在集合 `S` 里面存在一个值 `x`，满足 `P(x)` 为 TRUE，那么 `CHOOSE x \in S : P(x)` 就等于这个值。

当使用 CHOOSE 在集合里面选择了一个值之后，每次执行都会使用这个值，譬如对于 `v' = CHOOSE n \in 1..10 : TRUE` 来说，我们并不知道 CHOOSE 选择了哪一个值，没准是 1，也没准是 10，但我们能够确定，每次执行都会是这个值。如果我们需要每次使用不同的值，可以通过 `\E n \in 1..10 : v' = n` 来设置。

### 集合
集合应该是 TLA+ 的理论基石，一个集合可能含有有限或者无限个数的元素。譬如所有自然数集合就是是一个无穷集合。集合主要有以下操作：

- `\intersect` 或者 `\cap`：两个集合的交集，譬如 `{1, 2} \intersect {2, 3} = {2}`
- `\union` 或者 `\cup`：两个集合的并集，譬如 `{1, 2} \union {2, 3} = {1, 2, 3}`
- `\subseteq`：一个集合是否是另一个集合的子集，譬如 `{1, 3} \subseteq {1, 2, 3}` 等于 TRUE
- `\`：两个集合的差集，譬如 `{1, 2, 3} \ {1, 4} = {2, 3}`
- `SUBSET`：集合的子集，譬如 `{1, 2}`的子集就是 `{{}, {1}, {2}, {1, 2}}`
- `UNION`：集合的并集，譬如 `{{1, 2}, {2, 3}, {3, 4}}` 的并集就是 `{1, 2, 3, 4}`
- `Cardinality(S)`：有限集合 `S` 中元素的个数
- `IsFiniteSet(S)`：验证集合 `S` 是否是有限的还是无限的

这里我们在重点关注两个集合的构造操作符：

- `{x \in S : P(x)}`：集合由在 `S` 中满足 `P(x)` 为 TRUE 的元素构造，譬如 `{n \in Nat : n % 2 = 1}` 就返回了一个偶数集合
- `{e(x) : x \in S}`：集合由在 `S` 中元素通过 `e(x)` 得到新值构造，譬如 `{2 * n + 1 : n \in Nat}` 就返回了一个奇数集合

### 函数
TLA+ 里面的函数跟我们程序里面的函数意义是不一样的，反倒有点类似于数组，这点一定要注意。

对于函数，首先我们需要了解的是值域，我们可以认为就是程序语言里面数组的索引集合，譬如对于 tuple（一种特殊的函数来说），`DOMAIN <<"a", "b", "c">>` 就是一个 `1..3` 的集合。

如果 f 是一个函数，而 x 是 f 值域里面的一个元素，`f[x]` 就表示的将 f 应用到 x 上面。对于上面的 tuple，`<<"a", "b", "c">>[2]` 就会得到 `"b"`，而 `<<"a", "b", "c">>[4]` 则会报错。

我们可以通过 `[x \in S |-> e]`构造任意值域的函数，这里仍然先以 tuple 为例， tuple，一种特殊的函数，它的值域就是集合 `1..n`，n 为 tuple 的个数。譬如 tuple 可以写成 `[ i \in 1..3 |-> i - 7]`，这个就会得到 tuple `<<-6, -5, -4>>`，然后我们可以使用 `<<-6, -5, -4>>[1]` 得到 `-6` 了。

我们再来看一个更通用的例子，`[i \in {2, 4, 6, 8} |-> i - 42][4]` ，这里我们得到的值是 `4 - 42`，也就是 `38`。

当一个函数 f 的值域在 S，并且 `f[x]` 在集合 T 里面，我们就可以用 `[S -> T]` 来表示所有这样函数的集合。

我们也可以使用 `EXCEPT` 来构造另一个函数，对于公式 `[f EXCEPT ![e1] = e2]` 表示新的函数 `f’` 等于 `f` 除了 `f'[e1] = e2`。我们也可以使用 `@` 来表示 `f[e1]`，譬如 `f' = [f EXCEPT ![e1] = f[e1] + 1` 中，我们就可以写成 `f' = [f EXCEPT ![e1] = @ + 1`

