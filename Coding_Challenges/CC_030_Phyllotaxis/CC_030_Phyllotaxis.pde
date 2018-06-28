int n = 0;
float c = 10;
void setup(){
  size(400,400);
  
  colorMode(HSB,360,360,360);
  background(0);
  //angleMode(DEGREES);
  
}

void draw(){
  translate(width/2,height/2);
  
  float a = n*radians(137.5);
  float r = c * sqrt(n);
  float x = r*cos(a);
  float y = r*sin(a);
  fill(map(sin(a),-1,1,10,40),360,360,180);
  noStroke();
  ellipse(x,y,40,30);
  
  n++;
  
}