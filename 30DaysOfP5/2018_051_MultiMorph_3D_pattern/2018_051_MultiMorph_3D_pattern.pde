Mesh initial, blend, target;
Meshes pizza;
float a, b;
float scl = 8;
void setup() {
  size(400, 400, P3D);
  smooth(8);
  ortho();
  // initial = new Mesh(loadShape("init1.obj"));
  // blend = new Mesh(loadShape("init1.obj"));
  // target = new Mesh(loadShape("target1.obj"));
  pizza = new Meshes(27);
  println();
}

void draw() {
  background(lerpColor(#000000, #000000, 1-map(cs(a), -1, 1, 0, 1)));
  lights();

  float dirY = (50 / float(height) - 0.5) * 2;
  float dirX = (105 / float(width) - 0.5) * 2;
  directionalLight(180, 180, 180, -dirX, -dirY, -1);
  if (mousePressed)println(mouseX, mouseY);
  //Morph
  //blend.morph(initial, target, a);
  translate(width/2,height/2,0);
  for (int i = -4; i < 4; i++) {
    for (int j = -4; j < 4; j++) {
      float param = 1.0*(i+j)/8;
      if(j%2==0){
        module(i*160/1.5, j*135/1.5, a+param, scl/1.5);
      } else {
        module(i*160/1.5+(160/2)/1.5, j*135/1.5, a+param, scl/1.5);
      }

    }
  }
  //Animate
  a+=0.04;
  //b+=0.01;
  //Save Frames
  //if(a > TWO_PI) exit();
  //saveFrame("output/animation###.png");
}
void module(float x, float y, float a, float scl) {
  pushMatrix();
  pizza.morph(a);

  //Move origin
  translate(x, y, 0);
  rotateX(PI-PI/4);
  rotateZ(lerp(0, PI, map(cs(a), -1, 1, 0, 1)));
  rotateY(lerp(PI/4, -PI/4, map(cs(a), -1, 1, 0, 1)));
  if (mousePressed) println(mouseX);
  scale(scl);

  //Display
  //blend.display(a);
  pizza.display(a);
  popMatrix();
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

///
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
