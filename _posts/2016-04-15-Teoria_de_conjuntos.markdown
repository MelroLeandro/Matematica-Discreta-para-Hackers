---
layout: post
title: "Capítulo 5: Teoria de Conjuntos"
subtitle: "Matemática Discreta para Hackers"
author:  Mellean
tags:   python
category:  python
visualworkflow: false
---

<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Capítulo 5: Teoria de Conjuntos
======

 A Teoria de Conjuntos é a teoria matemática que se ocupa dum universo $U$ de
indivíduos a que chamamos conjuntos. Diz-se que os objecto $a$ e $A$
existem e são conjuntos, se pertencem ao domínio $U$. Vamos supor que se
verificam  certas relações fundamentais, da forma $a\in A$, entre
objectos $a$ e $A$ do domínio $U$. Se para dois objectos $a$ e $A$ vale a
relação $a\in A$, diremos que ''$a$ é um elemento de $A$'' ou que ''$A$ contém
$a$ como elemento''. Um conjunto designa-se geralmente por uma letra maiúscula, reservando-se as letras minúsculas para os seus elementos. A negação de $x\in A$ representa-se simbolicamente por $x\not \in A$.

### Descrição
Um conjunto pode ser descrito em **extensão** (quando o número dos seus elementos for finito e suficientemente pequeno) enumerando explicitamente todos os seus elementos e colocados entre chavetas e separados por vírgulas ou em **compreensão**, enunciando uma propriedade caracterizadora dos seus elementos (isto é, uma propriedade que os seus e só os seus elementos possuem).

#### Exemplo:
Conjunto das vogais $V$ é descrito em extensão $$V=\{a,e,i,o,u\}$$;


#### Exemplo:
Conjunto $L$ das palavras da lingua portuguesa escritas com 5 letras vogais, está descrito em compreensão;


#### Exemplo:
Conjunto dos números naturais pares pode ser descrito, em compreensão, como sendo definido por naturais $n$ para os quais existe um natural $q$ tal que $n=2q$.

#### Exemplo:
$$1\in \{1,2,3\},\;\; 2 \in \{4,2,5\},\;\;7\not\in\{1,2,3\},\;\;\{1\}\not\in \{1,2,3\}$$

#### Exemplo:
$$1\in\{n:\; n \text{ é um natural ímpar}\}\;\;2\not\in\{n:\; n \text{ é um natural ímpar}\}$$

### Axioma da extensão
Dois conjuntos $A$ e $B$ são iguais se e só se têm os mesmos
elementos. Neste caso escrevemos, $A=B$.

Simbolicamente temos $$A=B\Leftrightarrow \forall x(x\in A \leftrightarrow x\in B)$$
Dada uma expressão proposicional $P(x)$ (um predicado colectivizante), há um só conjunto
que tem por elementos os $x$ que satisfazem $P(x)$, tal conjunto
será denotado por $$\{x:P(x)\}.$$

#### Exemplo:
1. $$\{1,2,3,4,5\} = \{5,4,1,2,3\}$ e $\{5,5,5,5\}=\{5\}$$ porque os conjuntos envolvidos têm os mesmos elementos.
1. $$\{1,2,3,4,5\} \neq \{5,4,2,3\}$ e $\{5,5,5,5\}\neq\{5,6\}$$ porque os conjuntos envolvidos são definidos por elementos diferentes.


[Continuação](https://github.com/MelroLeandro/Matematica-Discreta-para-Hackers/blob/master/jpynb_source/Chapter5_Teoria_de_conjuntos/Teoria_de_conjuntos.ipynb)
