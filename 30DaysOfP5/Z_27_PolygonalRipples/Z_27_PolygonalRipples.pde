float ar, r, a, spacing;

void setup() {
  size(400, 400);
  background(0);
  fill(255);
  blendMode(DIFFERENCE);
  noStroke();
  r = 10;
  ar = 10;
}
void draw() {

  spacing = map(mouseX, 0, width, 10, 100);
  r = 100;
  if (mousePressed) ar = map(mouseX, 0, width, 10, 100);
  background(0);
  strokeWeight(2);

  for (int i = -10; i < 40; i++) {
    for (int j = -10; j< 40; j++) {
      float param = 1.0*(i+j)/40;
      float x = r*cos(a+param*param);
      float y = r*sin(a+param*param);
      resetMatrix();

      if (j%2==0) {
        translate(i*spacing, 
          j*spacing);

        rotate(a+param*param);
        //ellipse(x,y, ar, ar);
        //rect(x, y, ar, ar);
        polygon(x, y, ar, 3);
      } else {
        translate(i*spacing+spacing/2, 
          j*spacing);
        rotate(a+param*param);
        //ellipse(x,y, ar, ar);
        //rect(x, y, ar, ar);
        polygon(x, y, ar, 3);
      }
    }
  }
  a += 0.005;
}


// Polygon function taken from processing examples
void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
