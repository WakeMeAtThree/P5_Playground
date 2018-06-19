Mesh initial, blend, target;
float a;
PVector light1;

void setup() {
  size(500, 500, P3D);
  smooth(8);
  ortho();
  initial = new Mesh(loadShape("test1.obj"));
  blend = new Mesh(loadShape("test3.obj"));
  target = new Mesh(loadShape("test3.obj"));
  light1 = new PVector(-37.984, 44.367, 43.878);
  ortho(-width/2, width/2, -height/2, height/2, -1000, 100000);
}

void draw() {
  background(15);

  lights();
  directionalLight(204, 204, 204, map(273, 0, width, -1, 1), map(295, 0, height, -1, 1), 0);





  //Move origin
  translate(width/2, height/2, 0);
  rotateX(map(393, 0, width, 0, PI));
  if (mousePressed) println(mouseX, mouseY);
  rotateY(map(110, 0, height, 0, PI));
  scale(4);

  //Display
  module();
  pushMatrix();
  rotateY(PI);
  module();
  popMatrix();
  a+=0.05;

  //Save Frames
  if (a > TWO_PI) exit();
  //saveFrame("output/animation###.png");
}
void module() {

  for (int i = -15; i < 15; i++) {
    for (int j = -15; j < 15; j++) {
      float param = 15.0*(i+j)/30;
      pushMatrix();
      translate(i*26, 0, j*26);
      pushMatrix();
      if (j % 2 == 0) rotateY(PI/2);

      blend.morph(initial, target, a+param);
      blend.display(a+param);
      popMatrix();
      popMatrix();
    }
  }
}
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
//

float radius(float x, float y, float z) {
  return sqrt(pow(x, 2)+pow(y, 2)+pow(z, 2));
}
float theta(float x, float y, float z) {
  return acos(z/radius(x, y, z));
}
float phi(float x, float y, float z) {
  return atan2(y, x);
}

PVector Plerp(PVector v1, PVector v2, float a) {
  float radius1 = radius(v1.x, v1.y, v1.z);
  float theta1 = theta(v1.x, v1.y, v1.z);
  float phi1 = phi(v1.x, v1.y, v1.z);

  float radius2 = radius(v2.x, v2.y, v2.z);
  float theta2 = theta(v2.x, v2.y, v2.z);
  float phi2 = phi(v2.x, v2.y, v2.z);

  float r = lerp(radius1, radius2, a);
  float theta = lerp(theta1, theta2, a);
  float phi = lerp(phi1, phi2, a);

  PVector blend = new PVector(r*sin(theta)*cos(phi), 
    r*sin(theta)*sin(phi), 
    r*cos(theta));
  return blend;
}
