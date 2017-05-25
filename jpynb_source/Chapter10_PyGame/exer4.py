import pygame
# inicialização do módulo pygame


pygame.init()
# criação de uma janela

#Cor
white=[255,255,255]

black=[0,0,0]

largura = 17*30
altura = 17*30

tamanho = (largura, altura)
screen = pygame.display.set_mode(tamanho)

# pygame.font
def texto(screen,pos,txt):     
    font = pygame.font.Font(None, 25)
    text = font.render(txt,True,black)
    screen.blit(text, pos)

# Função para desenhar Fundo
def desenha_fundo(screen):
    # Limpa a janela e define a cor do fundo
    screen.fill(white)
    numero=1
    for linha in range(17):
        desenha_elemento(screen,0,linha*30,largura,linha*30)
        desenha_elemento(screen,linha*30,0,linha*30,altura)
        
        for coluna in range(17):
            texto(screen,(coluna*30,linha*30+5),str(numero))
            numero=numero+1

    
# Desenha linha
def desenha_elemento(screen,x_1,y_1,x_2,y_2):
    pygame.draw.line(screen,black,[x_1,y_1],[x_2,y_2],3)
    
    
jogador=[] #incia lista de imagens do utilizador
jogador.append(pygame.image.load("play1.gif").convert())
jogador.append(pygame.image.load("play2.gif").convert())
jogador.append(pygame.image.load("play3.gif").convert())


#Para entrar em loop, até que a janela seja fechada.
done=False

# Usado para controlar a velocidade com que a janela é actualizada  
clock=pygame.time.Clock()


pos_coluna=1
pos_linha=1
player=0

while done==False:
    for event in pygame.event.get(): # O utilizador actua na janela
        if event.type == pygame.QUIT: # Se o utilizador escolheu fechar janela
            done=True # o jogo deve terminar.
        if event.type == pygame.KEYDOWN:
            if   event.key == pygame.K_LEFT:
                pos_coluna =pos_coluna -1
                player=2
            elif event.key == pygame.K_RIGHT:
                pos_coluna = pos_coluna +1
                player=1
            elif event.key == pygame.K_UP:
                pos_linha = pos_linha-1
                player=0
            elif event.key == pygame.K_DOWN:
                pos_linha = pos_linha+1
                player=0
                
    desenha_fundo(screen)
    
    screen.blit(jogador[player], (pos_coluna*30,pos_linha*30))
    
    # Actualiza a janela para esta nova composição da cena.
    pygame.display.flip()
 
    # Limita a 20 o número de frames por segundo
    clock.tick(20)

# Para terminar o motor de jogo 
pygame.quit()
