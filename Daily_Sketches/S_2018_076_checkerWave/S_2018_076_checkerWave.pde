int div = 10;
float a;
boolean toggle=true;
float spacing;
void setup() {
  size(400, 400);
  rectMode(CENTER);
  noStroke();
  spacing = width*1.0/div;
  
}

void draw() {
  background(toggle?color(255):color(255,0,0));

  for (int i = -2; i < div+1; i++) {
    for (int j = -2; j < div+1; j++) {
      float param = 1.0*(i+j)/(div);
      if (i % 2 == 0) {
        if (j % 2 != 0) display(i*spacing, j*spacing, spacing,a+param);
      } else {
        if (j % 2 == 0) display(i*spacing, j*spacing, spacing,a+param);
      }
    }
  }

  if (a >= PI/2) {
    //toggle = !toggle;
    //a = 0;
  }
  a += 0.01;
}

void display(float x, float y, float spacing, float a) {

  pushMatrix();
  if (!toggle) {
    //translate(spacing,0);
  }
  fill(toggle?color(255,0,0):255);
  translate(x, y);
  rotate(lerp(0,PI/4,map(cs(a),-1,1,0,1)));
  rect(0, 0, spacing, spacing);
  popMatrix();
}

void checkerFill(int i, int j) {
  if (i % 2 == 0) {
    if (j % 2 == 0) fill(0);
    if (j % 2 != 0) fill(255);
  } else {
    if (j % 2 == 0) fill(255);
    if (j % 2 != 0) fill(0);
  }
}
