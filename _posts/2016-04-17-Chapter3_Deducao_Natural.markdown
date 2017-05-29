---
layout: post
title: "Capítulo 3 Deducão Natural"
subtitle: "Matemática Discreta para Hackers"
author:  Mellean
tags:   python argumento demonstração inferência
category:  python
visualworkflow: false
---

<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Capítulo 3: Deducão Natural
======

This chapter introduces more

### Fórmulas bem formadas

Estamos a descrever um sistema formal, denominado de cálculo proposicional clássico, que formaliza a chamada lógica clássica, ou lógica proposicional clássica. O vocabulário desse sistema tem os seguintes símbolos primitivos:

1. uma colecção de símbolos, $A,B,C,\ldots$ ou $P_1,P_2,\ldots$ ou $p,q,r,\ldots$, chamados de símbolos proposicionais,
1. símbolos lógicos $\neg,\wedge,\vee,\rightarrow,\leftrightarrow,\oplus$, e
1. símbolos de pontuação $($ e $)$.

As expressões da linguagem do cálculo proposicional são sequências finitas destes símbolos (\emph{strings}), como $\neg)\vee A))(\vee B$. Convém distinguir entre as expressões ou fórmulas bem formadas (fbf) das demais. Isso é feito impondo um conjunto de regras gramaticais para a linguagem.


As regras gramaticais, para esta linguagem formal, definem por fbf (expressões gramaticalmente bem formadas na linguagem) unicamente aquelas expressões $\alpha$ obtidas por alguma das seguintes cláusulas:
1. $\alpha$ é igual a um símbolo proposicional $A,B,C,\ldots$ ou $P_1,P_2,\ldots$ ou $p,q,r,\ldots$, ou
1. $\alpha$ é igual a $(\neg \beta)$ ou $(\beta\wedge\gamma)$ ou  $(\beta\vee\gamma)$ ou $(\beta\rightarrow\gamma)$ ou  $(\beta\leftrightarrow\gamma)$ ou $(\beta\oplus\gamma)$, onde onde $\beta$ e $\gamma$,
1. nada mais é uma fbf.
Note que, os parêntesis são usados para evitar ambiguidade. Por exemplo, $(\neg p\vee q)$ deve ser distinguida de $\neg(p \vee q)$. No segundo caso, o operador $\neg$ aplica-se à fórmula $(p\vee q)$, ao passo que no primeiro ele é aplicado apenas a $p$.

Na escrita das fbf do cálculo proposicional adoptámos a convenção de eliminar  parêntesis externos e impondo uma ordem de precedência aos operadores. Num sistema formal é frequente a definição de novos símbolos com base em símbolos lógicos primitivos. Na literatura é frequente usar como únicos símbolos primitivos, para o cálculo proposicional,  $\neg$ e $\vee$, a partir dos quais se pode definir os outros fazendo por exemplo:

1. $p\wedge q =_{def}\neg(\neg p\vee\neg q)$
1. $p\rightarrow q =_{def}\neg p\vee q$
1. $p\leftrightarrow q =_{def}(p\rightarrow q)\wedge (q\rightarrow p)$

Note que neste contexto os novos símbolos $\wedge,\rightarrow,\leftrightarrow$ não fazem parte do vocabulário básico da linguagem.


##### Exercício:
Quais das seguintes expressões são proposições bem formadas?
1. $\neg((A\rightarrow B)\rightarrow \neg(B\rightarrow A)$
1. $(S\wedge (((P\rightarrow Q)\wedge (\neg Q\rightarrow R))\rightarrow (Q\vee \neg Q)))$
1. $((((A\wedge \neg B)\vee (\neg A \wedge B))\leftrightarrow \neg\neg\neg\neg C))$
1. $(((A\rightarrow B)\rightarrow C)\rightarrow \neg ((A\vee B)\leftrightarrow \neg\neg(C\wedge A)))$

[Continuação](https://github.com/MelroLeandro/Matematica-Discreta-para-Hackers/blob/master/jpynb_source/Chapter2_Calculo_Proposicional/Chapter2_Calculo_Proposicional.ipynb)
