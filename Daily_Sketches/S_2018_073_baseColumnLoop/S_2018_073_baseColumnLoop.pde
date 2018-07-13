float a;
void setup() {
  size(400, 400);
  blendMode(EXCLUSION);
  rectMode(CORNERS);
  noStroke();
}

void draw() {
  background(0);
  translate(width/2, height/2);
  translate(0, lerp(0, 65, a%1.0));
  fill(255);
  Cmodule(0,0,a);
  Cmodule(45,25,pow(a%1.0,2));
  Cmodule(100,50,a);
  Cmodule(-45,25,pow(a%1.0,2));
  Cmodule(-100,90,a);
  Cmodule(-35,25,a);
  a+=0.02;
}

void Cmodule(float x, float y,float a) {
  pushMatrix();
  translate(x, y);
  Dmodule(0, -65,a);
  module(0, 0);
  module(0, 65);
  module(0, 65*2);
  module(0, 65*3);
  popMatrix();
}

void Dmodule(float x, float y,float a) {
  /* Dynamic module */

  pushMatrix();
  translate(x, y);
  //Base
  rect(-50, 0, lerp(-50, 50, smoothstep(0.3, 0.5, a%1.0)), 15);
  //Column
  rect(-50, 0, -40, lerp(0, -50, smoothstep(0.6, 0.9, a%1.0)));
  rect(40, 0, 50, lerp(0, -50, smoothstep(0.6, 0.9, a%1.0)));
  popMatrix();
}

void module(float x, float y) {
  /* Static Module */
  pushMatrix();
  translate(x, y);
  //Base
  rect(-50, 0, 50, 15);
  //Column
  rect(-50, 0, -40, -50);
  rect(40, 0, 50, -50);
  popMatrix();
}
