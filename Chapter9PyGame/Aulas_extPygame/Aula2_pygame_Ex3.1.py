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
 
while done==False:
      
    for event in pygame.event.get(): 
        if event.type == pygame.QUIT: 
            done=True 
 
    screen.fill(blue)

    pos=[X,Y];

    texto(pos,'123')

    pygame.display.flip()
    clock.tick(10)

pygame.quit ()
