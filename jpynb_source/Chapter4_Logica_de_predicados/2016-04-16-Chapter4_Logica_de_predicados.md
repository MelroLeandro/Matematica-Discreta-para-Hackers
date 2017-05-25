---
layout: post
title: "Capítulo 4 Lógica de Predicados"
subtitle: "Matemática Discreta para Hackers"
author:  Mellean
tags:   python
category:  python
visualworkflow: false
---

<!-- Start Writing Below in Markdown -->
Capítulo 4: Lógica de Predicados
======

Existem muitas afirmações que se fazem em Matemática que não podem ser simbolizadas e analisadas em termos de cálculo proposicional. Para além da complexidade externa introduzida pelas diferentes conectivas, uma afirmação pode conter complexidades internas que advém de palavras tais como ''todo'', ''cada'', ''algum'', etc. as quais requerem uma análise lógica que está para além do cálculo proposicional. Tal análise é o objecto da chamada \textbf{Lógica de Predicados}.

### Variáveis
No desenvolvimento de qualquer teoria, aparecem muitas vezes afirmações sobre objectos genéricos da teoria, que são representados por letras designadas de \textbf{variáveis}.

#### Predicado
Representando por *x* um número inteiro genérico, pode ser necessário analisar (sob o ponto de vista lógico) afirmações do tipo

> "*x* é maior que 3"

Como já foi referido, tal afirmação não é uma proposição: o seu valor lógico tanto pode ser verdade ou falso. Uma afirmação deste tipo denota-se genericamente por *P(x)* para mostrar que $P$ depende da variável $x$, obtendo-se assim, uma **fórmula** com uma **variável livre** *x*. Para evidenciar isso muitas vezes escrevemos:

> "*P(x):x* é maior que 3"

Substituindo *x* em *P(x)* por um dado valor, 6 por exemplo, obtém-se *P(6)* que é uma proposição: *P(6)* é uma proposição verdadeira; *P(2)*, no entanto, é uma proposição falsa. Neste sentido, *P* é designada por **função proposicional** ou **predicado**, e *P(x)* é designada de **expressão proposicional** ou **condição**.


### Conjuntos de verdade
Quando se estudam proposições - fórmulas sem variáveis livres - pode falar-se no seu valor lógico de verdade ou falsidade. Mas se uma fórmula contiver variáveis livres (uma ou mais) então não poderá falar-se no seu valor lógico e dizer simplesmente que tal fórmula é verdadeira ou falsa. O seu valor lógico depende do valor atribuído à variável (ou variáveis). A tais predicados associam-se então os chamados **conjuntos de verdade** que são os conjuntos de valores para os quais *p(x)* é verdadeira. Escreve-se com este sentido
$$
A=\{x:P(x)\}
$$
o que se lê da seguinte forma: *A* é o conjunto cujos elementos satisfazem *P(x)* ou para os quais *P(x)* é verdadeira. Observe-se que, reciprocamente, dado um conjunto *A* qualquer, pode sempre definir-se uma fórmula com variáveis livres que tem *A* por conjunto de verdade. Isso pode ser feito, por exemplo, pelo predicado
$$
P_A(x):''x\in A''
$$
e portanto
$$
A=\{x:P_A(x)\}.
$$

#### Paradoxo de Russel

Neste contexto a existência dum **conjunto universal** $\{x: x=x\}$ e dum **conjunto vazio** $\{x:x\neq x\}$ intuitivamente podem parecer razoáveis. No entanto, podem conduzir a situações paradoxais, como deu conta Bertrand Russel, por volta de 1901.

Russel começou por notar que se se adoptar a concepção intuitiva de conjunto, pode dizer-se que alguns conjuntos são membros de si próprios enquanto outros não o são. Um conjunto de cadeiras, por exemplo não é uma cadeira, não sendo assim um elemento de si próprio; no entanto, o conjunto de todas as ideias abstractas é, ele próprio, uma ideia abstracta, pelo que pertence a si própria. As propriedades "ser elemento de si próprio" e "não ser membro de si próprio" parecem assim ser propriedades perfeitamente adequadas para definir conjuntos.

Seja $R$ o conjunto de todos os conjuntos que não estão contidos em si próprio. Formalmente seja
$$
R=\{x:x\not\in x\}.
$$
Os problemas surgem quando nos questionamos se $R$ é elemento ou não de $R$. Porque:
1. Supondo que $R\in R$ temos por definição de $R$ que $R\not \in R$,
+ Supondo que $R\not \in R$ temos por definição de $R$ que $R \in R$.
Assim, a proposição $R \in R$ não tem valor lógico definido na Lógica Clássica contradizendo o *Princípio do terceiro excluído*.

Para evitar este tipo de problema vamos supor que todos os conjuntos considerados são constituídos por elementos de um conjunto $ U$ suficientemente grande, chamado **conjunto universal** ou **universo de discurso**. Neste sentido, um conjunto é uma entidade do tipo
$$
\{x\in U:P(x)\}
$$
onde supomos que o predicado *P* está definido para todo o valor de *x* em $U$.

A ideia de um conjunto universal estará sempre presente, mesmo quando não seja explicitamente mencionado.


### Universo de discurso
A atribuição de valores às variáveis duma condição $P(x_1,x_2,\ldots,x_n)$ permite definir proposições. No entanto
esta atribuição é limitada a um conjunto de valores do **universo de discurso** do predicado.

#### Exemplo:
Temos por exemplo:
1. $x=x$ tem por exemplos de universo de discurso: $\mathbb{R},\mathbb{N},\mathbb{Q}$ ou $\mathbb{C}$.
+ $\sqrt{y}\geq 4$ tem por exemplos de universo de discurso: $\mathbb{Q}^+,\mathbb{R}^+$
+ $\frac{1}{x}>3$ tem como possível universo de discurso por exemplo o conjunto dos reais diferentes de zero.

### Predicados impossíveis, possíveis e universais
Podemos assim classificar as expressões proposicionais em
1. \textbf{Impossíveis}, se não existem valores da variável, ou variáveis, no universo, ou universos, que a transformam numa proposição verdadeira.
+ \textbf{Possíveis}, se existem valores das variáveis no universo de discurso que a transformam numa proposição verdadeira. Podemos assim distinguir entre proposições:
     1. **Universais**, se são predicados verificados para todos os valores que as variáveis podem assumir no universo,
     +  **Contingentes (ou não universais)**, se não são predicados verificadas para todos os valores das variáveis.

#### Exemplo
Temos por exemplo:
1. $x^2+y^2>-4$, com $x\in \mathbb{R}$ e $y\in \mathbb{R}$, é condição universal;
+ $2n+1>0$ é condição universal em $\mathbb{N}$;
+ $|x|+|y|>0$, com $x$ e $y$ reais, é condição contingente, pois não é satisfeita com $x=0$ e $y=0$;
+ $n^2>5$ é condição contingente em $\mathbb{N}$, pois é condição possível não universal.

### Conjuntos de verdade e conectivas lógicas
uponha-se que $A$ é o conjunto de verdade da expressão proposicional $P(x)$ e $B$ é o conjunto de verdade da expressão proposicional $Q(x)$ no universo de discurso $U$. Então
$$A=\{x\in U:P(x)\}$$
$$B=\{x\in U:Q(x)\}$$
O conjunto de verdade da fórmula $P(x)\wedge Q(x)$ é tal que
$$
\{x\in U:P(x)\wedge Q(x)\}=A\cap B
$$
De modo semelhante,
$$
\{x\in U:P(x)\vee Q(x)\}=A\cup B
$$

#### Exemplo
Sendo $A=\{x\in U:P(x)\}$ e $B=\{x\in U:Q(x)\}$.
Determine os conjuntos de verdade das expressões proposicionais:
1. $\neg P(x)$
+ $\neg Q(x)$
+ $P(x)\wedge (\neg Q(x))$
+ $P(x)\rightarrow Q(x)$
+ $P(x)\leftrightarrow Q(x)$


### O quantificador universal

Como se referiu acima, uma fórmula $P(x)$, contendo uma variável $x$, pode ser verdadeira para alguns valores de $x$ pertencentes ao universo do discurso, e falsa para outros. Por vezes pretende-se dizer que uma dada fórmula $$P(x)$$ se verifica para todos os elementos $$x$$ do universo, i.e. $\{x\in U:P(x)\}=U$. Escreve-se então

''para todo o $x$, $P(x)$''

o que se representa, simbolicamente, por
$$\forall x\; P(x).$$
O símbolo $\forall$ é designado por quantificador universal. A fórmula anterior diz que $P(x)$ se verifica para todo o elemento $x$ ou que $P(x)$ se verifica universalmente. Sendo $U$ o universo de discurso, escrever $\forall x\; P(x)$ é equivalente a
$$\forall x[x\in U\rightarrow P(x)].$$
A quantificação universal pode ser feita apenas sobre uma parte de $U$. Assim, se $D$ designar um subconjunto próprio de $U$ e $P(x)$ for uma fórmula com uma variável cujo domínio é $D$, então
$$\forall x\in D: P(x) \text{ ou } \forall x\;[x\in D\rightarrow P(x)]$$
afirma que $P(x)$ se verifica para todo o $x\in D$.

#### Exemplo:
Podemos assim avaliar as proposições abaixo:
 - $\forall x(x=x)$ é verdade em $\mathbb{R}$;
 - $\forall x\in \mathbb{R}\forall y\in \mathbb{R}:x^2+y^2>-4$ é verdadeira;
 - $\forall n\in \mathbb{N}:2n+1>0$ é verdadeira;
 - $\forall x\forall y(|x|+|y|>0)$, é falsa no universo dos reais, pois não é satisfeita com $x=0$ e $y=0$;
 - $\forall n\in \mathbb{N}:n^2>5$ é falsa.
  
Note que, caso $D$ seja um conjunto finito, por exemplo
$$D=\{a_1,a_2,\ldots,a_n\}$$
escrever
$$ \forall x\in D: P(x)$$
é logicamente equivalente à conjunção
$$P(a_1)\wedge P(a_2)\wedge\ldots\wedge P(a_n)$$
o que mostra que a proposição não tem variáveis livres, tratando-se, portanto duma proposição. O mesmo significado pode ser dado no caso em que $D$ é um conjunto infinito correspondendo, neste caso, a um número infinito de conjunções.

#### Exemplo:
Note-se que a proposição 
$\forall x\in \{2,6,12,34\}:\;x\;$é um número par,
é uma proposição verdadeira e equivalente a escrever
(2 é um número par)$\wedge$(6 é um número par)$\wedge$(12 é um número par)$\wedge$(34 é um número par)

### O quantificador existencial
Por outro lado, escreve-se
$$\exists x\; P(x)$$
para significar que existe (no universo do discurso) pelo menos um elemento $x$ para o qual $P(x)$ se verifica, i.e. $\{x\in U:P(x)\}\neq\emptyset$, o que se pode ler:

''existe pelo menos um $x$ tal que $P(x)$''.

A fórmula $\exists x\; P(x)$ é uma abreviatura (usada normalmente) para a expressão
$$\exists x\;[x\in U \wedge P(x)],$$
onde $U$ designa o universo do discurso. O símbolo $\exists$ é chamado de \textbf{quantificador existencial}.

Se $D$ for um subconjunto de $U$ e $P(x)$ for uma fórmula com uma variável cujo domínio é $D$, então escrevemos
$$\exists x\in D: P(x)\text{ ou }\exists x\;[x\in D \wedge P(x)].$$
Supondo que $D$ é o conjunto finito,
$$D=\{a_1,a_2,\ldots,a_n\},$$
escrever
$$\exists x\in D: P(x),$$
é logicamente equivalente à disjunção
$$P(a_1)\vee P(a_2)\vee\ldots\vee P(a_n),$$
o que mostra que tal fórmula não tem variáveis livres, sendo, portanto, uma proposição. O mesmo significado pode ser dado no caso em que $D$ é um conjunto infinito, envolvendo neste caso infinitas disjunções.
#### Exemplo
Assim, as fórmulas abaixo são proposições
1.  $\exists x(x^2=4)$ é verdade em $\mathbb{R}$;
+ $\exists x\in \mathbb{R}\exists y\in \mathbb{R}:x^2+y^2=0$ é verdadeira;
+ $\exists n\in \mathbb{N}:2n+1>0$ é verdadeira;
+ $\exists y\forall x(|x|+|y|>0)$, é verdadeira em $\mathbb{R}$;
+ $\exists x\in \mathbb{R}:x^2=-4$ é falsa.

#### Exemplo
Note-se que a proposição:
$\exists x\in \{2,6,11,34\}:\;x\;$é ímpar,
é uma proposição verdadeira e equivalente a escrever:
(2 é ímpar)$\vee$(6 é ímpar)$\vee$(11 é ímpar)$\vee$(34 é ímpar).


## O universo vazio
Por uma questão de generalidade interessa considerar também o caso em que o domínio da variável da fórmula proposicional $P(x)$ é o conjunto vazio. Que valor lógico terão expressões da forma
$$\forall x\;[x\in \emptyset\rightarrow P(x)]\text{ e } \exists x\;[x\in \emptyset\wedge P(x)]?$$
Na primeira expressão a implicação é sempre verdadeira quando o antecedente é falso: é o que acontece aqui. Visto que $x\in \emptyset$ é sempre falso, então
$$\forall x\;[x\in \emptyset\rightarrow P(x)]$$
é uma proposição sempre verdadeira. Quando à segunda expressão ela tem a forma de uma conjunção de proposições, das quais uma é sempre falsa. Então,
$$\exists x\;[x\in \emptyset\wedge P(x)]$$
é uma proposição sempre falsa.

#### Exemplo
Note-se que assim a proposição
$$\exists x\in \{\}:\;x\;\text{é ímpar},$$
é uma proposição falsa, e 
$$\forall x\in \{\}:\;x\;\text{é ímpar},$$
é uma proposição verdadeira.






### Existe um e um só $\ldots$
Por vezes emprega-se o quantificador existencial numa situação simultânea de unicidade e existência, ou seja, quer afirmar se não só que
$$\exists x\; P(x)$$
mas ainda que a fórmula $P(x)$ se transforma numa proposição verdadeira para um e só para um elemento do domínio de quantificação, i.e. $\sharp\{x\in U:P(x)\}=1$. Neste caso empregam-se as abreviaturas
$$\exists! x\; P(x) \text{ ou }\exists^1 x\; P(x)$$
que significa


''\textbf{existe um e um só} $x$ tal que $P(x)$''.

#### Exemplo:
Assim
1. $\exists^1x\in \mathbb{N}:x^2=4$ é uma proposição verdadeira;
+ $\exists^1x\in \mathbb{Z}:x^2=4$ é uma proposição falsa;

#### Exemplo:
Assim a proposição
$$\exists^1 x\in \{1,2,3,4,5\}:\;x\;\text{é ímpar},$$
é uma proposição falsa, e
$$\exists^1 x\in \{2,3,4\}:\;x\;\text{é ímpar},$$
é uma proposição verdadeira.

### Variáveis ligadas
Observe-se que enquanto a fórmula $P(x)$ tem uma variável livre, $x$, as fórmulas $\forall x\; P(x)$ e $\exists x\; P(x)$ não têm qualquer variável livre: nestas fórmulas $x$ é sempre uma *variável ligada* (ou *muda*). Trata-se então de proposições, relativamente às quais se pode afirmar que são verdadeiras ou falsas (mas não ambas as coisas).

#### Exemplo:
Seja $\mathbb{N}=\{1,2,3,4,\ldots\}$, $P(x)$ a afirmação ''$x$ é par'', $Q(x)$ a afirmação ''$x$ é divisível por 3'' e $R(x)$ a afirmação ''$x$ é divisível por 4''. Expressar em linguagem corrente cada uma das proposições que se seguem e determinar o seu valor lógico.
1. $\forall x\in \mathbb{N}:P(x)$
+ $\forall x\in \mathbb{N}:P(x)\vee Q(x)$
+ $\forall x\in \mathbb{N}:P(x)\rightarrow Q(x)$
+ $\forall x\in \mathbb{N}:P(x)\vee R(x)$

#### Exemplo:
Indicar se as proposições são sempre, às vezes ou nunca verdadeiras.
1. $(\forall x\in D:P(x))\Rightarrow (\exists x\in D:P(x))$
+ $(\exists x\in D:P(x))\Rightarrow (\forall x\in D:P(x))$
+ $(\forall x\in D:\neg P(x))\Rightarrow \neg(\forall x\in D:P(x))$

### Quantificadores múltiplos

Uma fórmula matemática pode ter mais de que uma variável. Considere-se, por exemplo, a afirmação:

''para cada número inteiro par $n$ existe um número inteiro $k$ para o qual se verifica a igualdade $n=2k$''

Denotando por $P(n,k)$ a fórmula $n=2k$ e por $\mathbb{P}$ o conjunto dos números inteiros pares, a afirmação pode ser assim apresentada simbolicamente por
$$\forall n\in \mathbb{P}\exists k\in \mathbb{Z}:P(n,k)$$
ou
$$\forall n[n\in \mathbb{P}\rightarrow \exists k[k\in \mathbb{Z}\wedge P(n,k)]]$$
que constitui uma proposição verdadeira. Outro exemplo de uma proposição com dois quantificadores é
$$\forall x \exists y\; x+y=0$$
onde o domínio de quantificação é o conjunto dos números reais. Em linguagem corrente, escrever-se-ia

''para todo o número real $x$ existe um número real $y$ tal que $x+y=0$''

que constitui uma proposição verdadeira (sendo $y=-x$ para cada $x\in\mathbb{R}$). Se trocarmos os quantificadores obter-se-á
$$\exists y \forall x \; x+y=0$$
que significa:

''existe um número real $y$ tal que para todo o número real $x$ se tem $x+y=0$''

Esta proposição é falsa pois não existe número real $y$, sempre o mesmo, para o qual todo o número real $x$ satisfaz a equação dada.

Estes exemplos ilustram a *não comutatividade* dos quantificadores universal, $\forall$, e existencial, $\exists$.

É importante notar que a *ordem* dos quantificadores é
relevante:


 Proposição | É verdadeira se: | É falsa se: 
 -----------|------------------|-------------
$\forall x\forall yP(x,y)$ | $P(x,y)$ é verdadeira para  todo o par $x,y$.| Existe um par $x,y$ para o qual $P(x,y)$ é falso. 
$\forall x\exists yP(x,y)$ | Para todo $x$ existe um $y$ para o qual $P(x,y)$ é verdadeira. | Existe um $x$ tal que $P(x,y)$ é falso para todo $y$.
$\exists x\forall yP(x,y)$ | Existe um $x$ para o qual $P(x,y)$ é verdadeira para todo $y$.| Para todo $x$ existe um $y$ tal que $P(x,y)$ é falso.
$\exists x\exists yP(x,y)$ | Existe um par $x,y$ para o qual $P(x,y)$ | $P(x,y)$ é falso para todo o par $x,y$.

Mais geralmente, uma fórmula pode ter $n$ variáveis
$$P(x_1,x_2,\ldots,x_n).$$
Para transformar uma fórmula deste tipo numa proposição são necessários $n$ quantificadores. Denotando um quantificador genérico (universal ou existencial) por $Q$, então
$$Qx_1Qx_2\ldots Qx_nP(x_1,x_2,\ldots,x_n)$$
é uma proposição. **Dois quantificadores da mesma espécie são sempre comutativos enquanto que dois quantificadores de espécies diferentes são geralmente não comutativos.**

#### Exercício
Seja $Q(x,y,z)$ a expressão "$x+y=z$". Determine o valor de verdade
das proposições no conjunto dos números inteiros:
1. $\forall x\forall y \exists zQ(x,y,z)$
+ $\exists z\forall x\forall yQ(x,y,z)$


### Negação de proposições Quantificadas (Segundas Leis de De Morgan)
Resumindo:

Proposição | Quando é verdadeira? | Quando é falsa?
------------|-------------  -------|-----------------
$\forall xP(x)$ | $P(x)$ é verdadeiro para todo o $x$ | Existe um $x$ para o qual $P(x)$ é falso 
$\exists xP(x)$ | Existe um $x$ para o qual $P(x)$ é verdadeiro | $P(x)$ é falso para todo o $x$ 

Dadas as proposições com quantificadores
$$\forall x[x\in U\rightarrow P(x)]\text{ e } \exists x [x\in U\wedge P(x)]$$
pode ser necessário analisar (logicamente) as proposições
$$\neg(\forall x[x\in U\rightarrow P(x)])\text{ e } \neg(\exists x [x\in U\wedge P(x)])$$
Tendo em conta que $p\rightarrow \neg q$ é equivalente a $\neg(p\wedge q)$, então
$$\neg(\exists x [x\in U\wedge P(x)])\Leftrightarrow \forall x\;\neg[x\in U\wedge P(x)]\Leftrightarrow \forall x\; [x\in U\Rightarrow \neg P(x)]$$
De modo semelhante, pode verificar-se que
$$\neg(\forall x[x\in U\rightarrow P(x)])$$
equivale a
$$\exists x \neg[x\in U\rightarrow P(x)]\Leftrightarrow \exists x [x\in U\wedge \neg P(x)]$$
Em resumo, de um modo genérico, têm-se as equivalências
$$\neg(\forall x\; P(x))\Leftrightarrow \exists x\; \neg P(x)$$
$$\neg(\exists x\; P(x))\Leftrightarrow \forall x\; \neg P(x)$$
conhecidas por **Segundas Leis De Morgan**.

#### Exemplo:
Usando estas propriedades temos por exemplo:
1. $\neg\neg \forall x P(x)\Leftrightarrow \neg \exists x (\neg P(x))\Leftrightarrow \forall x (\neg\neg P(x)) \Leftrightarrow \forall x P(x)$;
+ $\neg\neg \exists x P(x)\Leftrightarrow \neg \forall x (\neg P(x))\Leftrightarrow \exists x (\neg\neg P(x)) \Leftrightarrow \exists x P(x)$;
+ $\neg\forall x\forall y P(x,y)\Leftrightarrow \exists x\neg\forall y P(x,y)\Leftrightarrow \exists x\exists y (\neg P(x,y))$;
+ $\neg\exists x\forall y P(x,y)\Leftrightarrow \forall x\neg\forall y P(x,y)\Leftrightarrow \forall x\exists y (\neg P(x,y))$.




```python

```
