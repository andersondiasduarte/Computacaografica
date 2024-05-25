PImage[] sprite_sonic = new PImage[5];
PImage[] sprite_mario = new PImage[8];
PImage title;
PImage backgroundImg;
PImage ring;
PImage star;
PImage eggman;
PImage bomb;
int psonic;
int pmario;
float dimension_mario;
float dimension_ring;
float dimension_star;

int sonicDelay = 200; 
int marioDelay = 5;

class Button {
  float x, y;
  float w, h;
  float originalW, originalH;
  color c, hoverColor;
  String label;
  boolean isHovering = false;
  PFont font;

  Button(float x, float y, float w, float h, color c, color hoverColor, String label) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.originalW = w;
    this.originalH = h;
    this.c = c;
    this.hoverColor = hoverColor;
    this.label = label;
  }
  void display() {
    if (isHovering) {
      fill(bgColor);
      w = originalW * 1.05;
      h = originalH * 1.05;
    } else {
      fill(bgColor);
      w = originalW;
      h = originalH;
    }
    rect(x, y, w, h);
    fill(0);

    text(label, x + w/2, y + h/2);
  }

  void update() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      isHovering = true;
    } else {
      isHovering = false;
    }
  }

  boolean isClicked() {
    return isHovering && mousePressed;
  }
}

Button[] buttons;
color bgColor;
void setup() {
  size(800, 600);
  dimension_mario = 1.3;
  backgroundImg = loadImage("background.jpeg");
  sprite_sonic[0] = loadImage("C:/Documentos/Jogo da velha/Sprites/sonic_pose0-removebg-preview.png");
  sprite_sonic[1] = loadImage("C:/Documentos/Jogo da velha/Sprites/sonic_pose1-removebg-preview.png");
  sprite_sonic[2] = loadImage("C:/Documentos/Jogo da velha/Sprites/sonic_pose2-removebg-preview.png");
  sprite_sonic[3] = loadImage("C:/Documentos/Jogo da velha/Sprites/sonic_pose3-removebg-preview.png");
  sprite_sonic[4] = loadImage("C:/Documentos/Jogo da velha/Sprites/sonic_pose4-removebg-preview.png");
  sprite_mario[0] = loadImage("C:/Documentos/Jogo da velha/Sprites/mario0-Photoroom.png-Photoroom.png");
  sprite_mario[1] = loadImage("C:/Documentos/Jogo da velha/Sprites/mario1-Photoroom.png-Photoroom.png");
  sprite_mario[2] = loadImage("C:/Documentos/Jogo da velha/Sprites/mario2-Photoroom.png-Photoroom.png");
  sprite_mario[3] = loadImage("C:/Documentos/Jogo da velha/Sprites/mario3-Photoroom.png-Photoroom.png");
  sprite_mario[4] = loadImage("C:/Documentos/Jogo da velha/Sprites/mario5-Photoroom.png-Photoroom.png");
  sprite_mario[5] = loadImage("C:/Documentos/Jogo da velha/Sprites/mario6-Photoroom.png-Photoroom.png");
  sprite_mario[6] = loadImage("C:/Documentos/Jogo da velha/Sprites/mario8-Photoroom.png-Photoroom.png");
  sprite_mario[7] = loadImage("C:/Documentos/Jogo da velha/Sprites/mario9-Photoroom.png-Photoroom.png");

  title = loadImage("C:/Documentos/Jogo da velha/Sprites/Mario vs Sonic.png");

 // ring = loadImage("C:Documentos/Jogo da velha/Sprites/ring-removebg-preview.png");
 // star = loadImage("C:Documentos/Jogo da velha/Sprites/star_mario-removebg-preview.png");
 // eggman = loadImage("C:Documentos/Jogo da velha/Sprites/eggmanpart1-removebg-preview.png");
 // bomb = loadImage("C:Documentos/Jogo da velha/Sprites/mario_bomb-removebg-preview.png");


  // Definindo as dimensões da estrela e do anel baseadas nas dimensões do Sonic
  dimension_ring = sprite_sonic[0].width * 1.8;
  dimension_star = sprite_sonic[0].width * 1.4;


  textAlign(CENTER, CENTER);


  buttons = new Button[3];
  buttons[0] = new Button(50, 50, 100, 50, color(255, 0, 0), color(255, 100, 100), "Fácil");
  buttons[1] = new Button(50, 150, 100, 50, color(0, 255, 0), color(100, 255, 100), "Médio");
  buttons[2] = new Button(50, 250, 100, 50, color(0, 0, 255), color(100, 100, 255), "Difícil");

  bgColor = color(255);
}

void draw() {
    image(backgroundImg, 0, 0, width, height);
    image(title, 250, 50);
    /*image(star, 150, 50, dimension_star, dimension_star);
    image(ring, 650, 50, dimension_ring, dimension_ring);
    image(eggman, 650, 400);
    image(bomb, 150, 400, dimension_star, dimension_star);*/
    image(sprite_sonic[psonic], 500, 120);
    image(sprite_mario[pmario], 260, 110, sprite_mario[pmario].width * dimension_mario, sprite_mario[pmario].height * dimension_mario);

    if (++pmario > 7) pmario = 0;
    if (++psonic > 4) psonic = 0;

    delay(sonicDelay); 
    delay(marioDelay); 


  for (Button b : buttons) {
    b.update();
    b.display();
    if (b.isClicked()) {
      bgColor = b.c;
    }
  }
}
