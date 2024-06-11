import processing.sound.*;


PImage[] sprite_sonic = new PImage[5];
PImage[] sprite_mario = new PImage[8];
PImage title;
PImage backgroundImg;
PImage ring;
PImage star;
PImage eggman;
PImage bomb;
SoundFile confirmSound; 
int psonic;
int pmario;
float dimension_mario;
float dimension_ring;
float dimension_star;
PImage victoryScreen;
PImage empateScreen;
PImage winnerPlayer1;
PImage winnerPlayer2;
SoundFile victorySound;
SoundFile empateSound;
boolean victorySoundPlayed = false;
boolean empateSoundPlayed = false;

int sonicDelay = 200; 
int marioDelay = 1;

int tela = 0;
int value = 0;
int vazio = 0;
int tabuleiro[][] = { {vazio,vazio,vazio},
                      {vazio,vazio,vazio},
                      {vazio,vazio,vazio}
                    };
int player[] = {vazio,vazio,vazio,
                vazio,vazio,vazio,
                vazio,vazio,vazio};

int turn = 0;
int c, l = 0;
int coluna, linha = 0;

PImage player1;
PImage player2;
PImage pl1 = ring;
PImage pl2 = star;
float dimension_p1 = 0;
float dimension_p2 = 0;
int sprite_sel1 = 1;
int sprite_sel2 = 2;
int sprite1= 1;
int sprite2= 2;
int ganhador = 0;
int empate = 0;
char nivel = 'f';
int timer_atual = 0;
int timer_restante = 0;
int t_inicio = 0;
int translacao = 0;

void setup() {
  size(800, 600);
  dimension_mario = 1.3;
  backgroundImg = loadImage("background.jpeg");
  sprite_sonic[0] = loadImage("Sprites/sonic_pose0-removebg-preview.png");
  sprite_sonic[1] = loadImage("Sprites/sonic_pose1-removebg-preview.png");
  sprite_sonic[2] = loadImage("Sprites/sonic_pose2-removebg-preview.png");
  sprite_sonic[3] = loadImage("Sprites/sonic_pose3-removebg-preview.png");
  sprite_sonic[4] = loadImage("Sprites/sonic_pose4-removebg-preview.png");

  sprite_mario[0] = loadImage("Sprites/mario2-Photoroom.png-Photoroom.png");
  sprite_mario[1] = loadImage("Sprites/mario3-Photoroom.png-Photoroom.png");
  sprite_mario[2] = loadImage("Sprites/mario5-Photoroom.png-Photoroom.png");
  sprite_mario[3] = loadImage("Sprites/mario6-Photoroom.png-Photoroom.png");
  sprite_mario[4] = loadImage("Sprites/mario8-Photoroom.png-Photoroom.png");
  sprite_mario[5] = loadImage("Sprites/mario9-Photoroom.png-Photoroom.png");
  sprite_mario[6] = loadImage("Sprites/mario12-Photoroom.png-Photoroom.png");
  sprite_mario[7] = loadImage("Sprites/mario13-Photoroom.png-Photoroom.png");

  title = loadImage("Sprites/Mario vs Sonic.png");

  ring = loadImage("Sprites/ring-removebg-preview.png");
  star = loadImage("Sprites/star_mario-removebg-preview.png");
  eggman = loadImage("Sprites/eggmanpart1-removebg-preview.png");
  bomb = loadImage("Sprites/mario_bomb-removebg-preview.png");

  // Carrega o som de confirmação
  confirmSound = new SoundFile(this, "sound/sonic confirms.mp3");
  
   // Carregar imagens de vitória
  victoryScreen = loadImage("Sprites/VICTORY.png");
  empateScreen = loadImage("Sprites/DEU-VELHA.png");
  winnerPlayer1 = loadImage("Sprites/Ganhador-Jogador-1.png");
  winnerPlayer2 = loadImage("Sprites/Ganhador-Jogador-2.png");

  // Carregar som de vitória
  victorySound = new SoundFile(this, "sound/song victory.mp3");
  empateSound = new SoundFile(this, "sound/empate.mp3");


  // Definindo as dimensões da estrela e do anel baseadas nas dimensões do Sonic
  dimension_ring = sprite_sonic[0].width * 1.8;
  dimension_star = sprite_sonic[0].width * 1.4;


  textAlign(CENTER, CENTER);
}

void draw() {

    image(backgroundImg, 0, 0, width, height);
    if (++pmario > 7) pmario = 0;
    if (++psonic > 4) psonic = 0;
    delay(sonicDelay); 
    delay(marioDelay); 
    
    // Tela inicial 
    if(tela == 0){
    image(title, 270, 50);
    image(star, 150, 50, dimension_star, dimension_star);
    image(ring, 650, 50, dimension_ring, dimension_ring);
    image(eggman, 650, 400);
    image(bomb, 150, 400, dimension_star, dimension_star);
    image(sprite_sonic[psonic], 530, 120);
    image(sprite_mario[pmario], 260, 110, sprite_mario[pmario].width * dimension_mario, sprite_mario[pmario].height * dimension_mario);
    fill(255);
    textSize(20);
    text("Iniciar Partida [Pressione Enter]", 420,275);
    text("Configuração [Pressione C]", 420,305);
    text("Instruções [Pressione I]", 420,335);
    text("História [Pressione H]", 420, 365);
    text("Creditos [Pressione E]", 420, 395); 
    text("Sair do jogo [Pressione ESC]", 420,425);
    }
    
     if(tela == 3){
        image(victoryScreen, 270, 80, 250, 120);
        int duracao = 500;
        if (t_inicio == 0){
          t_inicio = millis();
        }
        if (ganhador == 1) {
          if(translacao == 0){
            image(winnerPlayer1, 10, 280);
            if(millis() - t_inicio > duracao){
            translacao = 1;
            t_inicio = millis();
            }
          } else if (translacao == 1){
            image(winnerPlayer1, 250, 280);
            if(millis() - t_inicio > duracao){
            translacao = 2;
            t_inicio = millis();
            }
            } else if(translacao == 2){
            image(winnerPlayer1, 500, 280);
            if(millis() - t_inicio > duracao){
            translacao = 0;
            t_inicio = millis();
            }
          }
        } 
        else if (ganhador == 2) {
          if(translacao == 0){
            image(winnerPlayer2, 10, 280);
            if(millis() - t_inicio > duracao){
            translacao = 1;
            t_inicio = millis();
            }
          } else if (translacao == 1){
            image(winnerPlayer2, 250, 280);
            if(millis() - t_inicio > duracao){
            translacao = 2;
            t_inicio = millis();
            }
            } else if(translacao == 2){
            image(winnerPlayer2, 500, 280);
            if(millis() - t_inicio > duracao){
            translacao = 0;
            t_inicio = millis();
            }
          }
          
        } else {
          image(empateScreen, 240, 280);
        }
        println("translacao", translacao);
        
        // Tocar som de vitória ou empate apenas uma vez
        if (!victorySoundPlayed) {
          if (ganhador == 1 ) {
            victorySound.play();
            victorySoundPlayed = true;
            
          } else if  (!empateSoundPlayed) {
            empateSound.play();
            empateSoundPlayed = true;
          }
          
        }
        
        fill(255);
        textSize(20);
        text("Recomeçar jogo [Pressione R]", 400,460);
        text("Tela Menu Inicial [Pressione S]", 400,490);
        text("Configuração [Pressione C]", 400,520);
        text("Sair do jogo [Pressione ESC]", 400,550);
        }
    
    
    // Tela jogo
    if(tela == 1){
      image(title, 280, 10);
      strokeWeight(1);
      fill(180);
      rect(305,180,240,240);
      fill(0);
      strokeWeight(3);
      //linhas que dão o formato do tabuleiro
      line(385,180,385,420);
      line(465,180,465,420);
      line(305,260,545,260);
      line(305,340,545,340);
      // Botões de navegação
      fill(255);
      textSize(20);
      text("Recomeçar jogo [Pressione R]", 420,460);
      text("Tela Menu Inicial [Pressione S]", 420,490);
      text("Configuração [Pressione C]", 420,520);
      text("Sair do jogo [Pressione ESC]", 420,550);
      
      victorySoundPlayed = false;
      empateSoundPlayed = false;
   
     
      // Colocar Imagem da Sprite do jogador no campo do tabuleiro selecionado
      if(tabuleiro[0][0] == 1){
        if(player[0] == 1) image(player1, 325, 205, dimension_star, dimension_star);
        if(player[0] == 2) image(player2, 325, 205, dimension_star, dimension_star);
      }
      
      if(tabuleiro[0][1] == 1){
        if(player[1] == 1) image(player1, 405, 205, dimension_star, dimension_star);
        if(player[1] == 2) image(player2, 405, 205, dimension_star, dimension_star);
      }
      
      if(tabuleiro[0][2] == 1){
        if(player[2] == 1) image(player1, 485, 205, dimension_star, dimension_star);
        if(player[2] == 2) image(player2, 485, 205, dimension_star, dimension_star);
      }
      
      if(tabuleiro[1][0] == 1){
        if(player[3] == 1) image(player1, 325, 285, dimension_star, dimension_star);
        if(player[3] == 2) image(player2, 325, 285, dimension_star, dimension_star);
      }
      
      if(tabuleiro[1][1] == 1){
        if(player[4] == 1) image(player1, 405, 285, dimension_star, dimension_star);
        if(player[4] == 2) image(player2, 405, 285, dimension_star, dimension_star);
      }
      
      if(tabuleiro[1][2] == 1){
        if(player[5] == 1) image(player1, 485, 285, dimension_star, dimension_star);
        if(player[5] == 2) image(player2, 485, 285, dimension_star, dimension_star);
      }
      
      if(tabuleiro[2][0] == 1){
        if(player[6] == 1) image(player1, 325, 365, dimension_star, dimension_star);
        if(player[6] == 2) image(player2, 325, 365, dimension_star, dimension_star);
      }
      
      if(tabuleiro[2][1] == 1){
        if(player[7] == 1) image(player1, 405, 365, dimension_star, dimension_star);
        if(player[7] == 2) image(player2, 405, 365, dimension_star, dimension_star);
      }
      
      if(tabuleiro[2][2] == 1){
        if(player[8] == 1) image(player1, 485, 365, dimension_star, dimension_star);
        if(player[8] == 2) image(player2, 485, 365, dimension_star, dimension_star);
      }
      
       verifica_ganhador();
      if (ganhador != 0 || empate != 0) {
      // Ir para a tela de vitória ou empate
      tela = 3;
      }else tela = 1 ;
      
      // Tempo para escolher jogada
      //Verifica se é a vez do jogador quando ainda não tem vencedor ou empate
      if(turn == 0 && ganhador == 0 && empate == 0) {
       // Verifica nível selecionado para determinar o tempo máximo para realizar jogada
       if(nivel == 'f') timer_restante = 10000;
       if(nivel == 'm') timer_restante = 5000;
       if(nivel == 'd') timer_restante = 2000;
       
       //Verifica contagem de tempo
       int timer_troca = millis() - timer_atual;
       
       // Indicação do tempo restante para realizar jogada. Após esse tempo ou após jogador realizar jogada, é a vez da máquina
       text("Tempo Restante:",650,200);
       text(int(int(timer_restante/1000) - timer_troca/1000), 650, 220);
       // Verifica se já passou do tempo máximo para jogada, após isso é a vez da máquina
       if((millis() - timer_atual) >= timer_restante && tela == 1 ){
         timer_atual = millis();
         turn = 1;
       }      
      }
      
      // Verifica se houve empate
      if(tabuleiro[0][0] == 1 && tabuleiro[0][1] == 1 && tabuleiro[0][2] == 1 && tabuleiro[1][0] == 1 && tabuleiro[1][1] == 1 && tabuleiro[1][2] == 1 && 
      tabuleiro[2][0] == 1 && tabuleiro[2][1] == 1 && tabuleiro[2][2] == 1) empate = 1;
      if(empate ==1){
        tela = 3;
      }
      
      // Jogada automática da máquina. São selecionados aleatoriamente 2 números de 0 a 2. Um para coluna e outro para linha. Se a posição não estiver ocupada pelo tabuleiro, é a posição selecionada pela maquina
      while(turn == 1 && ganhador == 0 && empate == 0){
        // Seleciona numero aleatorio para coluna
         coluna = int(random(0,3));
        // Seleciona numero aleatorio para linha
         linha = int(random(0,3));
        // Verifica se essa posicao está ocupada no tabuleiro. Se sim máquina seleciona essa posicao
         if(tabuleiro[linha][coluna] == 0){
           tabuleiro[linha][coluna] = 1;
           // Calcula da posicao a partir da linha e coluna
           int pos = linha*3 + coluna;
           // Registra numero da maquina no vetor player (Para identificar quem escolheu essa posição no tabuleiro)
           player[pos] = 2;
           // Após registro muda para vez do outro jogador
           if(tabuleiro[linha][coluna] == 1) {
              turn = 0;
           }
         }
      }
            
    }
    
    if(tela == 2){
       // Titulo da tela
       fill(255);
       image(title, 280, 10);
       fill(255);
       textSize(30);
       text("Configuração", 420,220);
       
       // Descrição dos comandos de navegação
       textSize(20);
       text("Tela Menu Inicial [Pressione S]", 420,500);
       text("Iniciar Partida [Pressione ENTER]", 420,530);
       text("Sair do jogo [Pressione ESC]", 420,560);
       
       // Sprites para seleção do player 1
       text("Selecione Sprite player 1", 420,260);
       image(star, 320, 280, dimension_star, dimension_star);
       image(ring, 330+dimension_star, 280, dimension_star, dimension_star);
       image(eggman, 340+(dimension_star*2), 280,dimension_star,dimension_star);
       image(bomb, 350+(dimension_star*3), 280, dimension_star, dimension_star);
       text("Selecione Sprite player 2", 420,340);
        // Sprites para seleção do player 2
       image(star, 320, 360, dimension_star, dimension_star);
       image(ring, 330+dimension_star, 360, dimension_star, dimension_star);
       image(eggman, 340+(dimension_star*2), 360,dimension_star,dimension_star);
       image(bomb, 350+(dimension_star*3), 360, dimension_star, dimension_star);
       
       //Seleção do nível do jogo
       text("Selecione Nível de dificuldade", 420,425);
       text("Facil [F]", 328,455);
       text("Medio [M]", 416,455);
       text("Dificil [D]", 510,455);
       
       //Indica sprite selecionada com retangulo em volta da sprite
       if(sprite1 == 1){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(320,280,41,41);
       }
        if(sprite1 == 2){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(370,280,41,41);
       }
        if(sprite1 == 3){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(420,280,41,41);
       }
        if(sprite1 == 4){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(470,280,41,41);
       }
        if(sprite2 == 1){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(320,360,41,41);
       }
        if(sprite2 == 2){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(370,360,41,41);
       }
        if(sprite2 == 3){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(420,360,41,41);
       }
        if(sprite2 == 4){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(470,360,41,41);
       }
       //Indica nível de dificuldade selecionada com retangulo em volta da sprite
       if(nivel == 'f'){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(290,442,75,26);
       }
       if(nivel == 'm'){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(370,442,90,26);
       }
       
        if(nivel == 'd'){
         stroke(255);
         strokeWeight(3);
         noFill();
         rect(466,442,86,26);
       }

    }
    
    if(tela == 4){
      textSize(30);
      text("Instruções", 420,50);
      textSize(20);
      text("Clique em um dos campos disponíveis do tabuleiro", 400, 200);
      text("Você vencerá quando completar 3 campos na vertinal, na horizontal ou cruzado", 400,230);
      text("Não permita que seu adversário consiga fazer o mesmo", 400,260);
      text("Você terá um tempo para selecionar. Após isso, é a vez do outro jogador", 400, 290);
      
      text("Tela Menu Inicial [Pressione S]", 420,500);
      text("Sair do jogo [Pressione ESC]", 420,530);
    }
   if(tela == 5){
      textSize(30);
      text("História", 420,50);
      textSize(20);
      text("Mario e Sonic decidiram se enfrentar em um Jogo da Velha especial, com símbolos ", 400, 200);
      text("próprios no tabuleiro mágico. Mario colocou seu boné vermelho e Sonic, seu anel dourado.", 400, 230);
      text("A cada jogada, a tensão aumentava, e ambos mostravam suas habilidades estratégicas.", 400, 260);
      text("O tabuleiro se enchia de símbolos, e nenhum dos dois queria ceder.", 400, 290);
      text("Rindo e se divertindo, perceberam que estavam em um empate inevitável.", 400, 320);
      text("O jogo terminou, mas a verdadeira vitória foi a diversão compartilhada.", 400, 350);
      text("Decidiram então correr pelo Reino dos Cogumelos,", 400, 380);
      text("onde suas habilidades únicas poderiam brilhar ainda mais.", 400, 410);
      text("E assim, a amizade e a aventura continuaram, com novos desafios à vista.", 400, 440);
      
      text("Tela Menu Inicial [Pressione S]", 420,500);
      text("Sair do jogo [Pressione ESC]", 420,530);
   }
   
   if(tela == 6){
      textSize(30);
      text("Creditos", 420,50);
      textSize(20);
      text("Anderson Dias Duarte 202202089", 400, 190);
      text("Luan Ornelas de Souza 202110558", 400, 230);
      text("Rafael Cruz Santos 004202001304", 400, 270);
      text("Vinicius dos Santos Roberto 202125149", 400, 310);
      
      text("Tela Menu Inicial [Pressione S]", 420,500);
      text("Sair do jogo [Pressione ESC]", 420,530);
   }
    
}
// Void Evento de click do mouse
void mouseClicked() {
  if (tela == 1) {
    // Verifica se é a vez do jogador 1 (não da máquina)
    if(turn == 0){
       // A partir do click, executa funções position_selected_x e position_selected_y para identificar posição selecionada
       coluna = position_selected_x(mouseX);
       linha = position_selected_y(mouseY);
       // Verifica se posição selecionada não está ocupada
       if(tabuleiro[linha][coluna] == 0){
          tabuleiro[linha][coluna] = 1;
          int pos = linha*3 + coluna;
          player[pos] = 1;
          if(tabuleiro[linha][coluna] == 1) {
            turn = 1;
            timer_atual = millis();
          }
       } 
       // Se posição selecionada já estiver ocupada, é indicada que campos já está preenchido
        else{
        textSize(25);
        fill(0);
        text("Campo já preenchido",425,200);
       }

    }
  } 
  
  // De acordo com sprite selecionada é carregada para sprite do player 1 e do player 2
  if(tela != 1){
    if(tela==2){
     sprite_sel1 = sprite_selection1(mouseX, mouseY);
     sprite_sel2 = sprite_selection2(mouseX, mouseY);
    }
    if(sprite_sel1 == 1 && sprite_sel2 != 1){
       pl1 = star;
     }
     if(sprite_sel1 == 2 && sprite_sel2 != 2){
       pl1 = ring;
     }
     if(sprite_sel1 == 3 && sprite_sel2 != 3){
       pl1 = eggman;
     }
     if(sprite_sel1 == 4 && sprite_sel2 != 4){
       pl1 = bomb;
     }
     
     if(sprite_sel2 == 1 && sprite_sel1 != 1){
       pl2 = star;
     }
     if(sprite_sel2 == 2 && sprite_sel1 != 2){
       pl2 = ring;
     }
     if(sprite_sel2 == 3 && sprite_sel1 != 3){
       pl2 = eggman;
     }
     if(sprite_sel2 == 4 && sprite_sel1 != 4){
       pl2 = bomb;
     }
     victorySoundPlayed = false;
     empateSoundPlayed = false;
  }
  
  if(pl1 != player1 && pl1 != null){
    player1 = pl1;
  }
  if(sprite_sel1 != sprite1 && sprite_sel1 != sprite_sel2){
    sprite1 = sprite_sel1;
  }
  
  if(pl2 != player2 && pl2 != null){
    player2 = pl2;
  }
  if(sprite_sel2 != sprite2 && sprite_sel1 != sprite_sel2){
    sprite2 = sprite_sel2;
  }
}

// Função verifica posição do x após click durante o jogo
int position_selected_x(int x){
  // Verifica se selecionou coluna 0
  if (x > 305 && x < 385){
    c = 0;
  }
  // Verifica se selecionou coluna 1
  if(x > 385 && x < 465){
    c = 1; 
  }
  // Verifica se selecionou coluna 2
  if (x > 465 && x < 545){
    c = 2;
  }
  // Retorna coluna selecionada
  return c;
}
// Função verifica posição do y após click durante o jogo
int position_selected_y(int y){
  // Verifica se selecionou linha 0
  if (y > 180 && y < 260){
    l = 0;
  }
  // Verifica se selecionou coluna 1
  if(y > 260 && y < 340){
    l = 1; 
  }
  // Verifica se selecionou coluna 2
  if (y > 340 && y < 420){
    l = 2;
  }
  // Retorna linha selecionada
  return l;
}

// Função para verificar sprite selecionada do jogador 1
int sprite_selection1(int x, int y){
    // Seleciona Sprite 1
    if(x > 320 && x < 360 && y > 280 && y < 320){
      sprite_sel1 = 1;
    }
    // Seleciona Sprite 2
    if(x > 370 && x < 410 && y > 280 && y < 320){
      sprite_sel1 = 2;
    }
    // Seleciona Sprite 3
    if(x > 420 && x < 460 && y > 280 && y < 320){
      sprite_sel1 = 3;
    }
    // Seleciona Sprite 4
    if(x > 470 && x < 510 && y > 280 && y < 320){
      sprite_sel1 = 4;
    }
    // Retorna Sprites do jogador 1 
    return sprite_sel1;
}
// Função para verificar sprite selecionada do jogador 2
int sprite_selection2(int x, int y){
    // Seleciona Sprite 1
    if(x > 320 && x < 360 && y > 360 && y < 400){
      sprite_sel2 = 1;
    }
    // Seleciona Sprite 2
    if(x > 370 && x < 410 && y > 360 && y < 400){
      sprite_sel2 = 2;
    }
    // Seleciona Sprite 3
    if(x > 420 && x < 460 && y > 360 && y < 400){
      sprite_sel2 = 3;
    }
    // Seleciona Sprite 4
    if(x > 470 && x < 510 && y > 360 && y < 400){
      sprite_sel2 = 4;
    }
    // Retorna Sprites dos jogador 2
    return sprite_sel2;
}

void resetarJogo() {
  // Zerar o tabuleiro
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      tabuleiro[i][j] = 0;
    }
  }
  
  // Resetar informações do vencedor
  ganhador = 0;
  empate = 0;
  victorySoundPlayed = false;
}


// Função Evento após tecla pressionada
void keyPressed(){
  if(keyPressed){
    //Se tecla ENTER Pressionada
      // Toca o som de confirmação ao pressionar as teclas do menu
    if (key == ENTER || key == 'c' || key == 'C' || key == ESC || key == 'i' || key == 'I' || key == 'r' || key == 'R' || key == 'h' || key == 's' || key == 'e') {
      confirmSound.play();
    }
    
    if(key == ENTER){
      // Se tela diferente de 1 - Zera todas posições
      if(tela != 1){
      tabuleiro[0][0] = 0;
      tabuleiro[0][1] = 0;
      tabuleiro[0][2] = 0;
      tabuleiro[1][0] = 0;
      tabuleiro[1][1] = 0;
      tabuleiro[1][2] = 0;
      tabuleiro[2][0] = 0;
      tabuleiro[2][1] = 0;
      tabuleiro[2][2] = 0;
      ganhador = 0;
      empate = 0;
   
      timer_atual = millis();}
      tela = 1;
    }
    // Se tecla C pressionada vai para tela 2 (Tela de configuração)
    if(key == 'c'){
      tela = 2;
    }
    // Se tecla R pressionada Reinicia jogo
    if(key == 'r'){
      tabuleiro[0][0] = 0;
      tabuleiro[0][1] = 0;
      tabuleiro[0][2] = 0;
      tabuleiro[1][0] = 0;
      tabuleiro[1][1] = 0;
      tabuleiro[1][2] = 0;
      tabuleiro[2][0] = 0;
      tabuleiro[2][1] = 0;
      tabuleiro[2][2] = 0;
      timer_atual = millis();   
      player[0] = 0;
      player[1] = 0;
      player[2] = 0;
      player[3] = 0;
      player[4] = 0;
      player[5] = 0;
      player[6] = 0;
      player[7] = 0;
      player[8] = 0;
      tela = 1;
      ganhador = 0;
      empate = 0;
      victorySoundPlayed = false;
      empateSoundPlayed = false;
    }
    if(tela == 2){
      // Se tela 2 (Estiver na tela de configuração - Verifica tecla para nivel de dificuldade do jogo
      if(key == 'f' && nivel != 'f'){
        nivel = 'f';
      }
      if(key == 'm' && nivel != 'm'){
        nivel = 'm';
      }
      if(key == 'd' && nivel != 'd'){
        nivel = 'd';
      }
    }
    if(tela != 3){
       victorySound.stop();   
       empateSound.stop();
    }
    if(tela != 0 && key == 's') tela = 0;
    if(tela == 0 && key == 'i') tela = 4;
    if(tela == 0 && key == 'h') tela = 5;
    if(tela == 0 && key == 'e') tela = 6;
  }
}

// Função verifica vencedor de acordo com essas condições
int verifica_ganhador(){
    if(player[0] == player[1] && player[0] == player[2] && player[0] != 0)
    {
      ganhador = player[0];
    }
  //esquerda vertical
    else if(player[0] == player[3] && player[0] == player[6] && player[0] != 0)
    {
      ganhador = player[0];
      println("esquerda vertical");}
  //diagonal esquerda cima direita baixo
    else if(player[0] == player[4] && player[0] == player[8] && player[0] != 0)
    {
      ganhador = player[0];
      println("diagonal esquerda cima direita baixo");}
  //meio vertical
    else if(player[1] == player[4] && player[1] == player[7] && player[1] != 0)  
    {
      ganhador = player[4];
      println("meio vertical");}
  //direita vertical
    else if(player[2] == player[5] && player[2] == player[8] && player[2] != 0)
    {
      ganhador = player[8];
      println("direita vertical");}
  //meio horizontal
    else if(player[3] == player[4] && player[3] == player[5] && player[3] != 0){
      ganhador = player[4];
      println("meio horizontal");}
  //baixo horizontal
    else if(player[6] == player[7] && player[6] == player[8] && player[6] != 0)
    {
      ganhador = player[8];
      println("baixo horizontal");}
  //diagonal baixo esquerda cima direita
    else if(player[6] == player[4] && player[6] == player[2] && player[6] != 0)
    {
      ganhador = player[4];
      println("diagonal baixo esquerda cima direita");}
  
  // Retorna ganhador do jogo se uma dessas condições for verdadeira
  return ganhador;
  }
  
