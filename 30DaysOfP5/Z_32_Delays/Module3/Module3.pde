boolean displayPoints = true;
int div = 1;
float scl, a;

void setup() {
  size(500, 500);
  background(0);
  scl = width/10;
}

void draw() {
  //background(0);
  pushStyle();
  fill(0,20);
  rect(0,0,width,height);
  popStyle();
  translate(width/2, height/2);

  //module(0, 0, scl, sin(a));
  module2(0, 0, scl, sin(a));

  a+=0.05;
  //saveFrame("output/animation-###.png");
}

void module2(float x, float y, float scl, float param) {
  pushMatrix();
  translate(x, y);
  if (displayPoints) {
    strokeWeight(4);
    stroke(255);
    //Origin
    point(0, 0);

    //Inner Hex
    point(1.685452*scl, 0.973096*scl);
    point(1.685452*scl, -0.973096*scl);
    point(0.0, -1.946192*scl);
    point(-1.685452*scl, -0.973096*scl);
    point(-1.685452*scl, 0.973096*scl);
    point(0.0*scl, 1.946192*scl);

    ////Outer 12gon
    point(-4.193461*scl, 0.0);
    point(-3.631644*scl, -2.096731*scl);
    point(-2.096731*scl, -3.631644*scl);
    point(0.0, -4.193461*scl);
    point(2.096731*scl, -3.631644*scl);
    point(3.631644*scl, -2.096731*scl);
    point(4.193461*scl, 0.0);
    point(3.684617*scl, 2.002178*scl);
    point(2.096731*scl, 3.631644*scl);
    point(0.0, 4.193461*scl);
    point(-2.096731*scl, 3.631644*scl);
    point(-3.631644*scl, 2.096731*scl);
  }
  float angle = 360/12;
  boolean even = false;
  for (float i = 0.0; i <= 360; i+=angle) {
    if (even) edge2(i, scl, true, false, param);
    if (!even) {


      edge2(i, scl, false, true, 1-param);

    }
    even = !even;
  }
  popMatrix();
}

void module(float x, float y, float scl, float param) {
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

  edge(0, scl, true, false, param);
  edge(90, scl, true, false, param);
  edge(180, scl, true, false, param);
  edge(270, scl, true, false, param);

  edge(45, scl, false, true, param);
  edge(135, scl, false, true, param);
  edge(225, scl, false, true, param);
  edge(315, scl, false, true, param);
  popMatrix();
}

void edge(float angle, float scl, boolean move, boolean mirror, float param) {
  pushMatrix();
  rotate(radians(angle));
  if (mirror) rotate(map(param, -1, 1, 0, PI/2));
  if (move) translate(0, map(param, -1, 1, 0, -0.586*scl));

  elline(0, scl*1, 0.828*scl, param);
  popMatrix();
}

void edge2(float angle, float scl, boolean move, boolean mirror, float param) {
  pushMatrix();

  rotate(radians(angle));

  

  if (mirror) rotate(map(param+PI, -1, 1, -0.78, PI/2));
  translate(0.0, 158.6);
  if (move) translate(0, map(param, -1, 1, -112, 3));

  elline(0, scl*1.0, 2.247*scl, param);
  popMatrix();
}


void elline(float x, float y, float r, float param) {
  pushMatrix();
  noStroke();
  fill(lerpColor(#0793bb, #f7074b, map(param, -1, 1, 0, 1)));
  translate(x, y);
  ellipse(0, 0, r, r*0.1);
  popMatrix();
}
