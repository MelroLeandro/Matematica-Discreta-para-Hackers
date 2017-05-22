# -*- coding: cp1252 -*-
# Sample Python/Pygame Programs
# Simpson College Computer Science
# http://cs.simpson.edu
# Adaptado para projectos de MDP 2011-12

#Tendo por base o código Aula1\_pygame.py e os elementos disponíveis em aula2.zip resolva os seguintes problemas: 

#
# O invasor:
#
#1- Inicie o pygame com uma janela gráfica 400x500.
#2- Junta imagem de fundo (sky.jpg).
#3- Desloque no topo da janela, da esquerda para a direita,
#   a imagem de um OVNI (fno.png). Impondo o branco como a
#   cor transparente. 
#4- Use a metade inferior da janela para deslocar a imagem
#    do jogador, controlada pelo rato. Estas imagens estão
#    em play1.gif, play2.gif e play3.dif, devendo a imagem
#    escolhida depender do movimento do rato. Devendo usar
#    play1.gif quando o rato não está em movimento. Reservado
#    play2.gif e play3.gif, respectivamente, para identificar
#    as situações onde o rato se desloca da direita para a
#    esquerda e da esquerda para a direita.   
#5- O jogador dispara um círculo, no sentido ascendente, sempre
#   que se usa o botão esquerdo do rato. Atenção: os projecteis que
#   não estejam visíveis devem ser removidas da estrutura auxiliar. 
#6- Meta no ecrã um contador de pontos. Sempre que um projéctil
#   intersecte o OVNI, deve incrementá-lo. 
#7- Sempre que se dispara ou sempre que um projéctil intersecta o OVNI devem ser emitidos sons diferentes.   
#
 
import pygame

black = [  0,  0,  0]
white = [255,255,255]
blue =  [  0,  0,255]
green = [  0,255,  0]
red =   [255,  0,  0]

pygame.init()

def texto(pos,txt):     
    font = pygame.font.Font(None, 25)
    text = font.render(txt,True,black)
    screen.blit(text, pos)
  
screen=pygame.display.set_mode([400,500]) 
pygame.display.set_caption("MDP Game - OVNI -2012/13")
 
done=False
xfno=0     #inicia x do OVNI
xOld=0     #inicia coordenadas do utilizador
yOld=0
pontos = 0 #inicia pontos

balas=[]

clock = pygame.time.Clock()

background = pygame.image.load("sky.jpg").convert()
fno = pygame.image.load("fno.png").convert() #imagem do OVNI
fno.set_colorkey(white) # Define Cor que se assume como transparente

jogador=[] #incia lista de imagens do utilizador
jogador.append(pygame.image.load("play1.gif").convert())
jogador.append(pygame.image.load("play2.gif").convert())
jogador.append(pygame.image.load("play3.gif").convert())


while done==False:
      
    for event in pygame.event.get(): 
        if event.type == pygame.QUIT: 
            done=True 
 
    screen.fill(blue)

    screen.blit(background, [0,0])

    # Rato 
    pos = pygame.mouse.get_pos() #coordenadas do rato
    
    #posição do rato
    xR=pos[0]
    yR=pos[1]

    mousestat= pygame.mouse.get_pressed() #teclas do rato


    # Jogor:
    if yR<250: # Limita yR
        yR=250
    elif yR>450:
        yR=450

    if xR<0: # Limita xR
        xR=0
    elif xR>350:
        xR=350
    
    if xR<xOld:
        screen.blit(jogador[1], [xR,yR]) #move direita
    elif xR>xOld:
        screen.blit(jogador[2], [xR,yR]) #move esquerda
    else:
        screen.blit(jogador[0], [xR,yR]) #está parado ou move na vertical


    xOld=xR #actualiza posição
    yOld=yR

    # adiciona bala na lista balas
    if mousestat[0]:
        balas.append([xR+30,yR])

    if xfno>400: #chega ao fim da janela
        xfno=0
    else:
        xfno=xfno+15

    screen.blit(fno, [xfno,50]) #desenha OVNI

    #move bala
    newbalas=balas[:]
    #update da posição das bolas na lista balas
    for i in range(len(balas)):
        balas[i][1]= balas[i][1]-10 #move bala i para cima
        if balas[i][1]<0: #bola chega ao topo da janela
            print( i, newbalas)
            newbalas.remove(balas[i]) #remove bala da lista
        else:
            xB=balas[i][0] #coordenadas da bola i
            yB=balas[i][1]
            pygame.draw.ellipse(screen,black,[xB,yB,10,10]) #pinta bola
            if xB>xfno and xB<xfno+50 and yB>20 and yB<50:  #bola bate no OVNI
                pygame.draw.ellipse(screen,red,[xB,yB,30,30])
                pontos=pontos+1
            
    balas=newbalas

    texto([50,450],'Pontos: '+str(pontos)) #imprime pontos
    
    pygame.display.flip()
    clock.tick(10)

pygame.quit ()
