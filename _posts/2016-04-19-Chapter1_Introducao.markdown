---
layout: post
title: "Capítulo 1 Introdução"
subtitle: "Matemática Discreta para Hackers"
author:  Mellean
tags:   python string variável identação operadores if while for break  
category:  python matemática-discreta
visualworkflow: false
---
<!-- Start Writing Below in Markdown -->

Capítulo 1:  Introdução
======
***

Python
------


Em todos estes Capítulos encorajamos a que os exemplos apresentados sejam alterados e executados no Jupyter e se possivel reescritos directamente no interpretador ou ambiente de desenvolvimento. Neste ponto assumimos que tem o ambiente Jupyter a funcionar no seu computador.   

#### Fundamentos

O espaço abaixo é usual designar no Jupyter célula de execução:


```python

```

Neste caso a célula está vazia. Com isto quer dizer que não tem código ou programa para ser executado. Para executar uma célula basta que esta esteja selecionada e seja teclado simultaniamente Shift+Return.

Podemos começar por usar uma célula para fazer um pouco de aritmética.


```python
2+2
```




    4



Resumino: o resultado de avaliar 2+2 é 4. Fantástico. Exprimente alteras o operador usando para isso a sintaxe descrita abaixo.

Operador |  Operação | Examplemplo | Valor ...
---------|-----------|-------------|-----------
**       | potência  | 2 ** 3      | 8
%        | resto da divisão inteira | 22 % 8 |6
//       | quociente da divisão inteira | 22 // 8 | 2
/       | divisão |  22 / 8 | 2.75
*  | multiplicação |  3 * 5 |15
-  | Subtraction |  5 - 2 | 3
+  | Addition  | 2 + 2 | 4

A ordem das operações (também designada de precedência) dos operadores aritméticos do Pythone é similar à que é usada na matemática. O operador ** é avaliado primeiro; os operadores  *, /, //, e % são avaliados a seguir, da esquerda para a direita; por último é avaliado + e - (também da esquerda para a direita). Naturalmente que podemos usar parenteses para superimpor a ordem de avaliação que desejar.



```python
(5 - 1) * ((7 + 1) / (3 - 1))
```




    16



Na tentativa de avaliar uma expressão, como a anterir, o Python, guiado pela ordem de precedencia imposta pelos operadores ou pela parentização, avalia progrecivamente subfórmulas até opter um valor único.

![Image](../../../../../images/000056.png)

As regras usadas para formar expressões que podem ser avaliadas ( ou que o interpretador de Python perceba) são parte fundamental do Python como linguagem de programação. Estas regras podem ser entendidas como identicas às regras gramaticais que nos ajudam a comunicar.

Sempre que pedimos ao Python para executar uma instrução desconhecida, ou cuja descição é incorrecta ou que o Python não consegue preceber, é emitida uma mensagem identificando um erro de sintaxe:


```python
5+
```


      File "<ipython-input-3-bc8c986ea5b3>", line 1
        5+
          ^
    SyntaxError: invalid syntax




```python
42 + 5 + * 2
```




    -8



Acima são apresentados dois exemplos de expressões que não respeitam as regras gramaticais da linguagem de programação.

[Continuação](https://github.com/MelroLeandro/Matematica-Discreta-para-Hackers/jpynb_source/Chapter2_Calculo_Proposicional/Chapter2_Calculo_Proposicional.ipynb)
