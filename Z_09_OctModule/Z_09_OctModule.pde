int scl = 125;

void setup() {
  size(400, 400);
  background(0);
}

void draw() {
  background(0);
  translate(width/2, height/2);
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

  pushMatrix();
  rotate(radians(0));
  translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();

  pushMatrix();
  rotate(radians(90));
  translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();

  pushMatrix();
  rotate(radians(180));
  translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();

  pushMatrix();
  rotate(radians(270));
  translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();

  //
  pushMatrix();
  rotate(radians(45));
  //translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();

  pushMatrix();
  rotate(radians(135));
  //translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();
  
  pushMatrix();
  rotate(radians(225));
  //translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();
  
  pushMatrix();
  rotate(radians(315));
  //translate(0, map(mouseX, 0, width, 0, -0.586*scl));
  elline(0, scl*1, 0.828*scl);
  popMatrix();
  
  //saveFrame("animation/frame####.png");
}

void elline(float x, float y, float r) {
  pushMatrix();
  noStroke();
  fill(lerpColor(#0CFFD2, #D60043, map(mouseX,0,width,0,1)));
  translate(x, y);
  ellipse(0, 0, r, r*0.1);
  popMatrix();
}