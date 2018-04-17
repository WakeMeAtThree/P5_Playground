boolean displayPoints = false;
int div = 25;
float scl;

void setup() {
  size(1000, 1000);
  background(0);
  scl = width/div;
}

void draw() {
  background(0);
  rotate(PI/4);
  for (int x = -div; x < div; x++) {
    for (int y = -div; y < div; y++) {
      module(2*scl*x, 2*scl*y, scl);
    }
  }
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

  edge(0, scl, true,false,0.586);
  edge(90, scl, true,false,0.586);
  edge(180, scl, true,false,0.586);
  edge(270, scl, true,false,0.586);

  edge(45, scl, true,false,0.707);
  edge(135, scl, true,false,0.707);
  edge(225, scl, true,false,0.707);
  edge(315, scl, true,false,0.707);
  popMatrix();
}

void edge(float angle, float scl, boolean move, boolean scaled, float param) {
  pushMatrix();
  rotate(radians(angle));
  //if(scaled) scale(map(mouseX, 0, width, 1, 0));
  if (move) translate(0, map(mouseX, 0, width, 0, -param*scl));
  
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