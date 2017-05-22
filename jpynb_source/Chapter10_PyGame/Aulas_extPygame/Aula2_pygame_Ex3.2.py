# -*- coding: cp1252 -*-
import pygame

black = [  0,  0,  0]
white = [255,255,255]
blue =  [  0,  0,255]
green = [  0,255,  0]
red =   [255,  0,  0]

def texto(pos,txt):
    ''' texto([x,y],tx) imprime o texto em tx nas coordenadas [x,y] 
    usando a fonte por defeito a 12pt.

    #--------------------------
    # Função para imprimir texto
    #---------------------------
    '''     
    font = pygame.font.Font(None, 12)
    text = font.render(txt,True,white)
    screen.blit(text, pos)

pygame.init()
  
screen=pygame.display.set_mode([400,500]) 
pygame.display.set_caption("Exemplo")
 
done=False

clock = pygame.time.Clock()

X=100
Y=100

moveX=0
moveY=0
 
while done==False:
      
    for event in pygame.event.get(): 
        if event.type == pygame.QUIT: 
            done=True
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_LEFT:
                moveX = -1
            if event.key == pygame.K_RIGHT:
                moveX = 1                
            if event.key == pygame.K_UP:
                moveY = -1
            if event.key == pygame.K_DOWN:
                moveY = 1
        # Anula movimento quando a tecla é largada
        if event.type == pygame.KEYUP:
            if event.key == pygame.K_LEFT or event.key == pygame.K_RIGHT:
                moveX = 0                
            if event.key == pygame.K_UP or event.key == pygame.K_DOWN:
                moveY = 0
 
    screen.fill(blue)

    X=X+moveX
    Y=Y+moveY

    pos=[X,Y];

    texto(pos,'123')

    pygame.display.flip()
    clock.tick(10)

pygame.quit ()
