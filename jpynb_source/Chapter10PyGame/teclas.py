fno_image_filename = 'fno.png'

import pygame

pygame.init()
screen = pygame.display.set_mode((640, 480), 0, 32)

fno = pygame.image.load(fno_image_filename).convert()
fno.set_colorkey((255,255,255))

x, y = 0, 0
move_x, move_y = 0, 0
done = False

while done==False:
     event_list=pygame.event.get()
     for event in event_list:
        if event.type == pygame.QUIT:
            done = True
        if event.type == pygame.KEYDOWN:
            if   event.key == pygame.K_LEFT:
                move_x = -1
            elif event.key == pygame.K_RIGHT:
                move_x = +1
            elif event.key == pygame.K_UP:
                move_y = -1
            elif event.key == pygame.K_DOWN:
                move_y = +1
        elif event.type == pygame.KEYUP:
            if   event.key == pygame.K_LEFT:
                move_x = 0
            elif event.key == pygame.K_RIGHT:
                move_x = 0 
            elif event.key == pygame.K_UP:
                move_y = 0
            elif event.key == pygame.K_DOWN:
                move_y = 0
     print(event_list)           
     x= x + move_x
     y= y + move_y
        
     screen.fill((0, 0, 0))
    
     screen.blit(fno, (x, y))
        
     pygame.display.flip()
pygame.quit()
