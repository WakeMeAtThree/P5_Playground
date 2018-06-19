float x;
float y;
float a;
float b = 300;
float c = 1;
float cspeed =  -0.001;

void setup() {
  size(700, 700);
  background(0);
  strokeWeight(4);
  stroke(255);
}

void draw() {
  translate(width/2, height/2);
  x = b*cos(a);
  y = b*sin(a);
  strokeWeight(abs(sin(a))*20%10);
  stroke(lerpColor(#2d9fda, #e407a8, c));
  point(x, y);
  a+=0.05;
  b+=-0.1;
  c+=cspeed;
  if (c<0 || c > 1) cspeed *= -1;
}