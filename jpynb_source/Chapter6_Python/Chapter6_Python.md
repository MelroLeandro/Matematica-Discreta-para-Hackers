
Chapter 6: Python
=================

This chapter introduces more



\section{Fecho}
Dada uma relação binária $R$ definida em $A$ definimos:
  \begin{enumerate}
  \item O \textbf{fecho transitivo} da relação $R$ é a relação $R^+$ de $A$ dada por:
  \begin{enumerate}
    \item se $aRb$ então $aR^+b$,
    \item se $aR^+b$ e $bR^+c$ então $aR^+c$.
  \end{enumerate}
  \item O \textbf{fecho reflexivo} da relação $R$ é a relação $R^-$ de $A$ dada por:
  \[
  R^-=R\cup \{(a,a)|a \in A\}.
  \]
  \item O \textbf{fecho transitivo e reflexivo} da relação $R$ é a relação $R^*$ de $A$ dada por:
  \[
  R^*=R^+\cup R^-.
  \]
 \end{enumerate}
\begin{exam}Exemplificação do fecho transitivo duma relação $R=\{(1,2),(2,3),(3,4)\}$ em $A=\{1,2,3,4\}$
\begin{center}
\includegraphics[width=150pt]{fechoTrans}
\end{center}
\end{exam}
\begin{prop}
Uma relação binária $R$ é transitiva se e só se $R=R^+$ i.e. $R$ for igual ao seu fecho transitivo.
\end{prop}

\begin{exer}
Classifique em $\mathbb{Z}$ as relações binárias definidas por:
\begin{enumerate}
  \item $a \leq b$
  \item $a < b$
  \item $a = b$
  \item $a+b=1$
  \item $ab>0$
  \item $ab\geq0$
\end{enumerate}
\end{exer}

\section{Python: Cláusulas if} 

O mecanismo que mais temos usado para controlo de fluxo da execução são cláusulas \textit{if}. Por exemplo:
\begin{verbatim}
>>> x = int(input("Escreva um inteiro: "))
Escreva um inteiro: 42
>>> if x < 0:
...      x = 0
...      print('Negative changed to zero')
... elif x == 0:
...      print('Zero')
... elif x == 1:
...      print('Single')
... else:
...      print('More')
...
\end{verbatim}

Entedemos neste Capítulo designmos a condição ou cláusula \textit{x<0} por um predicado. 
Já vimos que podem existir um ou mais blocos \textit{elif}, e o bloco else é opcional. O comando \textit{elif} é uma abreviação para ``\textit{else if}'', sendo útil para reduzir a quantidade de indentações. Uma sequência i\textit{f ... elif ... elif ...} é o substituto para os comandos \textit{switch} ou \textit{case} disponíveis noutras linguagens de programação.

\section{Python: Comando for}

Como vimos no Python o comando \textit{for} permite iterar sobre objectos de qualquer sequência (uma lista ou uma string) ou um conjunto, nas sequências o ciclo \textit{for} segue a ordem pela qual os objectos aparecem na sequência. Por examplo:

\begin{verbatim}
>>> # Measure some strings:
... words = ['cat', 'window', 'defenestrate']
>>> for w in words:
...     print(w, len(w))
...
cat 3
window 6
defenestrate 12
\end{verbatim}

Caso tenha de modificar a sequência durante o ciclo \textit{for} (por exemplo para duplicar elementos seleccionados), é conveniente fazer primeiro uma cópia. A noção de slice torna isso possível:

\begin{verbatim}
>>> for w in words[:]:  # Loop over a slice copy of the entire list.
...     if len(w) > 6:
...         words.insert(0, w)
...
>>> words
['defenestrate', 'cat', 'window', 'defenestrate']
\end{verbatim}


\section{Python: A função range()}

Quando temos de iterar numa sequência de números, a função built-in  \textit{range}() trata do assunto. Permitindo gerar progressões aritméticas:

\begin{verbatim}
>>> L=range(10)
>>> for i in L: print(i,' ',end='')
0 1 2 3 4 5 6 7 8 9
\end{verbatim}

O ponto final nunca é parte da lista gerada; range(10) gera uma sequência de 10 valores, os índices de uma lista com 10 objectos. É possível fazer o domínio ter inicio noutro número, ou indicar um incremento diferente (mesmo negativo; este incremento é usualmente designado de 'passo'):

\begin{verbatim}
>>> for i in range(5, 10): print(i,' ',end='')
5 6 7 8 9
>>> for i in range(0, 10, 3): print(i,' ',end='')
0 3 6 9
>>> for i in range(-10, -100, -30): print(i,' ',end='')
-10 -40 -70
\end{verbatim}

Para iterar nos índices de uma sequência, pode combinar \textit{range}() com a função \textit{len}() como por exemplo:

\begin{verbatim}
>>> a = ['Mary', 'had', 'a', 'little', 'lamb']
>>> for i in range(len(a)):
...     print( i, a[i])
...
0 Mary
1 had
2 a
3 little
4 lamb
\end{verbatim}

Na maioria dos casos, é conveniente usar a função \textit{enumerate}().

\section{Python:Comando break e continue, e cláusulas else nos ciclos}

O comando \textit{break}, permite encurtar os ciclos \textit{for} ou \textit{while}.

Os ciclos podem ter uma cláusula \textit{else}; que é executado após ter percorrido todo o domínio do ciclo \textit{for} ou quando a condição dum ciclo  \textit{while} se torna falsa, mas nunca quando o ciclo é interrompido com um comando \textit{break}. Exemplificamos isto no ciclo seguinte, que tem por objectivo determinar números primos:

\begin{verbatim}
>>> for n in range(2, 10):
...     for x in range(2, n):
...         if n % x == 0:
...             print(n, 'equals', x, '*', n/x)
...             break
...     else:
...         # loop fell through without finding a factor
...         print(n, 'is a prime number')
...
2 is a prime number
3 is a prime number
4 equals 2 * 2
5 is a prime number
6 equals 2 * 3
7 is a prime number
8 equals 2 * 4
9 equals 3 * 3
\end{verbatim}

O comando \textit{continue} pára a iteração corrente, saltando para a iteração seguinte do \textit{loop}:

\begin{verbatim}
>>> for num in range(2, 10):
...     if num % 2 == 0:
...         print("Found an even number", num)
...         continue
...     print("Found a number", num)
Found an even number 2
Found a number 3
Found an even number 4
Found a number 5
Found an even number 6
Found a number 7
Found an even number 8
Found a number 9
\end{verbatim}

\section{ Python: Mais de funções}

Recorde que podemos criar uma função que descreva a série de Fibonacci com um limite variável:

\begin{verbatim}
>>> def fib(n):    # write Fibonacci series up to n
...     """Print a Fibonacci series up to n."""
...     a, b = 0, 1
...     while a < n:
...         print(a,' ',end='')
...         a, b = b, a+b
...
>>> # Now call the function we just defined:
... fib(2000)
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597
\end{verbatim}

A palavra reservada \textit{def} permite iniciar a descrição de uma função. Deve ser seguida do nome da função e da lista de parâmetros. O bloco que forma o corpo da função começa na linha seguinte, devendo estar identado.

A primeira instrução no corpo da função pode ser uma linha de documentação ou \textit{docstring}. Existem ferramentas que usam as \textit{docstrings} para produzir documentação; é uma boa prática introduzir \textit{docstrings} no código que escreve, faça disso um hábito.

A execução de uma função cria uma nova tabela de símbolos usada para as variáveis locais da função. Mais precisamente, sempre que são atribuídos valores a variáveis na função, estes são armazenados na tabela de símbolos locais à função. Sempre que se usa uma variável o seu valor é primeiro procurado na tabelas de símbolos locais da função, depois nas tabelas de símbolos nas funções que a possam envolver, depois na tabela de símbolos globais, e por último na tabela de símbolos pré-definidos. Desta forma, as variáveis globais podem ser directamente acedidas de qualquer função mas o seu valor não pode ser alterado. 

\begin{verbatim}
>>> def g():
	def f():
		n=11
		return n+1
	print(n,f(),' ',end='')

	
>>> n=1
>>> g()
1 12
>>> n
1
\end{verbatim}

Os parâmetros (argumentos) de chamada a uma função são introduzidas na tabela de símbolos locais da função quando é executada; sendo os argumentos passados como referência a um objecto. Quando uma função chama outra, uma nova tabela de símbolos é criada para essa chamada.

A definição duma função introduz o nome da função na tabela de símbolos corrente. O objecto referenciado, tem um tipo que é reconhecido pelo interpretados como função definida pelo utilizador. Sendo possível usar essa referência para outros nomes que chamam a mesma função. Servindo isto como um mecanismo genérico de renomeação:
\begin{verbatim}
>>> fib
<function fib at 10042ed0>
>>> f = fib
>>> f(100)
0 1 1 2 3 5 8 13 21 34 55 89
\end{verbatim}

Já que fib não devolve um valor, podemos argumentar que se deva chamar um procedimento. Na verdade, toda a função mesmo sem o comando return devolve um valor. As funções sem comando return devolvem um \textit{None} (um nome pré-definido). Esta devolução é normalmente suprimida pelo interpretador, caso seja o único valor a escrever. Podendo no entanto ser visto usando um \textit{print}:

\begin{verbatim}
>>> fib(0)
>>> print fib(0)
None
\end{verbatim}

É tarefa simples escrever uma função que devolva uma lista de números da sucessão de Fibonacci, em vez de os imprimir:

\begin{verbatim}
>>> def fib2(n): # return Fibonacci series up to n
...     """Return a list containing the Fibonacci series up to n."""
...     result = []
...     a, b = 0, 1
...     while a < n:
...         result.append(a)    # see below
...         a, b = b, a+b
...     return result
...
>>> f100 = fib2(100)    # call it
>>> f100                # write the result
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
\end{verbatim}

    Recorde que a instrução \textit{return} devolve o valor de uma função.
    O comando \textit{result.append}(a) chama um método associado a objectos de tipo lista. Um método é uma função que ``pertencente'' a um objecto, assumindo um nome de formato obj.methodname, onde obj é um objecto (podendo ser uma expressão), e methodname é o nome de um dos métodos associados aos objectos desse tipo. Diferentes objectos têm associado diferentes métodos. Métodos de diferentes tipos podem ter o mesmo nome sem provocar ambiguidades. O  método \textit{append}() do exemplo está definido para os objectos de tipo lista; permitindo adicionar um novo elemento no final da lista. Sendo equivalente a fazer  result = result + [a], mas mais eficiente.

É possível definir funções com um número variável de argumentos. Existindo três mecanismos que podem ser combinados.

\subsection{Argumentos com valores por defeito}

Muito útil é a definição de valores por defeito. Permitindo criar uma função que pode ser chamada com menos argumentos que os usados na definição da função. Por exemplo:
\begin{verbatim}
def ask_ok(prompt, retries=4, complaint='Yes or no, please!'):
    while True:
        ok = raw_input(prompt)
        if ok in ('y', 'ye', 'yes'):
            return True
        if ok in ('n', 'no', 'nop', 'nope'):
            return False
        retries = retries - 1
        if retries < 0:
            raise IOError('refusenik user')
        print complaint
\end{verbatim}

Esta função pode ser chamada de diferentes formas:
\begin{enumerate}
\item dando apenas os argumentos obrigatórios: ask\_ok('Do you really want to quit?')
\item dando um argumento opcional: ask\_ok('OK to overwrite the file?', 2)
\item ou dando todos os argumentos: ask\_ok('OK to overwrite the file?', 2, 'Come on, only yes or no!')
\end{enumerate}
Os valores por defeito são usados no ponto onde a função é definida, por exemplo 

\begin{verbatim}
i = 5

def f(arg=i):
    print(arg)

i = 6
f()
\end{verbatim}
imprime 5

Aviso importante: O valor por defeito é avaliado uma única vez. Com ressalva quando o valor por defeito é um objecto mutável, tal como uma lista, um conjunto ou um dicionário. Por exemplo, a função abaixo acumula os argumentos que lhe são passados, em chamadas seguintes.  
Por exemplo, a função seguinte acumula os argumentos passando-os às chamadas posteriores:

\begin{verbatim}
def f(a, L=[]):
    L.append(a)
    return L

print f(1)
print f(2)
print f(3)
\end{verbatim}

Imprimindo:

\begin{verbatim}
[1]
[1, 2]
[1, 2, 3]
\end{verbatim}

Caso não pretenda que o valor por defeito seja partilhado entre chamadas seguintes, deve reescrever a chamada como se apresenta abaixo:

\begin{verbatim}
def f(a, L=None):
    if L is None:
        L = []
    L.append(a)
    return L
\end{verbatim}

\section{Python: Listas}

Os métodos mais usados do objecto list são:

\begin{enumerate}

\item \textit{list.append}(x) - Acrescenta um elemento ao final duma lista: equivalente a \textit{lista[len(lista):] = [x]}.

\item \textit{list.extend}(L) - Estende a lista com todos os elementos da lista usada como argumento; equivalente a \textit{lista[len(lista):] = L}.

\item \textit{list.insert}(i, x) - Insere um elemento numa dada posição. O primeiro argumento é o índice anterior ao da inserção, assim  \textit{lista.insert}(0, x) insere no inicio da lista, e \textit{lista.insert(len(lista), x)} é equivalente \textit{a.append(x)}.

\item \textit{list.remove}(x) - remove o primeiro elemento da lista igual a x. Devolve um erro se tal elemento não existe.

\item \textit{list.pop}([i]) - remove o elemento numa dada posição da lista, e  devolve-o. Caso nenhum índice for dado, remove e devolve o último elemento da lista. (Os parêntesis rectos que rodeiam o \textit{i} no método indicam que o parâmetro é opcional, o índice que usa por argumento não pode usá-los)

\item \textit{list.index}(x) - devolve o índice da primeira ocorrência de \textit{x} na lista. Devolve um erro caso não exista.

\item \textit{list.count}(x) - devolve o número de vezes em que \textit{x} ocorre na lista.

\item \textit{list.sor}t() - ordena os elementos da lista.

\item \textit{list.reverse}() - reverte a ordenação dos elementos.

\end{enumerate}
