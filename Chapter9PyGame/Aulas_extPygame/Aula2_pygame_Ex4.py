# -*- coding: cp1252 -*-
import pygame_sdl2 as pygame

black = [  0,  0,  0]
white = [255,255,255]
blue =  [  0,  0,255]
green = [  0,255,  0]
red =   [255,  0,  0]

pygame.init()
  
screen=pygame.display.set_mode([400,500]) 
pygame.display.set_caption("Exemplo")
 
done=False

clock = pygame.time.Clock()

background = pygame.image.load("fundo.jpg").convert()

# Carrega imagens - Jogador

NaveU = pygame.image.load("nave.png").convert()

NaveU.set_colorkey([191,220,191])

NaveE = pygame.image.load("naveE.png").convert()

NaveE.set_colorkey([191,220,191])

NaveD = pygame.image.load("naveD.png").convert()

NaveD.set_colorkey([191,220,191])

moveX=0
moveY=0

X=100;
Y=100;
 
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

    screen.blit(background, [0,0])

    pygame.display.flip()
    clock.tick(10)

pygame.quit ()
