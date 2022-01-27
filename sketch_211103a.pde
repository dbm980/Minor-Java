import java.lang.Math;


void setup(){
  size(1920,1080);
  background(255,255,255);
  
  //giving initial values to the position array
  for (int i = 0; i < xposLog.length; i++){
    xposLog[i]= 960;
  }
  for (int i = 0; i < yposLog.length; i++){
    yposLog[i]= 540;
  }
}

//initialize variabls
int xpos = 960;
int ypos = 540;
float xspeed = 0;
float yspeed = 0;
double angle;

float tempxdist;

//arrays to store the 
int[] xposLog = new int[20];
int[] yposLog = new int[20];

void draw(){
  background(255,255,255);
  
  //changes the x value so that it is never 0, because it is used as a denominator and dividing by 0 breaks it
  tempxdist = (float)mouseX-(float)xpos;
  if(tempxdist == 0){
    tempxdist = 0.0001;
  }
  
  //calculates distance from mouse to first circle
  double distance = Math.sqrt(Math.pow(Math.abs(mouseX-xpos),2)+Math.pow(Math.abs(mouseY-ypos),2));
  
  //calculating angle based on ratios between x distance and y distance. Annoyingly complicated
  if((float)mouseX-(float)xpos < 0){
    angle = PI-Math.atan(((float)mouseY-(float)ypos)/tempxdist);
  }else if ((float)mouseY-(float)ypos < 0) {
    angle = -Math.atan(((float)mouseY-(float)ypos)/tempxdist);
  } else {
    angle = TWO_PI-Math.atan(((float)mouseY-(float)ypos)/tempxdist);
  }
  
  //adjust speed (acceleration). If statement to make 
  if(distance>20){
    xspeed += (cos((float)angle)*500/((float)distance))/3;
    yspeed += (-sin((float)angle)*500/((float)distance))/3;
  } else {
    xspeed += (cos((float)angle)*3);
    yspeed += (-sin((float)angle)*3);
  
  }
  
  
  
  
  //draws the initial circle
  noStroke();
  fill(255,50,50,20);
  ellipse(xpos,ypos,30,30);
  stroke(0,0,0);
  noFill();
  ellipse(xpos,ypos,20,20);
  
  //actually moves it
  xpos+=xspeed;
  ypos+=yspeed;
  
  //bumps the positions down the line to the next ellipse
  for (int i = xposLog.length - 1; i >= 1; i--){
    xposLog[i]= xposLog[i-1];
  }
  for (int i = yposLog.length - 1; i >= 1; i--){
    yposLog[i]= yposLog[i-1];
  }
  xposLog[0] = xpos;
  yposLog[0] = ypos;
  
  //draws the circles
  for (int i = 0; i < xposLog.length; i++){
    noStroke();
    fill(255,50,50,20);
    ellipse(xposLog[i],yposLog[i],30,30);
    stroke(0,0,0);
    noFill();
    ellipse(xposLog[i],yposLog[i],20,20);
  }
  
}
//resets the position and velocity
void mousePressed(){
  background(255,255,255);
  xspeed = 0;
  yspeed = 0;
  xpos = mouseX;
  ypos = mouseY;
}