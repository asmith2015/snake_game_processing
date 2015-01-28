/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/106774*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
snake test;
food food1;
int highScore;

void setup(){
  size(1000, 600);
  frameRate(40);  //increased speed
  test = new snake();
  food1 = new food();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  
  highScore = 0;
}



void draw(){
  background(209, 246, 252); //chnage background color to light blue
  drawScoreboard();
  
  test.move();
  test.display();
  food1.display();
  
  
  if( dist(food1.xpos, food1.ypos, test.xpos.get(0), test.ypos.get(0)) < test.sidelen ){
    food1.reset();
    test.addLink();
  }
  
  if(test.len > highScore){
    highScore= test.len;
  }
}


void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      test.dir = "left";
    }
    if(keyCode == RIGHT){
      test.dir = "right";
    }
    if(keyCode == UP){
      test.dir = "up";
    }
    if(keyCode == DOWN){
      test.dir = "down";
    }
  }
}


void drawScoreboard(){
  // All of the scode for code and title
  
  fill(252, 251, 195); //chnage color to yellow
  textSize(65);
  text( "Snake Game", width/2, 80);
  fill(252, 251, 195); //chnage color to yellow
  textSize(20);
  text( "By: Allison Smith", width/2, 140); //change to my name
  
  
  // draw scoreboard
  stroke(211, 255, 173); //chnage to light green
  fill(255, 126, 195); //chnange to pink
  rect(90, 70, 160, 80);
  fill(252, 251, 209); //chnage to light yellow
  textSize(17);
  text( "Score: " + test.len, 70, 50);
  
  fill(252, 251, 209); //change to light yellow
  textSize(17);
  text( "High Score: " + highScore, 70, 70);
}

class food{
  
  // define varibles
  float xpos, ypos;
  
  
  
  //constructor
  food(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
  }
  
  
  // functions
 void display(){
   
   fill(0,188,32);
   rect(xpos, ypos,17,17);
 }
 
 
 void reset(){
    xpos = random(100, width - 100);
    ypos = random(100, height - 100);
 }   
}

class snake{
  
  //define varibles
  int len;
  float sidelen;
  String dir; 
  ArrayList <Float> xpos, ypos;
  
  // constructor
  snake(){
    len = 1;
    sidelen = 17;
    dir = "right";
    xpos = new ArrayList();
    ypos = new ArrayList();
    xpos.add( random(width) );
    ypos.add( random(height) );
  }
  
  // functions
  
  
  void move(){
   for(int i = len - 1; i > 0; i = i -1 ){
    xpos.set(i, xpos.get(i - 1));
    ypos.set(i, ypos.get(i - 1));  
   } 
   if(dir == "left"){
     xpos.set(0, xpos.get(0) - sidelen);
   }
   if(dir == "right"){
     xpos.set(0, xpos.get(0) + sidelen);
   }
   
   if(dir == "up"){
     ypos.set(0, ypos.get(0) - sidelen);
  
   }
   
   if(dir == "down"){
     ypos.set(0, ypos.get(0) + sidelen);
   }
   xpos.set(0, (xpos.get(0) + width) % width);
   ypos.set(0, (ypos.get(0) + height) % height);
   
    // check if hit itself and if so cut off the tail
    if( checkHit() == true){
      len = 1;
      float xtemp = xpos.get(0);
      float ytemp = ypos.get(0);
      xpos.clear();
      ypos.clear();
      xpos.add(xtemp);
      ypos.add(ytemp);
    }
  }
  
  
  
  void display(){
    for(int i = 0; i <len; i++){
      stroke(179, 140, 198);
      fill(247, 11, 2, map(i-1, 0, len-1, 250, 50));  //change color of snake to red
      rect(xpos.get(i), ypos.get(i), sidelen, sidelen); //change to what's being eaten to a square
    }  
  }
  
  
  void addLink(){
    xpos.add( xpos.get(len-1) + sidelen);
    ypos.add( ypos.get(len-1) + sidelen);
    len++;
  }
  
   boolean checkHit(){
    for(int i = 1; i < len; i++){
     if( dist(xpos.get(0), ypos.get(0), xpos.get(i), ypos.get(i)) < sidelen){
       return true;
     } 
    } 
    return false;
   } 
}
