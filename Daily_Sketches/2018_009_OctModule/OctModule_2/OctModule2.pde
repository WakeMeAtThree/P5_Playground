boolean displayPoints = true;
int div = 3;
float scl;

void setup() {
  size(400, 400);
  background(0);
  scl = width/div;
}

void draw() {
  background(0);
  module(width/2,height/2,scl);
}
void module(float x, float y, float scl) {
  pushMatrix();

  translate(x, y);
  if (displayPoints) {
    strokeWeight(4);
    stroke(255);
    //Origin
    point(0, 0);

    //Inner Square
    point(0, -0.414214*scl);
    point(0, 0.414214*scl);
    point(-0.414214*scl, 0);
    point(0.414214*scl, 0);

    //Outer square
    point(0, -1*scl);
    point(0, 1*scl);
    point(1*scl, 0);
    point(-1*scl, 0);
  }
  
  edge(0, scl, true);
  edge(90, scl, true);
  edge(180, scl, true);
  edge(270, scl, true);

  edge(45, scl, false);
  edge(135, scl, false);
  edge(225, scl, false);
  edge(315, scl, false);
  popMatrix();
}

void edge(float angle, float scl, boolean move) {
  pushMatrix();
  rotate(radians(angle));
  if (move) translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();
}


void elline(float x, float y, float r) {
  pushMatrix();
  noStroke();
  fill(lerpColor(#0CFFD2, #D60043, map(mouseX, 0, width, 0, 1)));
  translate(x, y);
  ellipse(0, 0, r, r*0.1);
  popMatrix();
}