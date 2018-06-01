Mesh init, blend, target;
float a;

void setup() {
  size(500, 500, P3D);
  smooth(8);
  background(0);
  ortho();
  init = new Mesh(loadShape("init.obj"));
  blend = new Mesh(loadShape("init.obj"));
  target = new Mesh(loadShape("targe.obj"));
}

void draw() {
  background(0);
  lights();
  directionalLight(204, 204, 204, -1, 0, 0);
  translate(width/2,height/2);
  scale(0.4);
  for (int i = -9; i < 9; i++) {
    for (int j = -9; j < 9; j++) {
      //float param = 5.0*(i+j)/12;
      float param = 5.0*(pow(i,2)+pow(j,2))/(sqrt(2)*36);
      module(i*309/2, j*309/2, a+param);
    }
  }

  a+=0.05;
  if(a > TWO_PI) exit();
  saveFrame("output/animation###.png");
}

void module(float x, float y, float a) {
  pushMatrix();
  translate(x, y);
  rotateX(PI/2);
  rotateY(PI/2);
  scale(25);
  shearX(62);
  if (mousePressed) println(mouseX);
  rotateY(PI/4);
  blend.morph(init, target, a);
  blend.display(a);
  popMatrix();
}

///fill(lerpColor(#0CFFD2, #D60043, map(cs(0.5*a+param1+param2), -1, 1, 0, 1.5)));

// Set of ease functions below borrowed from Dave Whyte's sketches
// who's awesome enough to share it.

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
