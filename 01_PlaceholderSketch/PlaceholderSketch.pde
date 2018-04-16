// This is just a simple sketch which was written as a refresher
// to using 2D transformations

float a;
float b;

void setup()
{
  size(500, 500);
  rectMode(CENTER);
  colorMode(RGB,1,1,1,1);
}

void draw()
{
  background(abs(sin(a)),0.1,0.1);
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j<13; j++) {
      
      square1(31+89*i, 18+37*j);
    }
  }
  for(int i = 0; i < 5; i++){
    for(int j = 0; j < 6; j++){
      
      square2(76.1324+90.1*i,52.9105+90.1*j);
    }
  }
  
  a += 0.01;
  b -= 0.01;
}

void square1(float x, float y)
{
  if(frameCount%100==0) fill(random(1),0.4,0.4);
  
  pushMatrix();
    translate(x, y);
    rotate(a);
    rect(0, 0, 21.7, 21.7);
    rectMode(CENTER);
  popMatrix();
}

void square2(float x, float y)
{
  if(frameCount%100==0) fill(0.1,random(1),0.1);
  pushMatrix();
    noStroke();
    translate(x, y);
    rotate(b);
    rect(0, 0, 54.319, 54.319);
    rectMode(CENTER);
  popMatrix();
}