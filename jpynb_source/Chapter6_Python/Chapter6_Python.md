
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

Um exemplo:
\begin{verbatim}
>>> a = [66.25, 333, 333, 1, 1234.5]
>>> print a.count(333), a.count(66.25), a.count('x')
2 1 0
>>> a.insert(2, -1)
>>> a.append(333)
>>> a
[66.25, 333, -1, 333, 1, 1234.5, 333]
>>> a.index(333)
1
>>> a.remove(333)
>>> a
[66.25, -1, 333, 1, 1234.5, 333]
>>> a.reverse()
>>> a
[333, 1234.5, 1, 333, -1, 66.25]
>>> a.sort()
>>> a
[-1, 1, 66.25, 333, 333, 1234.5]
\end{verbatim}

\subsection{Uso da lista como uma pilha}

Os métodos apresentados permitem usar uma lista como uma pilha, onde o último elemento a entrar na lista é o primeiro a sair (last-in, first-out). Para adicionar um elemento ao topo da pilha, usa-se \textit{append}().
Para retirar um elemento do topo da pilha, usa-se o \textit{pop}() sem índice explicito. Por exemplo:

\begin{verbatim}
>>> stack = [3, 4, 5]
>>> stack.append(6)
>>> stack.append(7)
>>> stack
[3, 4, 5, 6, 7]
>>> stack.pop()
7
>>> stack
[3, 4, 5, 6]
>>> stack.pop()
6
>>> stack.pop()
5
>>> stack
[3, 4]
\end{verbatim}

\subsection{Python: Usando listas como filas}

Podemos também usar as listas como filas, onde o primeiro elemento a entrar é o primeiro a sair (first-in, first-out); No entanto as listas não são muito eficientes com este propósito. Enquanto os \textit{appends} e \textit{pops} no fim da lista são rápidos, fazer \textit{inserts} ou \textit{pops} no inicio da lista é lento (já que todos os outros elementos têm de ser deslocados uma posição).

Para implementar uma fila, use \textit{collections.deque}, desenvolvida para melhorar a eficiência neste tipo de estrutura. Por exemplo:

\begin{verbatim}
>>> from collections import deque
>>> queue = deque(["Eric", "John", "Michael"])
>>> queue.append("Terry")           # Terry arrives
>>> queue.append("Graham")          # Graham arrives
>>> queue.popleft()                 # The first to arrive now leaves
'Eric'
>>> queue.popleft()                 # The second to arrive now leaves
'John'
>>> queue                           # Remaining queue in order of arrival
deque(['Michael', 'Terry', 'Graham'])
\end{verbatim}

\subsection{Python: Listas em Compreensão}

As listas definidas em compreensão oferecem uma forma concisa de definir uma lista. Uma aplicação é a construção de listas por recorrência, ou através da selecção de elementos numa sucessão definida por recorrência.

Por exemplo, assumindo que pretendemos criar uma lista de números quadrados, por exemplo:
\begin{verbatim}
>>> squares = []
>>> for x in range(10):
...     squares.append(x**2)
...
>>> squares
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
\end{verbatim}

Podemos ter o mesmo resultado com:

\begin{verbatim}
squares = [x**2 for x in range(10)]
\end{verbatim}

Uma lista definida em compreensão consiste numa expressão, seguida por zero ou mais cláusulas, definidas entre parêntesis. O resultado é uma nova lista resultando da avaliação da expressão no domínio do \textit{for} satisfazendo as cláusulas. Por exemplo, a lista do exemplo abaixo combina os elementos de duas listas caso não sejam iguais: 

\begin{verbatim}
>>> [(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
[(1, 3), (1, 4), (2, 3), (2, 1), (2, 4), (3, 1), (3, 4)]
\end{verbatim}
O mesmo resultado pode ser produzido por:

\begin{verbatim}
>>> combs = []
>>> for x in [1,2,3]:
...     for y in [3,1,4]:
...         if x != y:
...             combs.append((x, y))
...
>>> combs
[(1, 3), (1, 4), (2, 3), (2, 1), (2, 4), (3, 1), (3, 4)]
\end{verbatim}

Note que a ordem dos \textit{for} e \textit{if} na instrução é a mesma nas duas versões.

\begin{verbatim}
>>> vec = [-4, -2, 0, 2, 4]
>>> # create a new list with the values doubled
>>> [x*2 for x in vec]
[-8, -4, 0, 4, 8]
>>> # filter the list to exclude negative numbers
>>> [x for x in vec if x >= 0]
[0, 2, 4]
>>> # apply a function to all the elements
>>> [abs(x) for x in vec]
[4, 2, 0, 2, 4]
>>> # call a method on each element
>>> freshfruit = ['  banana', '  loganberry ', 'passion fruit  ']
>>> [weapon.strip() for weapon in freshfruit]
['banana', 'loganberry', 'passion fruit']
>>> # create a list of 2-tuples like (number, square)
>>> [(x, x**2) for x in range(6)]
[(0, 0), (1, 1), (2, 4), (3, 9), (4, 16), (5, 25)]
>>> # the tuple must be parenthesized, otherwise an error is raised
>>> [x, x**2 for x in range(6)]
  File "<stdin>", line 1
    [x, x**2 for x in range(6)]
               ^
SyntaxError: invalid syntax
>>> # flatten a list using a listcomp with two 'for'
>>> vec = [[1,2,3], [4,5,6], [7,8,9]]
>>> [num for elem in vec for num in elem]
[1, 2, 3, 4, 5, 6, 7, 8, 9]
\end{verbatim}

As listas em compreensão podem conter expressões complexas e chamadas a funções:

\begin{verbatim}
>>> from math import pi
>>> [str(round(pi, i)) for i in range(1, 6)]
['3.1', '3.14', '3.142', '3.1416', '3.14159']
\end{verbatim}

\subsection{Python: Matrizes como listas}

A expressão inicial numa lista em compreensão pode ser qualquer expressão arbitrária, podendo ser mesmo outra lista em compreensão.

Recorde o exemplo de uma matriz de 3x4 descrita por 3 listas de comprimento 4:

\begin{verbatim}
>>> matrix = [
...     [1, 2, 3, 4],
...     [5, 6, 7, 8],
...     [9, 10, 11, 12],
... ]
\end{verbatim}

Pode ser transposta através de:
\begin{verbatim}
>>> [[row[i] for row in matrix] for i in range(4)]
[[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]
\end{verbatim}

Sendo isto equivalente a fazer:

\begin{verbatim}
>>> transposed = []
>>> for i in range(4):
...     transposed.append([row[i] for row in matrix])
...
>>> transposed
[[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]
\end{verbatim}

Que por sua vez é equivalente a:

\begin{verbatim}
>>> transposed = []
>>> for i in range(4):
...     # the following 3 lines implement the nested listcomp
...     transposed_row = []
...     for row in matrix:
...         transposed_row.append(row[i])
...     transposed.append(transposed_row)
...
>>> transposed
[[1, 5, 9], [2, 6, 10], [3, 7, 11], [4, 8, 12]]
\end{verbatim}

\begin{exer}
 Defina uma função $nul(int)->list$ que devolva uma matriz quadrada $A=[a_{ij}]$ de ordem $n$ de elementos todos nulos, isto é $\forall i,j\in\{0,\ldots,n-1\}:a_{i,j}=0$.
 \end{exer}
 \begin{exer}
 Defina uma função $Id(list)->list$ que devolva uma matriz identidade $I=[a_{ij}]$, isto é $\forall i,j\in\{0,\ldots,n-1\}:(i\neq j \rightarrow a_{i,j}=0)$ e $\forall i\in\{0,\ldots,n-1\}: a_{i,i}=1$.
 \end{exer}
 \begin{exer}
 Defina uma função $Lagrange(int)->list$, tal que $Lagrange(n)$ é uma matriz quadrada de ordem $n$ tal que $\forall i,j\in\{0,\ldots,n-1\}:a_{i,j}=i+j+2$.
 \end{exer}

\section{Python: Tuples}

Vimos que as listas e as strings têm muitas propriedades em comum, tais como indexadores e operações de slicing. São exemplos de dados do tipo sequências (são deste tipo \textit{str, unicode, list, tuple, bytearray, buffer, range}). Outra estrutura de dados que pode ser vista como uma sequência são os tuplos. 

Um tuplo consiste numa sequência de valores separados por vírgulas, por exemplo:

\begin{verbatim}
>>> t = 12345, 54321, 'hello!'
>>> t[0]
12345
>>> t
(12345, 54321, 'hello!')
>>> # Tuples may be nested:
... u = t, (1, 2, 3, 4, 5)
>>> u
((12345, 54321, 'hello!'), (1, 2, 3, 4, 5))
>>> # Tuples are immutable:
... t[0] = 88888
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
>>> # but they can contain mutable objects:
... v = ([1, 2, 3], [3, 2, 1])
>>> v
([1, 2, 3], [3, 2, 1])
\end{verbatim}

Dos exemplos, o output dum tuplo está sempre envolto em parênteses;  podendo ser definido com ou sem parênteses, sendo obrigatórios se o tuplo faz parte duma expressão complexa. Não é possível alterar um componente dum tuplo, no entanto é possível criar tuplos que contêm objectos mutáveis, tais como listas.

Apesar dos tuplos serem semelhantes a listas, eles são usados em situações diferentes e com propósitos diferentes. Os tuplos são imutáveis, e normalmente contêm uma sequência heterogenia  de elementos.

Exemplos:

\begin{verbatim}
>>> empty = ()
>>> singleton = 'hello',    # <-- note trailing comma
>>> len(empty)
0
>>> len(singleton)
1
>>> singleton
('hello',)
\end{verbatim}

O comando t = 12345, 54321, 'hello!' é exemplo de um tuplo empacotando: os valores 12345, 54321 and 'hello!' no tuplo. 
\begin{exer}
Defina $Rec(int)->tuple$ uma função que devolve um tuplo dos primeiros $m$ termos da sucessão dada por $a_0=1$,$a_1=2$, e $a_{n+1}=a_n-a_{n-1}$, para $n>1$.
\end{exer}
\begin{exer}
Determine a lista de tuplos $(x,y,z)$, definidos por números naturais menores que 100, tais que $x^2+y^2=z^2$.
\end{exer}
\begin{exer}
 Determine a lista de tuplos $(x,y,z)$, definidos por números inteiros $x,y,z$, maiores que -100 e menores que 100, tais que $$x^2-y^2\leq 1\wedge y^2-z^2\leq 1\wedge x^2-z^2> 1.$$
\end{exer}

\section{Python: Conjuntos}

Um conjunto $A$ de elementos inteiros 2, 3, 4, 5 pode ser definido por:
\begin{verbatim}
>>> A={2,3,4,5}
\end{verbatim}
Ao conjunto $A$ podem ser adicionados mais elementos através do método $add$. Por exemplo
\begin{verbatim}
>>> A.add(7)
\end{verbatim}
adiciona a $A$ o inteiro $7$. Inversamente podem ser removidos elementos a um conjunto através do método $pop$.
\begin{verbatim}
>>> A.pop()
2
\end{verbatim}
 Neste caso, o método seleccionou um elemento de $A$, o inteiro 2, que removeu a $A$. Após esta sequência de comandos tem-se
\begin{verbatim}
>>> A
{3,4,5,7}
>>> len(A)
4
\end{verbatim}
Neste sentido $A$ tem $4$ elementos, $7 \in A$, é uma proposição verdadeira e  $2 \in A$, é uma proposição falsa. Em Python:
\begin{verbatim}
>>> 7 in A
True
>>> 2 in A
False
\end{verbatim}
Note que $R=\{(3,3),(4,5),(7,7)\}$ é uma relação binária em $A$, que não é reflexiva porque $(4,4)\in R$ é falso. Em Python:
\begin{verbatim}
>>> R={(3,3),(4,5),(7,7)}
>>> (4,4) in R
False
\end{verbatim}
O domínio da relação $R$, definido como o conjunto $$dom(R)=\{x\in A:\; \exists y\in A,(x,y)\in R\},$$ pode ser calculado em Python por:
\begin{verbatim}
>>> def dom(R):
        D=set()         # D é o conjunto vazio
        for (x,y) in R:
            D.add(x)      # junta a D um elemento x, a primeira
                            componente do par (x,y) em R
        return D
>>> dom(R)
{3,4,7}
\end{verbatim}
Recorde que $set([])$ representa $\emptyset$ o conjunto vazio.

As expressões $for <var> in <obj>$ podem ser usadas para construir conjuntos ou listas. Por exemplo:
\begin{verbatim}
>>> R={(x,x+1) for x in range(3)}
>>> R
{(0,1),(1,2),(2,3)}
>>> M=[[0 for i in range(3)] for j in range(4)]
>>> M
[[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
\end{verbatim}
Podemos entender no último caso $M$ como uma matriz booleana, onde por $M[i][j]$ identificamos o elemento da linha $i$ e coluna $j$, assumindo para isso que a primeira linha e a primeira coluna têm índice 0. Podemos alterar as entradas da matriz usando estes indices.
\begin{verbatim}
>>> M[1][2]= 1 # altera para 1 a entrada da linha 1 e coluna 2 da matriz M
>>> M[0][1]= 1 # altera para 1 a entrada da linha 0 e coluna 1 da matriz M
>>> M
[[0,1,0],[0,0,1],[0,0,0],[0,0,0]]
\end{verbatim}
Outro exemplo:
\begin{verbatim}
>>> T={x for x in range(100) if x%2==0 and x%3!=0}
>>> T
{2, 4, 8, 10, 14, 16, 20, 22, 26, 28, 32, 34, 38, 40, 44, 46, 50, 52, 56, 
58, 62, 64, 68, 70, 74, 76, 80, 82, 86, 88, 92, 94, 98}
\end{verbatim}
Aqui podemos entender $T$ descrito, em ``linguagem matemática'', em compreensão por $\{x\in range(100): x\%2=0 \wedge x\%3\neq0\}$.

A função \textit{set}() pode ser usada para construir um conjunto. Nota: o conjunto vazio é criado usando \textit{set}() ou \textit{set}([]), e não $\{\}$; o último cria o dicionário vazio (estrutura de dados que se apresenta na sequência).

Um caso de uso:

\begin{verbatim}
>>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
>>> fruit = set(basket)               # create a set without duplicates
>>> fruit
{'orange', 'pear', 'apple', 'banana'}
>>> 'orange' in fruit                 # fast membership testing
True
>>> 'crabgrass' in fruit
False

>>> # Demonstrate set operations on unique letters from two words
...
>>> a = set('abracadabra')
>>> b = set('alacazam')
>>> a                                  # Letrar usadas na string a
{'a', 'r', 'b', 'c', 'd'}
>>> a - b                              # letrar que estão 
                                       # em de a e não em b (diferença)
{'r', 'd', 'b'}
>>> a | b                              # Letrar que estão 
                                       # em a ou em  b (união)
{'a', 'c', 'r', 'd', 'b', 'm', 'z', 'l'}
>>> a & b                              # letrar que estão 
                                       # em a e b (intersecção)
{'a', 'c'}
>>> a ^ b                              # letrar que estão em a ou b
                                       # mas não nas duas (XOR)
{'r', 'd', 'b', 'm', 'z', 'l'}
\end{verbatim}

De forma semelhante à definição de listas em compreensão, podemos definir conjuntos em compreensão:

\begin{verbatim}
>>> a = {x for x in 'abracadabra' if x not in 'abc'}
>>> a
{'r', 'd'}
\end{verbatim}

Dadas relações $R$, de $A$ em $B$, e $S$ uma relação de $B$ em $C$, define-se a $SoR$ (composição de $S$ e $R$) como a relação de $A$ para $C$ dada por:
\begin{verbatim}
def SoR(S,R):
    H=set()
    for (a,b) in R:
         for (d,c) in S:
              if d==b:
                   H.add((a,c))
    return H
\end{verbatim}
ou de forma equivalente:
\begin{verbatim}
{(a,c) for (a,b) in R for (d,c) in S if b==d}
\end{verbatim}
O fecho transitivo assume a forma da função:
\begin{verbatim}
def fecho(R):
    PR=set(R)       # cópia de R
    H=set(R)        # cópia de R
    Hold=set()      # conjunto vazio
    while H!=Hold:
        Hold=set(H)
        PR=SoR(PR,R) # chama a função anterior
        H=Hold | PR  # união de dois conjuntos
    return H
\end{verbatim}
\begin{exer}
   Crie uma função booleana $sim(set,set)-> bool$, usando um ciclo for, que devolve True se o primeiro conjunto está contido no segundo.
\end{exer}
\begin{exer}
   Defina $Prim(int)->set$ uma função que devolve o conjunto dos primeiros $m$ números primos.
\end{exer}
\begin{exer}
   Determine o conjunto dos tuplos $(x,y)$, definidos por números naturais menores que 100, tais que $x^2+y^2<5^2$.
\end{exer}
\begin{exer}
   Determine o conjunto dos tuplos $(x,y,z)$, definidos por números inteiros $x,y,z$, maiores que -100 e menores que 100, tais que $$x^2+y^2\leq 1\wedge y^2+z^2\leq 1\wedge x^2+z^2> 1.$$
\end{exer}
\begin{exer}
   Crie uma função $Val(set,int)-> set$ que quando aplicada a uma relação $R$ definida em $range(n)$, e a um inteiro $x$ devolve o conjunto $\{a:xRa\}$.
\end{exer}
\begin{exer}
   Crie uma função $InVal(set,int)-> set$ que quando aplicada a uma relação $R$ definida em $range(n)$, e a um inteiro $x$, devolve o conjunto $\{a:aRx\}$.
\end{exer}
\begin{exer}
   Crie uma função $InVal(set,set)-> set$ que quando aplicada a uma relação $R$ definida em $range(n)$ e para $A\subseteq range(n)$ devolve o conjunto $\{a:aRx \wedge x\in A\}$.
\end{exer}
\begin{exer}
Implemente funções, que tendo por argumento uma relação binária $R$ num conjunto $A$, devolvem o conjunto indicado:
\begin{enumerate}
  \item $Im(set)-> set$, que para a relação $R$, $Im(R)=\{y:(x,y)\in R\}$
  \item $fim(set)-> set$, que para a relação $R$, $fim(R)=\{z:\exists x,y,(x,y)\in R\wedge (y,z)\in R\}$
  \item $meio(set)-> set$, que para a relação $R$, $meio(R)=\{y:\exists x,z,(x,y)\in R\wedge (y,z)\in R\}$
  \item $inicio(set)-> set$, que para a relação $R$, $inicio(R)=\{x:\exists y,z,(x,y)\in R\wedge (y,z)\in R\}$
  \item $unico(set)-> set$, que para a relação $R$, $unico(R)=\{x:\exists! y,(x,y)\in R\}$ ou seja elementos $x$ a partir dos quais sai um único arco no diagrama sagital de $R$.
\end{enumerate}
\end{exer}

\section{\textbf{EXERCÍCIOS DE REVISÃO}}
\begin{exer}
Escrever as frases que se seguem usando notação lógica na qual $x$ designa um gato e $P(x)$ significa ''$x$ gosta de bolo''
\begin{enumerate}
  \item Todos os gatos gostam de bolo.
  \item Nenhum gato gosta de bolo.
  \item Um gato gosta de bolo.
  \item Alguns gatos não gostam de bolo.
\end{enumerate}
\end{exer}

\begin{exer}
Sendo $A,B,C$ três conjuntos, analise em termos lógicos, usando quantificadores, a proposição ''se $A\subseteq B$ então $A$ e $C\backslash B$ são disjuntos''.
\end{exer}
\begin{exer}
Traduzir em linguagem simbólica as proposições que se seguem, indicando as escolhas que são apropriadas para os domínios correspondentes.
\begin{enumerate}
  \item Existe um inteiro $x$ tal que $2=x+1$.
  \item Para todos os inteiros $x$, $2=x+1$.
  \item Todos os que entendem Lógica gostam dela.
  \item $x^2-4=0$ tem uma raiz positiva.
  \item Toda a solução da equação $x^2-4=0$ é positiva.
  \item Nenhuma solução da equação $x^2-4=0$ é positiva.
\end{enumerate}
\end{exer}

  \begin{exer} Indique o significado das proposições que se seguem, sendo a quantificação feita sobre $\mathds{N}$
  \begin{itemize}
    \item $\forall x\exists y(x<y)$
    \item $\exists y\forall x(x<y)$
    \item $\exists x\forall y(x<y)$
    \item $\forall y\exists x(x<y)$
    \item $\exists x\exists y(x<y)$
    \item $\forall x\forall y(x<y)$
  \end{itemize}
  Indique qual o valor lógico de cada uma delas.
  \end{exer}

  \begin{exer} Sendo $\mathds{R}$ o universo do discurso escreva em linguagem simbólica as seguintes afirmações:
  \begin{itemize}
    \item A identidade da adição é o 0.
    \item Todo o número real tem simétrico.
    \item Os números negativos não têm raízes quadradas.
    \item Todo o número positivo possui exactamente duas raízes quadradas.
  \end{itemize}
  \end{exer}
\begin{exer}
Seja $\mathds{N}=\{1,2,3,4,\ldots\}$, $P(x)$ a afirmação ''$x$ é par'', $Q(x)$ a afirmação ''$x$ é divisível por 3'' e $R(x)$ a afirmação ''$x$ é divisível por 4''. Expressar em linguagem corrente cada uma das proposições que se seguem e determinar o seu valor lógico.
\begin{enumerate}
  \item $\forall x\in \mathds{N}:P(x)\wedge Q(x)$
  \item $\exists x\in \mathds{N}:R(x)$
  \item $\exists x\in \mathds{N}:P(x)\wedge Q(x)$
  \item $\exists x\in \mathds{N}:P(x)\rightarrow Q(x)$
  \item $\exists x\in \mathds{N}:Q(x)\wedge Q(x+1)$
\end{enumerate}
\end{exer}
\begin{exer}
Indicar se as proposições são sempre, às vezes ou nunca verdadeiras.
\begin{enumerate}
  \item $(\exists x\in D:\neg P(x))\Rightarrow \neg(\exists x\in D:P(x))$
  \item $\neg(\forall x\in D:\neg P(x))\Rightarrow (\forall x\in D:\neg P(x))$
  \item $\neg(\exists x\in D:\neg P(x))\Rightarrow (\exists x\in D:\neg P(x))$
\end{enumerate}
\end{exer}
\begin{exer}
Dados $S=\{2,a,{3},4\}$ e $R=\{{a},3,4,1\}$, indique se são verdadeiras ou falsas as proposições:
    \begin{enumerate}
      \item $\{a\}\in S$
      \item $\{a\}\in R$
      \item $\{a,4,\{3\}\}\subseteq S$
      \item $\{\{a\},1,3, 4\}\subset R$
      \item $R=S$
      \item $\{a\}\subseteq S$
      \item $\{a\}\subseteq R$
      \item $\emptyset \subset R$
      \item $\emptyset \subset \{\{a\}\}\subseteq R$
      \item $\{\emptyset\}\subseteq S$
      \item $\emptyset\in R$
      \item $\emptyset \subseteq \{\{3\},4\}$
    \end{enumerate}
\end{exer}
\begin{exer}
 Mostre que $$(R\subseteq S)\wedge (S\subseteq Q)\Rightarrow R\subseteq Q$$
 \end{exer}
\begin{exer}
 Determine o conjunto potência de:
\begin{enumerate}
  \item $\{a,\{b\}\}$
  \item $\{1,\emptyset\}$
  \item $\{X,Y,Z\}$
\end{enumerate}
\end{exer}
\begin{exer}
Dados conjuntos $A=\{x|x \text{ é um inteiro e }1\leq x\leq 5\}$, $B=\{3,4,5,17\}$, e $C=\{1,2,3,\ldots\}$, determine $A\cap B$, $A\cap C$, $A\cup B$, e $A\cup C$.
\end{exer}
\begin{exer}
 Mostre que $A\subseteq A\cup B$ e $A\cap B\subseteq A$.
\end{exer}
\begin{exer}
 Mostre que \[A\subseteq B \Leftrightarrow A\cup B=B.\]
\end{exer}
\begin{exer}
 Dado $A=\{2,3,4\}$, $B=\{1,2\}$, e $C=\{4,5,6\}$, determine $A\oplus B$, $B\oplus C$, $A\oplus B\oplus C$, e $(A\oplus B)\oplus (B\oplus C)$.
\end{exer}
\begin{exer}
Se $S=\{a,b,c\}$, determine conjuntos disjuntos $A_1$ e $A_2$, tais que $A_1\cup A_2=S$. Apresente outra solução, diferente da anterior.
\end{exer}
\begin{exer}
 Determine:
\begin{enumerate}
  \item $\emptyset \cap \{\emptyset\}$
  \item $\{\emptyset\} \cap \{\emptyset\}$
  \item $\{\emptyset,\{\emptyset\}\} - \emptyset$
\end{enumerate}
\end{exer}
\begin{exer}
 Liste os elementos de $\{a,b\}\times\{1,2,3\}$.
\end{exer}
\begin{exer}
Liste os elementos de $A\times B\times C$, $B^2$, $A^3$, $B^2\times A$, e $A\times B$, onde $A=\{1\}$, $B=\{a,b\}$, e $C=\{2,3\}$.
\end{exer}
\begin{exer}
Use exemplos para mostrar que $$A\times B\neq B\times A\text{ e }(A\times B)\times C\neq B\times A\times (B\times C).$$
\end{exer}
\begin{exer}
 Mostre que para conjuntos $A$ e $B$, se tem
\[\PP(A)\cup \PP(B)\subseteq \PP(A\cup B)\]
\[\PP(A)\cap \PP(B)\subseteq \PP(A\cap B)\]
Usando um exemplo, mostre que
\[\PP(A)\cup \PP(B)\neq \PP(A\cup B).\]
\end{exer}
%\begin{exer}
% Demonstre as identidades no universo $\Omega$
%\[
%A\cap A =A,\;\;A\cap\emptyset=\emptyset,\;\; A\cap \Omega =A,\;\; A\cup \Omega = \Omega
%\]
%\end{exer}
\begin{exer}
 Mostre que $A\times (B\cap C)= (A\times B)\cap (A\times C)$.
\end{exer}
%\begin{exer}
%Prove que no universo $\Omega$ \[(A\cap B)\cup(A\cap\sim B)=A \text{ e } A\cap(\sim A \cup B)= A\cap B.\]
%\end{exer}
\begin{exer}
 Mostre que $$A\times B = B\times A \Leftrightarrow (A=\emptyset)\vee (B = \emptyset)\vee (A=B).$$
\end{exer}
\begin{exer}
 Mostre que $(A\cap B)\cup C = A\cap (B\cup C)$ se e só se $C\subseteq A$.
\end{exer}
\begin{exer}
Seja $P=\{(1,2),(2,4),(3,3)\}$ e $Q=\{(1,3),(2,4),(4,2)\}$.
\begin{enumerate}
  \item Determine $P\cup Q$, $P\cup Q$, $D(P)$, $Im(Q)$, $D(P\cup Q)$, $Im(P)$, e $Im(P\cap Q)$.
  \item Mostre que $D(P\cup Q)= D(P)\cup D(Q)$ e $Im(P\cap Q)\subseteq Im(P)\cap Im(Q)$.
\end{enumerate}
\end{exer}
\begin{exer}
Seja $L$ a relação ``menor ou igual que'' e $D$ a relação ``divide'', onde $xDy$ significa ``$x$ divide $y$''. Assumindo que $L$ e $D$ estão definidos no conjunto $\{1,2,3,6\}$, escreva $L$ e $D$ na forma dum conjunto, e determine $L\cap D$.
\end{exer}
\begin{exer}
 Apresente um exemplo de uma relação que não seja nem reflexiva nem anti-reflexiva.
\end{exer}
\begin{exer}
 Apresente um exemplo de uma relação que seja simétrica e anti-simétrica.
\end{exer}
\begin{exer}
Se as relações $R$ e $S$ são ambas reflexivas, simétricas e transitivas, mostre que $R\cap S$ e $R\cup S$ também são reflexivas.
\end{exer}
\begin{exer}
Se a relação $R$ e $S$ são reflexivas, simétricas e transitivas, mostre que $R\cap S$ também é reflexiva, simétrica e transitiva.
\end{exer}
\begin{exer}
 Mostre que as relações abaixo são transitivas:
\begin{enumerate}
  \item $R_1=\{(1,1)\}$
  \item $R_2=\{(1,2),(2,2)\}$
  \item $R_3=\{(1,2),(2,3),(1,3),(2,1)\}$
\end{enumerate}
\end{exer}
\begin{exer}
 Dado $S=\{1,2,3,4\}$ e uma relação $R$ e $S$ definida por \[\{(1,2),(4,3),(2,2),(2,1),(3,1)\}\]
    mostre que $R$ é não transitiva. Determine uma relação $R_1$, tal que $R\subseteq R_1$ e seja transitiva. Existe mais alguma relação $R_2$ que contenha $R_1$ e também seja transitiva?
\end{exer}
\begin{exer}
Classifique as relações binárias, em $\mathbb{Z}$, definidas abaixo quanto à reflexividade, simetria, anti-simetria, transitividade:
\begin{enumerate}
  \item $R_1=\{(a,b):a^2-b^2\leq 1\}$
  \item $R_2=\{(a,b):a-b=1\}$
  \item $R_3=\{(a,b):ab\text{ é par }\}$
  \item $R_4=\{(a,b):a+b\text{ é par }\}$
  \item $R_5=\{(a,b):a \% 3 = b\% 3\}$, onde $x\% y$ é o resto da divisão inteira de $x$ por $y$
  \item $R_6=\{(a,b):a \% 2 = b\% 2\}$
  \item $R_7=\{(a,b):ab \% 4\text{ é par}\}$
  \item $R_8=\{(a,b):b \% a = 0\}$
\end{enumerate}
\end{exer}
\begin{exer}
Classifique as relações binárias, no conjunto das \emph{strings}, definidas abaixo quanto à reflexividade, simetria, anti-simetria, transitividade:
\begin{enumerate}
  \item $R_1=\{(a,b):a\text{ e }b\text{ têm o mesmo número de símbolos} \}$
  \item $R_2=\{(a,b):a\text{ é simétrica a }b\}$
  \item $R_3=\{(a,b):ab\text{ têm um número par de símbolos} \}$
\end{enumerate}
\end{exer}
\begin{exer}
Calcule o fecho transitivo das seguintes relações:
\begin{enumerate}
  \item $R=\{(1,2),(2,4),(4,3)\}$ no conjunto $\{1,2,3,4\}$
  \item $Q=\{(a,a),(b,d),(d,a)\}$ no conjunto $\{a,b,c,d\}$
  \item $V=\{(b,a),(b,d),(d,a)\}$ no conjunto $\{a,b,c,d\}$
\end{enumerate}
\end{exer}

\begin{exer}
Implemente funções, que tendo por argumentos um conjunto $A$ e uma relação binária $R$, no conjunto $A$, devolvem o valor lógico da proposição:
    \begin{enumerate}
      \item $f1(set,set)->bool$ tal que $f1(A,R)$ é True se e só se $\forall x\in A \exists y\in A: (x,y)\in R$
      \item $f2(set,set)->bool$ tal que $f2(A,R)$ é True se e só se $\exists x\in A \forall y\in A: (x,y)\in R$
      \item $f3(set,set)->bool$ tal que $f3(A,R)$ é True se e só se $\forall x\in A \exists! y\in A: (x,y)\in R$
      \item $f4(set,set)->bool$ tal que $f4(A,R)$ é True se e só se $\forall x\in A \forall y\in A: (x,y)\in R\wedge (y,x)\in R$
    \end{enumerate}
\end{exer}

\begin{exer}
Implemente funções, que tendo por argumento uma relação binária $R$ num conjunto $A$, devolvem o valor lógica da proposicional:
    \begin{enumerate}
      \item $g1(set)->bool$ tal que $g1(R)$ é True se e só se $\forall x\in A \forall y\in A \exists z\in A: (x,y)\in R \rightarrow (y,z)\in R$
      \item $g2(set)->bool$ tal que $g2(R)$ é True se e só se $\forall x\in A \exists y\in A \exists z\in A: (x,y)\in R \rightarrow (y,z)\in R$
      \item $g3(set)->bool$ tal que $g3(R)$ é True se e só se $\forall x\in A \exists! y\in A \exists z\in A: (x,y)\in R \rightarrow (y,z)\in R$
      \item $g4(set)->bool$ tal que $g4(R)$ é True se e só se $\forall x\in A \exists y\in A \exists! z\in A: (x,y)\in R \rightarrow (y,z)\in R$
    \end{enumerate}
\end{exer}

\begin{exer}
    Implemente funções que tendo por argumentos relações binárias $R$ e $S$ num conjunto $A$, devolvem o valor lógica da proposicional:
    \begin{enumerate}
      \item $h1(set,set)->bool$ tal que $h1(R,S)$ é True se e só se $\forall x\in A \forall y\in A \forall z\in A: (x,y)\in R \wedge (y,z)\in S \rightarrow (y,z)\in R$
      \item $h2(set,set)->bool$ tal que $h2(R,S)$ é True se e só se $\forall x\in A \forall y\in A \forall z\in A: ((x,y)\in R \wedge (x,z)\in S) \rightarrow (y,z)\in R$
      \item $h3(set,set)->bool$ tal que $h3(R,S)$ é True se e só se $\forall x\in A \forall y\in A \forall z\in A: ((x,y)\in R \vee (y,z)\in R)\rightarrow ((x,z)\in S \wedge (z,x)\in R))$
      \item $h4(set,set)->bool$ tal que $h4(R,S)$ é True se e só se $\forall x\in A \forall y\in A \forall z\in A: ((x,y)\in S \wedge (y,z)\in R)\rightarrow ((x,z)\in S \vee (z,x)\in R))$
    \end{enumerate}
\end{exer}

\begin{exer}
Implemente funções, que tendo por argumentos duas relações binárias $R$ e $S$ num conjunto $A$, devolvem o conjunto indicado:
\begin{enumerate}
  \item $s1(set,set)-> set$, que para relações $R$ e $S$, $s1(R,S)=\{y:\exists x,(x,y)\in R\wedge (y,x)\not\in S\}$
  \item $s2(set,set)-> set$, que para relações $R$ e $S$, $s2(R,S)=\{z:\exists x,y,((x,y)\in R\wedge (y,z)\in R)\wedge (x,z)\not\in S\}$
  \item $s3(set,set)-> set$, que para relações $R$ e $S$, $s3(R,S)=\{y:\exists x,z,(x,y)\in S\wedge (y,z)\in R\wedge (x,z)\not\in S\}$
  \item $s4(set,set)-> set$, que para relações $R$ e $S$, $s4(R,S)=\{x:\exists y,z,(x,y)\in R\wedge (y,z)\in S\wedge (x,z)\not\in S\}$
 \end{enumerate}
\end{exer}


```python

```
