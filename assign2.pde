final int GAME_START    = 0;
final int GAME_RUN      = 1;
final int GAME_LOSE     = 2;

PImage enemy ;
PImage fighter ;
PImage hp ;
PImage treasure ;
PImage bg1;
PImage bg2;
PImage end1;
PImage end2;
PImage enemy1;
PImage gainbomb;
PImage start1;
PImage start2;
float enemyX, enemyY; 
float treasureX, treasureY;
float fighterX, fighterY;
float speedX,speedY;

int width, height;
int x1, x2;

float x;
float y;
float speed = 5;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

final int TOTAL_LIFE = 5;
int life;
float hpX ;

int gameState;

void setup () {
  width = 640;
  height = 480;
  size(640,480);
  x1 = 0;
  x2 = -width;
   x = width/2;
   y = height/2;
  //  load images
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  end1 = loadImage("img/end1.png");;
  end2 = loadImage("img/end2.png");;
  enemy1 = loadImage("img/Moocs-element-enemy1.png");;
  gainbomb = loadImage("img/Moocs-element-gainbomb.png");;
  start1 = loadImage("img/start1.png");;
  start2 = loadImage("img/start2.png");;
  
  image(enemy,enemyX,enemyY);
  enemyY = floor(random(60,420));
  speedX = floor(random(3,6));
  speedY = floor(random(3,6));
  image(treasure,treasureX,treasureY);
  treasureX = floor(random(60,580));
  treasureY = floor(random(60,420));
  hpX = 206; 
  life = TOTAL_LIFE;
  gameState = GAME_START;
}

void draw() {
  switch (gameState){
    case GAME_START:
    image(start2, 0, 0 );
    //mouse action
    if (444 > mouseX && mouseX > 213 &&  420 > mouseY && mouseY > 381){ 
    if (mousePressed){
          // click
          gameState = GAME_RUN;
        }else{
          // hover
          noStroke();
          image(start1, x1, 0 );
        }
    }
      break;
      
    case GAME_RUN:
    // background
    image( bg2, x1, 0 );
    image( bg1, x2, 0 );
    if( x1 == width )
      x1 = -width;
    else
      x1 += 2;
 
    if( x2 == width )
      x2 = -width;
    else
    x2 += 2;
      // fighter
      image(fighter, x, y);
      fighterX = mouseX;
      // enemy 
      image(enemy, enemyX, enemyY);
      //boundary detection
      if (enemyX > width){
        enemyX = 0; 
        }
  
      if (enemyY > height){
        enemyY = floor(random(0,480));
        }
      enemyX += speedX;
      enemyY += speedY;
      enemyX %= 640;
      // hp
      fill(#ff0000);
      rectMode(CORNERS);
      rect(10,0,hpX,30);
      image(hp,0,0);
      // treasure
      image(treasure,treasureX,treasureY);
      // move fighter
       if (upPressed) {
          y -= speed;
        }
       if (downPressed) {
          y += speed;
        }
        if (leftPressed) {
          x -= speed;
        }
        if (rightPressed) {
          x += speed;
        }
     //move fighter(boundary detection)
        if (x > width-50){
          x = width-50; 
        }
        if (x < 0){
           x = 0; 
        }
  
        if (y > height-50){
           y = height-50;
        }
        if (y < 0){
           y = 0;
        }
      //move enemy
      if (enemyY >= fighterY ){
        enemyX ++; 
        enemyY -= 2;
      }else{
        if (enemyY <= fighterY ){
        enemyX ++;
        enemyY += 2;
      }
      //hit detection(treasure)
     while (treasureX == fighterX && treasureY == fighterY ){
       hpX =hpX + 20.6 ;
       println("life: " + hpX);
      }
      //hit detection(enemy)
     if(enemyX >= fighterX){
     while (enemyX == fighterX && enemyY == fighterY){
       hpX= hpX - 41.2 ;
       println("life: " + hpX);
     }
       if(hpX<=0){
         gameState = GAME_LOSE;
       }
      }     
    }
      break;
  

    case GAME_LOSE:
      image(end2, x1, 0 );
    //mouse action
    if (426 > mouseX && mouseX > 213 && 352 >mouseY && mouseY > 313   ){ 
    if (mousePressed){
          // click
          gameState = GAME_RUN;
        }else{
          // hover
          noStroke();
          image(end1, x1, 0 );
        }
      }
      break;
      }
  }

void keyPressed(){
  if (key == CODED) {  // detect special keys
    switch (keyCode) {  
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}
  

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
