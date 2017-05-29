---
layout: post
title: "Capítulo 8 Estruturas Algébricas"
subtitle: "Matemática Discreta para Hackers"
author:  Mellean
tags:   python semi-grupo elemento-neutro monóide alfabeto palavra concatenação linguage união expressão-regular linguagem regular gramática
category:  python
visualworkflow: false
---

<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Capítulo 8:  Estruturas Algébricas
=====

## Semi-grupos

Quer a adição quer a multiplicação em $\mathbb{N}$, são operações que a cada par de números fazem corresponder um número natural. Diz-se, por tal facto, que a adição e a multiplicação são operações internas ou leis de composição interna em $$\mathbb{N}$$.

### Lei de composição interna

A operação $\oplus$ é uma lei de composição interna ou operador binário no conjunto $A$, se e só se faz corresponder a cada par ordenado $(a,b)$ em $A\times A$, um único elemento pertencente a $A$,
$$
\oplus:A\times A \rightarrow A
$$

Assim, não estamos em presença de uma operação interna sempre que para dois elementos dados, o resultado da operação não pertença ao mesmo conjunto.

### Definição:
Se $\oplus$ é uma operação interna em $A$, diz-se que $A$ é fechado relativamente a $A$.

São as leis de composição interna que conferem aos conjuntos o que habitualmente chamamos de estruturas. Assim podemos desde já definir a mais simples das estruturas, o grupóide.

### Definição:
Um conjunto $A$ diz-se um **grupóide** relativamente à operação $\oplus$, ou que a estrutura $(A,\oplus)$ define um grupóide, se e só se $\oplus$ é uma lei de composição interna em $A$.

### Exemplos:
$$
(\mathbb{Z},+), (\mathbb{Z},-),\text{ e }(\mathbb{R},\times)
$$
são exemplos de grupóides. $(\mathbb{Z},+)$ é grupóide porque a adição está definida para números inteiros e a soma de dois inteiros é um inteiro. De forma idêntica,  $(\mathbb{Z},-)$ é um grupóide já que a diferença está definida para todo o par de inteiros, e o resultado é um único inteiro. $(\mathbb{R},\times)$ é um grupóide porque o produto está definido para todo o par de reais e o resultado é um real.

### Exercícios:
Justifique que são grupóides:

1. $$(\mathbb{N},+)$$
1. $$(\mathbb{R},\times)$$
1. $$(P(A),\cap)$$, em que $$P(A)$$ é o conjunto das partes de $A$.


### Exercícios:

Justifique que não são grupóides:
1. $(\mathbb{N},-)$
1. $(\mathbb{R},:)$, onde $:$ é a operação de divisão de reais
1. $(B,\oplus)$, em que $B=\{0,1\}$ e a operação $\oplus$ está definida pela tabela

$\oplus$ | 0 | 1
---------|---|---
**0** | 0 | 1
**1** | 1 | 2



[Continuação](https://github.com/MelroLeandro/Matematica-Discreta-para-Hackers/blob/master/jpynb_source/Chapter6_Python/Chapter6_Python.ipynb)
