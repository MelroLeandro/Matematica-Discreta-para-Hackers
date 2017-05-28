---
layout: post
title: "Capítulo 10 A biblioteca Pygame"
subtitle: "Matemática Discreta para Hackers"
author:  Mellean
tags:   python
category:  python
visualworkflow: false
---

<script src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML" type="text/javascript"></script>

Capítulo 10: A biblioteca Pygame
======

## Instalação do Pygame


### O programa abaixo usa o Pygame e descreve como se pode criar uma janela de titulo "O PyGame é fixe!"
>  Para isso crie um novo ficheiro no menu File do IDLE, seleccionando  **new window**. Escreva o código abaixo no editor do IDLE e grave com o nome fixepygame.py. Depois corra o programa premindo F5 ou seleccionando **Run > Run Module** do menu no topo do editor de ficheiros.


```python
# Importa o modulo com o pygame
import pygame_sdl2 as pygame
```


```python
# Inicia o motor de jogo
pygame.init()
```




    (5, 0)




```python
# Indica as dimensões da janela
size=[700,500]
screen=pygame.display.set_mode(size)
```


```python
# Escreve titulo na Janela
pygame.display.set_caption("O PyGame é fixe!")
```


```python
# Usado para controlar a velocidade com que a janela é actualizada  
clock=pygame.time.Clock()
```


```python
#Para entrar em loop, até que a janela seja fechada.
done=False
```


```python
while done==False:
    for event in pygame.event.get(): # O utilizador actua na janela
        if event.type == pygame.QUIT: # Se o utilizador escolheu fechar janela
            done=True # o jogo deve terminar.

    # Actualiza a janela para esta nova composição da cena.
    pygame.display.flip()

    # Limita a 20 o número de frames por segundo
    clock.tick(20)

```


```python
# Para terminar o motor de jogo
pygame.quit ()
```

O processo de carregamento e inicialização do pygame é muito simples. O pygame é uma colecção de módulos numa única biblioteca. Alguns destes módulos estão escritos em C, outros em Python. Alguns são opcionais, podendo não estar sempre presentes.

### Init - Iniciar o motor de jogo
Antes de fazer seja o que for deve iniciar o motor de jogo. A forma mais usual de o fazer é através de:

> pygame.init()

Iniciando todos os módulos por si. Nem todos os módulos necessitam ser iniciados, mas assim todos os que necessitam serão.

### Quit - Terminar o motor de jogo
Os módulos inicializados são terminados usando o método quit().
Para a execução de um script não é obrigatório que este termine com pygame.quit(). Mas caso seja executado através do IDLE, se o script não termina os módulos do pygame, a janela gráfica não é fechada e o editor pode bloquear.

### Módulos
O Pygame tem os seguintes módulos dos quais vamos usar um número muito restrito das suas funções:

1. cdrom - Controla o acesso à unidade de cdrom devices, permitindo a reprodução de  audio.
1. cursors - Carrega imagens para o cursor do rato.
1. display - Controlo da janela gráfica.
1. draw - Permite desenhar elementos gráficos (linhas, círculos,...).
1. event - Gestão de eventos e controlo da lista de eventos.
1. font - Cria e faz o render de fontes para texto.
1. image - Carrega e grava imagens.
1. joystick - Controlo pelo joystick.
1. key - Controlo pelo teclado.
1. mouse - Controlo pelo rato.
1. movie - Reproduz ficheiro multimédia mpeg.
1. sndarray - Manipula sons com o módulo Numeric.
1. surfarray - Manipula imagens com o  módulo Numeric.
1. time - Controlo do tempo.
1. transform - Transformações gráficas de mudança de escala, rotação, e flip.    

[Continuação](https://github.com/MelroLeandro/Matematica-Discreta-para-Hackers/blob/master/jpynb_source/Chapter10_PyGame/Chapter10_PyGame.ipynb)
