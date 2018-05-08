int n = 0;
int nspeed = 1;
float c = 10;
void setup(){
  size(400,400);
  blendMode(DIFFERENCE);
  background(0);
  //angleMode(DEGREES);
  
}

void draw(){

  
  translate(width/2,height/2);
  
  float a = n*radians(23);
  float r = c * sqrt(n);
  float x = r*cos(a);
  float y = r*sin(a);
  fill(255);
  noStroke();
  ellipse(x,y,25,25);
  
  n+=nspeed;
  if(n<0 || n > 830) nspeed *= -1;
  if(mousePressed) println(n);
  
}