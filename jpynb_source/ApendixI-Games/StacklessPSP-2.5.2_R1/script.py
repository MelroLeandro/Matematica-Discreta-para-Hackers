# Exemplos Python/Pygame 
# Projectos MDP 2012-2013
#
# Aqui o jogo está dividido em duas partes: 
#
# 1 parte – Uma janela inicial
#
# 2 parte – O primeiro nível do jogo
#
# Objectivo: Eliminar naves inimigas
# 
# Controlo: Pelo teclado (movimento) e rato (disparo)
#
# Temos dois tipos de disparos
#
# Existem dois tipos de naves inimigas que apenas se distinguem pelo 
# comportamento. Uma classe de naves tenta aproximar-se a segunda afastar-se
# do jogador. As naves inimigas lançam projecteis na direcção do jogador.
#
# Cada frame é composto de diferentes planos:
#
#  1- Um plano de fundo (com uma imagem)
#  2- Um plano de estrelas em movimento
#  3- Um plano com o jogado
#  4- Um plano com todos os projecteis em movimento 
#  5- Um plano com as naves inimigas
#
# Imagens:
#     1- fundo
#     2- 3x Jogador
#     3- 4x Inimigo
#     4- 6x Explosões
#
#
 
# Importa a biblioteca 'pygame'
import psp2d, pspos
#import pspnet
import pspmp3
#import pspogg
#from time import time, localtime
#import datetime
#import sys
#import stackless


# Importa funções para gerar números aleatórios
import random
import math

# Set processor and bus speed
pspos.setclocks(333,166)

# Texto
font = psp2d.Font("font.png")

# Define algumas cores
black = psp2d.Color(0, 0, 0)
white = psp2d.Color(255,255,255)
red = psp2d.Color(220,0,0)


def inicializa_estrelas(lista_estrelas,nivel):
    ''' inicializa_estrelas(L)-> lista_estrelas junta estrelas à lista L 

    #---------------------------
    # Função para iniciar a iniciar estrelas de fundo.
    # Cada estrela é um vector [x,y,r,v,c] onde:
    #    x,y são as coordenadas
    #    r é o raio
    #    v é a velocidade com que se deslocam
    #    c é a cor 
    #--------------------------
    '''
    # Junta 20 estrelas de fundo tendo raio, velocidades e 
	#coordenadas x,y aleatórias
    for i in range(20):
        x=random.randrange(10,470) # x é um inteiro aleatório entre 0 e 400
        y=random.randrange(10,262) # y é um inteiro aleatório entre 0 e 400
        r=random.randrange(1,3) # raio aleatório
        v=random.randrange(0,4) # raio aleatório
        fact = random.randrange(-50,50) # pequena alteração na cor da estrela
        c = psp2d.Color(243,110+fact,110+fact)
        lista_estrelas.append([x,y,r,v,c]) # junta nova estrela à lista
    return lista_estrelas


def inicializa_naves(lista_naves,nivel):
    ''' inicializa_naves(L)--> lista_naves junta naves inimigas à lista L

    #---------------------------------------------
    # Inicia distribuição inicial de naves
    #
    #  Cada nave é um lista [xN,yN]
    #        xN,yN coordenadas da nave
    #        tipo  é o tipo. AS naves inimigas são de dois tipos (tipo=1 ou tipo=2)
    #              quando alvejadas o seu tipo passa a 9. Nas naves de tipo maio que 
    #              2, o valor é decrementado e corresponde à imagem duma parte da
    #              explosão. Quando o tipo atinge 3 a nave desaparece do ecrã.
    #----------------------------------
    '''
    for i in range(2*nivel):
        xN=random.randrange(0,400) # x é um inteiro aleatório entre 0 e 400
        yN=random.randrange(-400,-10) # y é número aleatório entra -400 e -10 
        tipo = random.randrange(1,3) # escolhe tipo de nave
        # y é um inteiro aleatório entre 0 e 400
        lista_naves.append([xN,yN,tipo])
        # junta floco à lista
    xN=random.randrange(0,400)
    lista_naves.append([xN,-100,-1]) # vida
    return lista_naves

    
def processa_estrelas(screen,lista_estrelas):
    ''' processa_estrelas(screen,L) desenha as estrelas em L na superficie screen
     #
     # Processa cada estrela na lista, para definir nova frame, no plano mais
     # afastado
     #
    '''
    for i in range(len(lista_estrelas)):
        # Desenha floco
        # [x,y,r,v,c]
        x=lista_estrelas[i][0]
        y=lista_estrelas[i][1]
        r=lista_estrelas[i][2]
        v=lista_estrelas[i][3]
        c=lista_estrelas[i][4]
        if y>=0 and y<=272:
            screen.fillRect(x,y,r,r,c)

        # Move o floco um pixel para baixo
        lista_estrelas[i][1]+= v
         
        # Caso o floco sai da janela ele deve ser colocado no topo  
        if lista_estrelas[i][1] > 400:
            # Faz o floco aparecer ligeiramente acima do topo
            y=random.randrange(-50,-10)
            lista_estrelas[i][1]=y
            # define aleatoriamente um novo x para floco 
            x=random.randrange(0,470)
            lista_estrelas[i][0]=x
 
def Actualiza_projecties(screen,lista_proj,lista_naves,Estado_da_nave,pontos):
    ''' projecties(screen,lista_proj,lista_naves,Estado_da_nave)--> [Nova_lista,lista_naves,Estado_da_nave] desenha e actualiza posição dos projecteis, detecta colisões de projecteis com naves, e actualiza estado da nave
do jogador.
    #--------------------------
    # Actualiza posição dos projecteis e determina colisões:
    #
    #    1- Aqui é desenhada cada projéctil.
    #    2- Existem três tipos de projecteis. Dois do jogador e um do inimigo. 
    #       Estes projecteis têm comportamento diferentes
    #    3- É actualizada a posição dos projéctil
    #    4- Detecta colisão. Colisão de projéctil com nave inimiga põe o 
    #       seu tipo a 9 um colisão com jogador decrementa Estado_da_nave  
    #----------------------------
    '''
    Nova_lista=[]
    for proj in lista_proj:
        xP=proj[1]
        yP=proj[2]
        tipo = proj[0]
        xInc = proj[3][0] # incremento em x 
        yInc = proj[3][1] # incremento em y
        # Desenha os projecteis dependendo do tipo
        if yP>=10 and yP<=265 and xP>=10 and xP<=480:
            if tipo==1: # No caso de um projectil do tipo 1
                    screen.fillRect(xP,yP,2,3,white)
            if tipo==2: # No caso de um projéctil do tipo 2
                if time % 2 ==0:
                    screen.fillRect(xP,yP,3,3,red)
                else:
                    screen.fillRect(xP,yP,3,3,white)
                xInc = xInc*2 # incrementa velocidade dos projecteis de tipo 2
                yInc = yInc*2
            if tipo==3: # O projecteis de tipo 3 são do inimigo
                if time % 2 ==0:
                    screen.fillRect(xP,yP,3,3,red)
                else:
                    screen.fillRect(xP,yP,3,3,white)
        # Move projecteis
        xP= xP - xInc
        yP= yP - yInc
        # Colisão dum projectil com uma nave
        for i in range(len(lista_naves)):
            xN = lista_naves[i][0]
            yN = lista_naves[i][1]
            if tipo!=3 and (xP>xN-7 and xP<xN+7 and yP>yN-7 and yP<yN+7): # Colisão
                lista_naves[i][2]=9 # muda tipo da nave inimiga para 10 
                pontos += 10 
                break
        else: # Colisão com jogador
            if tipo==3 and (xP>xJ-15 and xP<xJ+15 and yP>yJ-15 and yP<yJ+15):
                if not escudo:
                    Estado_da_nave -=1
            else:
                # Caso a bala deixe de ser visível remove
                if not (xP<-10 or xP>480 or yP<-10 or yP>410):
                    Nova_lista.append([tipo,xP,yP,[xInc,yInc]])
    return [Nova_lista,lista_naves,Estado_da_nave,pontos]



def Processa_naves_inimigas(screen,lista_naves,lista_proj,xJ,yJ,Estado_da_nave,pontos):
    ''' Processa_naves_inimigas(screen,lista_naves,lista_proj,xJ,yJ,Estado_da_nave)-->
[lista_naves,lista_proj,Estado_da_nave]
 actualiza naves inimigas e detecta colisões com jogador.  

    #-----------------------
    # Processa cada nave inimiga, 
    #   1- Caso detecta colisão com jogador, inicia destruição da nave inimiga e
    #      actualiza estado da nave do output-01.cap
    #   2- Caso deve atacar adiciona projéctil de tipo 3 na lista de projecteis
    #   3- Define comportamento da nave inimiga. As naves de tipo 1 têm tendência a 
    #      aproximar-se do jogador. As naves de tipo 2 têm tendência a de afastar
    #      do jogador.
    #   4- Caso a nave deixe de ser visível ou esteja abatida, cria uma nova nave.
    #
    #-----------------------
    '''
    
    for i in range(len(lista_naves)):
        # Desenha Naves
        xN = lista_naves[i][0]
        yN = lista_naves[i][1]
        NaveTipo= lista_naves[i][2]

        # verifica se a nave bateu no jogador
        if xN>xJ-13 and xN<xJ+13 and yN>yJ-13 and yN<yJ+13: # Colisão
                if not escudo:
                    Estado_da_nave -= 1
                if NaveTipo == 1 or NaveTipo == 2:
                    lista_naves[i][2]=10
                    pontos +=5
                elif NaveTipo == -1:
                    lista_naves[i][2]=5
                    Estado_da_nave += 3
                elif NaveTipo == -2:
                    lista_naves[i][2]=5
                    energia += 3
        # verifica se deve atacar jogador
        if time % random.randrange(90,150) == 0:
            lista_proj.append([3,xN+10,yN-10,[int((xN-xJ)*.1),int((yN-yJ)*.1)]])
                
        # Move nave em função do tipo
        if NaveTipo == -1: # vida
            screen.blit(Crys[int(time*.1)%4],0,0,17,17,xN-8,yN-8,True)
            lista_naves[i][1]+= 5 
            lista_naves[i][0]+= random.randrange(-3,3)
        elif NaveTipo == 2: # tenta intersectar jogador

            screen.blit(En[(time+yJ)%4],0,0,25,25,xN-12,yN-12,True)
            if yJ>0 and abs(xJ-xN)>20 and abs(yJ-yN)>20:
                MoveXnave= (xJ-xN)/abs(xJ-xN)
                MoveYnave= (yJ-yN)/abs(yJ-yN)

                lista_naves[i][0]+= MoveXnave*2
                lista_naves[i][1]+= MoveYnave*2
            else:
                lista_naves[i][1]+= 5
        elif NaveTipo == 1: # tenta evitar jogador
            if yN>=10 and yN<=265 and xN>=10 and xN<=470:
                screen.blit(En[(time+yJ)%4],0,0,25,25,xN-12,yN-12,True)
            if yJ>0 and 0<abs(xJ-xN)<50 and 0<abs(yJ-yN)<50:
                MoveXnave= (xJ-xN)/abs(xJ-xN)
                MoveYnave= (yJ-yN)/abs(yJ-yN)

                lista_naves[i][0]+= -MoveXnave*5
                lista_naves[i][1]+= -MoveYnave*5
            else:
                lista_naves[i][1]+= 5
        else: # Naves em destruição
            if yN>=17 and yN<=265 and xN>=10 and xN<=470:
                screen.blit(Explo[9-NaveTipo],0,0,45,45,xN-17,yN-17,True)
            lista_naves[i][2]-= 1 # decrementa um valor no raio da explosão
            lista_naves[i][1]+= 3
        # Caso a nave sai da janela os seja destruida, deve ser 
        # substituida por uma nova nave no topo  
        if lista_naves[i][1] > 480 or NaveTipo==3:
            # Faz a nave aparecer ligeiramente acima do topo
            yN=random.randrange(-100,-10)
            lista_naves[i][1]=yN
            # define aleatoriamente um novo x para nave 
            xN=random.randrange(0,480)
            lista_naves[i][0]=xN

            # define aleatoriamente um novo tipo para nave
            tipoN = lista_naves[i][2]
            if tipoN!=-1:
                tipoN=random.randrange(1,3)
            lista_naves[i][2]=tipoN
    return [lista_naves,lista_proj,Estado_da_nave, pontos]
    
            
# Descreve as dimensões do ecrã de jogo
screen = psp2d.Screen() 

# Carrega imagens - Jogador
NaveU = psp2d.Image("nave.png")

NaveE = psp2d.Image("naveE.png")

NaveD = psp2d.Image("naveD.png")

cristal = psp2d.Image("Crystal1.png")

Crys=[]
for num in range(4):
    image = psp2d.Image(17, 17)
    image.blit(cristal,num*17,1,17,17,0,0,True)
    Crys.append(image)

cristal = psp2d.Image("Teleport.png")

Escudo=[]
for i in range(2):
    for num in range(3):
        image = psp2d.Image(48, 48)
        image.blit(cristal,num*48,i*48,48,48,0,0,True)
        Escudo.append(image)

cristal = psp2d.Image("solo2.png")

painelALL = psp2d.Image("board.png")
painel = psp2d.Image(240, 18)
painel.blit(painelALL,0,22,240,18,0,0,True)
#painel=painelALL.subsurface((0, 22, 240 ,18))
energy = psp2d.Image(49, 13)
energy.blit(painelALL,184,5,49,13,0,0,True)

#energy=painelALL.subsurface((184, 5,  49 233-184 ,13 18-5))
                

# Carrega imagem do inimigo
En=[]
for i in range(4):
    En.append(psp2d.Image("En1"+str(i+1)+".png"))

# Carrega imagem da explosão
Explo=[]
for i in range(7):
    Explo.append(psp2d.Image("exp"+str(i)+".png"))
    
# contador para controlar número de tiros e imagens

# Carrega imagem inicial
JanelaInicil = psp2d.Image("galactica.png")

# Texto: De instruções na janela inicial
font.drawText(JanelaInicil,5, 236, "Inicia o jogo com X.")
font.drawText(JanelaInicil,5,252,"Termina com O.")

# Carrega imagem para passar de nivel
JanelaNivel = psp2d.Image("galactica.png")

# Texto: De instruções na janela inicial
font.drawText(JanelaNivel,5, 236, "Continuar no jogo com X.")
font.drawText(JanelaNivel,5,252,"Termina com O.")


# Carrega música ambiente (só pode ter uma a tocar)
pspmp3.init(1)
pspmp3.load("BG3_11_Battlestar.mp3") # música ambiente
pspmp3.play()

# Inicia jogo no menu inicial

MenuInicial = True
PassaNivel = False
time=1
Nivel=1
pontos = 0
OldPontos = 0

screen.blit(JanelaInicil)
screen.swap()
 
#Entra em Loop até o utilizador feche a janela
done=False
while done==False:

    if MenuInicial:
        
        pad = psp2d.Controller()
        
        if pad.circle:
            done = True
            
        elif pad.cross:
            #------------------
            # inicia a estrutura do jogo
            #------------------
            MenuInicial = False
            Nivel=1

            # Define posição inicial do jogador
            xJ = 240
            yJ = 200
            # Inicia movimento
            moveX=0 # não temos movimento em x
            moveY=0 # não temos movimento em y

            # Define estado inicial da nave. Quando este valor é zero a nave é destruída
            Estado_da_nave = 15
            energia =100

            # para contagem decrescente na criação da imagem do jogador 
	    # a ser destruido
            destruicao = 6

            # Cria a lista de estrelas para plano de fundo

            lista_estrelas=[]
            lista_estrelas= inicializa_estrelas(lista_estrelas,Nivel)

            # Usa a mesma estratégia aplicada
            # Junta 10 naves inimigas de dois tipos

            lista_naves=[]
            lista_naves= inicializa_naves(lista_naves,Nivel)

            # Inicial lista de projecteis
            lista_proj=[]

            # Define Nível
            time=1
            pontos = 0
            OldPontos = 0
            escudo = False


            # Jogador
            jogador= NaveU
            screen = psp2d.Screen()
            
            # Carrega imagem fundo
            cristal = psp2d.Image("3d_space_5.png")
            SoloIm=[]
            SoloIm.append(cristal)
            ciclo=1
            del(cristal)

            
    elif PassaNivel:   
        pad = psp2d.Controller()
        
        if pad.circle:
            done = True
            
        elif pad.cross:
            #------------------
            # inicia a estrutura do jogo
            #------------------
            PassaNivel = False

            # Define posição inicial do jogador
            xJ = 240
            yJ = 200
            # Inicia movimento
            moveX=0 # não temos movimento em x
            moveY=0 # não temos movimento em y

            if Nivel==2 or Nivel==3:
                if Nivel==2:
                    cristal = psp2d.Image("solo1.png")
                else:
                    cristal = psp2d.Image("solo2.png")
                imageAux= psp2d.Image(480, 272)
                imageAux.blit(cristal,0,400-272,480,272,0,0,False)
                t=400-272
                v=16
                SoloIm=[]
                ciclo=400/v
                for i in range(ciclo):
                    aux = psp2d.Image(480, 272)
                    aux.blit(imageAux,0,0,480,272-v,0,v,True)
                    t=t-v
                    if t<0:
                        t=400-v
                    aux.blit(cristal,0,t,480,v,0,0,True)
                    SoloIm.append(aux)
                    imageAux.blit(aux)
                    lista_estrelas=[]
                    lista_naves=[]
                del(cristal)        

            # Cria a lista de estrelas para plano de fundo

            #lista_estrelas=[]
            #lista_estrelas= inicializa_estrelas(lista_estrelas,Nivel)

            # Usa a mesma estratégia aplicada
            # Junta 10 naves inimigas de dois tipos

            lista_naves=[]
            lista_naves= inicializa_naves(lista_naves,Nivel)

            # Inicial lista de projecteis
            lista_proj=[]
            time=1
            destruicao = 6
            Estado_da_nave = 15
            energia =100


            # Jogador
            jogador= NaveU
            screen = psp2d.Screen()
            #imageAux = psp2d.Image(480, 272)
            #imageAux.blit(fundo)
            #t=400-272
    else:
        pad = psp2d.Controller()
        escudo = False
        
        if pad.circle:
            done = True
        elif pad.left:
            jogador= NaveE
            moveX = -1
            moveY = 0
        elif pad.right:
            jogador= NaveD
            moveX = 1
            moveY = 0
        elif pad.up:
            jogador= NaveU
            moveX = 0
            moveY = -1
        elif pad.down:
            jogador= NaveU
            moveX = 0
            moveY = 1
        else:
            jogador= NaveU
            moveX = 0
            moveY = 0
            
        if pad.square and time%5 == 0: # adiciona bala do tipo 1
            lista_proj.append([1,xJ-10,yJ-10,[0,10]]) # estas balas avançam com velocidade 10
            lista_proj.append([1,xJ+7,yJ-10,[0,10]])
        elif pad.triangle and time%4 == 0: # adiciona bala do tipo 2
            lista_proj.append([2,xJ-2,yJ-12,[-1,1]]) # estas balas avançam na diagonal com crescente velocidade
            lista_proj.append([2,xJ-2,yJ-12,[1,1]])

        if pad.l:
            escudo = True
                    
     
        # Processa cada estrela na lista, para definir nova frame, no plano mais
        # afastado
        v=5
        image = psp2d.Image(480, 272)
        image.blit(SoloIm[time%(ciclo)])

        if escudo:
            energia += -.1
            if int(energia) < 1:
                escudo = False
            
        
        processa_estrelas(image,lista_estrelas)

        # Em primeiro plano põe imagem do jogador
        if Estado_da_nave>0:
            if escudo and time%4 > 1:
                image.blit(Escudo[int(time*.3)%6],0,0,48,48, xJ-26,yJ-26,True)
            else:
                image.blit(jogador,0,0,20,20, xJ-10,yJ-10,True)

                # Restrições no movimento do jogador
            if xJ<10 : # Restringe X
                moveX=0
                xJ=10
            elif xJ>470:
                moveX=0
                xJ=470
            else:
                xJ=xJ+moveX*10
            
            if yJ<80: # Restrição no Y
                moveY=0
                yJ=80
            elif yJ>260:
                moveY=0
                yJ=260
            else:
                yJ=yJ+moveY*10
                            
        else:
            image.blit(Explo[6-destruicao],0,0,45,45,xJ-20,yJ-20,True)
            image.blit(Explo[6-destruicao],0,0,45,45,xJ,yJ,True)
            destruicao-=1   
        if destruicao>=0:
            #
            # Actualiza posição dos projecteis e determina colisões
            #
            [lista_proj,lista_naves,Estado_da_nave,pontos] = Actualiza_projecties(image,lista_proj,lista_naves,Estado_da_nave,pontos)    

            # Processa cada nave inimiga, no plano mais
            # próximo
            [lista_naves,lista_proj,Estado_da_nave,pontos] = Processa_naves_inimigas(image,lista_naves,lista_proj,xJ,yJ,Estado_da_nave,pontos)
            image.blit(painel,0,0,240,40-22,120,265-18,True)
            if int(energia/100*29)>29:
                energia = 100
                Estado_da_nave += 10
            if int(Estado_da_nave/15.0*49)>49:
                Estado_da_nave=15
            if int(Estado_da_nave/15.0*49)>0:
                image.blit(energy,0,0,int(Estado_da_nave/15.0*49),13,120+183,267-17,True)
            if int(energia/100*29)>0:
                image.blit(energy,0,0,int(energia/100.0*29),13,120+132,267-17,True)
            if pontos>0:
                font.drawText(image,120+52-math.log10(pontos)*7,266-17,str(pontos))
            else:
                font.drawText(image,120+52,266-17,str(0))
            screen.blit(image)
            if pontos-OldPontos>200*Nivel:
                Nivel += 1
                OldPontos=pontos
                PassaNivel = True
                image.blit(JanelaNivel)
                font.drawText(image,200,200,"Nivel "+str(Nivel))
                screen.blit(image)
        else:
            MenuInicial = True
            screen = psp2d.Screen()
            screen.blit(JanelaInicil)
        
        screen.swap()
    # incrementa contador
    time += 1

pspmp3.end()
