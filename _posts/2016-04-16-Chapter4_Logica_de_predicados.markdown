---
layout: post
title: "Capítulo 4 Lógica de Predicados"
subtitle: "Matemática Discreta para Hackers"
author:  Mellean
tags:   python
category:  python
visualworkflow: false
---

<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

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

[Continuação](https://github.com/MelroLeandro/Matematica-Discreta-para-Hackers/blob/master/jpynb_source/Chapter4_Logica_de_predicados/Chapter4_Logica_de_predicados.ipynb)
