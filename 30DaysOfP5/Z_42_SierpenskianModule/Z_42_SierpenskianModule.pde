float a, spacing, scl;

void setup() {
  size(400, 400);
  background(255);
  //blendMode(DIFFERENCE);
  spacing = 1.732;
  scl = 50;
}

void draw() {
  background(255);
  //Move to origin
  //translate(width/2, height/2);
  scale(0.75);

  //Create triangle
  for (int i = -10; i < 10; i++) {
    for (int j = -10; j < 10; j++) {
      float param = 1.0*(i+j)/10;
      if (j % 2 == 0) {
        module(i*1.732*scl, j*1.5*scl, scl, cs(a+param));
      } else {
        module(i*1.732*scl-(1.732*scl/2), j*1.5*scl, scl,cs(a+param));
      }
    }
  }
if(mousePressed) println(mouseX,mouseY);
  for (int i = -10; i < 10; i++) {
    for (int j = -10; j < 10; j++) {
      float param = 1.0*(i+j)/10;
      if (j % 2 == 0) {
        module2(i*1.732*scl+303, j*1.5*scl+125, scl, cs(a+param+PI/2));
      } else {
        module2(i*1.732*scl-(1.732*scl/2)+303, j*1.5*scl+125, scl, cs(a+param+PI/2));
      }
    }
  }

  //Animate
  a += 0.04;
  if(a > TWO_PI) exit();
  //saveFrame("output/animation###.png");
}

void module(float x, float y, float scl, float param) {
  pushMatrix();
  translate(x, y);
  fill(255);
  beginShape();
  vertex(-0.866025*scl, 0.5*scl);
  vertex(0.0, -1.0*scl);
  vertex(0.866025*scl, 0.5*scl);
  endShape();
fill(0);
  beginShape();
  vertex(-0.433013*scl*param, -0.25*scl*param);
  vertex(0.0, 0.5*scl*param);
  vertex(0.433013*scl*param, -0.25*scl*param);
  endShape();
  popMatrix();
}

void module2(float x, float y, float scl, float param) {
  pushMatrix();
  translate(x, y);
  fill(0);
  beginShape();
  vertex(-0.866025*scl, -0.5*scl);
  vertex(0.0, 1.0*scl);
  vertex(0.866025*scl, -0.5*scl);
  endShape();
fill(255);
  beginShape();
  vertex(-0.433013*scl*param, 0.25*scl*param);
  vertex(0.0, -0.5*scl*param);
  vertex(0.433013*scl*param, 0.25*scl*param);
  endShape();
  popMatrix();
}

// Set of functions taken from Dave Whyte's sketches

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float cs(float q) {
  return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 5));
}
