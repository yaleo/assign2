PImage fighter,imgBg1,imgBg2,imgHp,imgTr,imgEn,
       imgSt1,imgSt2,imgEn1,imgEn2;
       
final int GAME_START = 0;
final int GAME_PLAYING = 1;
final int GAME_WIN = 2;
final int GAME_LOSE = 3;
int gamestate ;

int trX,trY,hpWidth,enSpeedx,enY,bg1X,bg2X;

int fighterX=540,fighterY=240;
int speed=5;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int airplaneHit = 0;
int treasureHit = 0;

void setup () {
  size(640, 480);
  gamestate = 0 ;
  hpWidth=40;
  fighter=loadImage("img/fighter.png");
  imgBg1=loadImage("img/bg1.png");
  imgBg2=loadImage("img/bg2.png");
  imgHp=loadImage("img/hp.png");
  imgTr=loadImage("img/treasure.png");
  imgEn=loadImage("img/enemy.png");
  imgSt1=loadImage("img/start1.png");
  imgSt2=loadImage("img/start2.png");
  imgEn1=loadImage("img/end1.png");
  imgEn2=loadImage("img/end2.png");
  trX=floor(random(1,500));
  trY=floor(random(60,400));
  enSpeedx=floor(random(-20,0));
  enY=floor(random(30,400));
  bg1X=0;
  bg2X=-640;
}

void draw() {
  //state machine
  switch(gamestate){
    case GAME_START:
    if(mouseX>204 && mouseX<456 && mouseY>376 && mouseY<417){
      if(mousePressed){
      image(imgSt1,0,0);
      gamestate = GAME_PLAYING ;
      }
      }else{
      image(imgSt2,0,0);
    }
    break;
    
    case GAME_PLAYING:
    image(imgBg1,bg1X,0);
    image(imgBg2,bg2X,0);
   if (bg1X>width){
    bg1X=-640;
    }else{
    bg1X+=2;
    }
    if(bg2X>width){
    bg2X=-640;
    }else{
    bg2X+=2;
    }
    
  //fighter 
  image(fighter,fighterX,fighterY);
    if(upPressed){
    fighterY-=speed;
    }
    if(downPressed){
    fighterY+=speed;
    }
    if(leftPressed){
    fighterX-=speed;
    }
    if(rightPressed){
    fighterX+=speed;
    }
    if(fighterX>590){
      fighterX=590;
    }
    if(fighterX<0){
      fighterX=0;
    }
    if(fighterY>430){
      fighterY=430;
    }
    if(fighterY<0){
      fighterY=0;
    }
    
  //hp
  fill(255,0,0);
  rect(25,20,hpWidth,20);
  image(imgHp,20,20);
  
  //treasure
  image(imgTr,trX,trY);
  if(fighterX == trX){
    treasureHit+=1;
    trX=floor(random(1,500));
    trY=floor(random(30,400));
    hpWidth=hpWidth+treasureHit*10;
  }
  if(hpWidth>=100){
    hpWidth=100;
  }
  enSpeedx+=3;
  enSpeedx%=640;
  
  //enemy
  image(imgEn,enSpeedx,enY);
  if(fighterX == enSpeedx){
    enSpeedx=-20;
    enY=floor(random(30,400));
    airplaneHit+=1;
    hpWidth=hpWidth-airplaneHit*20;
    
  }
  if(hpWidth<=0){
      gamestate = GAME_LOSE ;
    }
  break;
  
  case GAME_LOSE:
  if(mouseX>204 && mouseX<440 && mouseY>307 && mouseY<350){
      if(mousePressed){
      image(imgEn1,0,0);
      gamestate = GAME_PLAYING ;
      }
      }else{
      image(imgEn2,0,0);
    }
    break;
}
}

void keyPressed(){
  if (key==CODED){
    switch(keyCode){
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

void keyReleased(){
    if (key==CODED){
    switch(keyCode){
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
