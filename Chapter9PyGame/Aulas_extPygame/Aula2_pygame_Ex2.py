# -*- coding: cp1252 -*-
import pygame

black = [  0,  0,  0]
white = [255,255,255]
blue =  [  0,  0,255]
green = [  0,255,  0]
red =   [255,  0,  0]

def texto(pos,txt):

    ''' texto([x,y],tx) imprime o texto em tx nas coordenadas [x,y] 

    '''     

    font = pygame.font.Font(None, 12)
    text = font.render(txt,True,white)
    screen.blit(text, pos)

pygame.init()
  
screen=pygame.display.set_mode([400,500]) 
pygame.display.set_caption("Exemplo")

background = pygame.image.load("fundo.jpg").convert()

# Carrega imagens - Jogador

NaveU = pygame.image.load("nave.png").convert()
NaveU.set_colorkey([191,220,191])

NaveE = pygame.image.load("naveE.png").convert()
NaveE.set_colorkey([191,220,191])

NaveD = pygame.image.load("naveD.png").convert()
NaveD.set_colorkey([191,220,191])

Nave=NaveU

# Carrega imagem da explosão
Explo=[]
for i in range(7):
    Explo.append(pygame.image.load("exp"+str(i)+".png").convert())
    Explo[i].set_colorkey([69,78,91])
   

done=False

clock = pygame.time.Clock()

moveX=0
moveY=0

X=100
Y=100

lista_pos=[[200,10],[200,100],[200,200]]
lista_tex=['Maria','100','carlos']

cont=0

while done==False:

      for event in pygame.event.get():
            if event.type == pygame.QUIT:
                done=True
            if event.type == pygame.KEYDOWN:
                  if event.key == pygame.K_LEFT:
                        moveX = -10
                  if event.key == pygame.K_RIGHT:
                        moveX = 10
                  if event.key == pygame.K_UP:
                        moveY = -10
                  if event.key == pygame.K_DOWN:
                        moveY = 10
            if event.type == pygame.KEYUP:
                  if event.key == pygame.K_LEFT or event.key == pygame.K_RIGHT:
                        moveX = 0
                  if event.key == pygame.K_UP or event.key == pygame.K_DOWN:
                        moveY = 0           
      screen.fill(blue)
      screen.blit(background, [200-151/2,250-151/2])
#######
      X=X+moveX
      Y=Y+moveY
      pos=[X,Y]
      
      screen.blit(Nave, pos)

      screen.blit(Explo[cont%7], [300,300])

      for idx in range(len(lista_pos)):
            for inc in range(3):
                  [x,y]=lista_pos[idx]
                  tex=lista_tex[idx]
                  texto([x+inc*50,y],tex)


#######
      cont=cont+1
      pygame.display.flip()
      clock.tick(10)

pygame.quit ()
