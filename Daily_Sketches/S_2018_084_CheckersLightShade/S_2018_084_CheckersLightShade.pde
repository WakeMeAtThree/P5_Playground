Mesh initial, blend, target;
Meshes pizza;
float a, b;
float scl;
PGraphics scene;

void setup() {
  size(400, 400, P3D);
a = map(360,0,width,0,TWO_PI);
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
  translate(width/2,height/2,0);
  module(0, 0, a, scl/1.5);
  a+=0.04;
  if(a > TWO_PI+map(360,0,width,0,TWO_PI)) exit();
}
void module(float x, float y, float a, float scl) {
  pushMatrix();
  pizza.morph(a);

  //Move origin
  translate(x, y, 0);
  rotateX(PI-PI/4);
  rotateZ(lerp(0, PI, map(cs(a), -1, 1, 0, 1)));
  rotateY(lerp(PI/4, 0, 0.5*map(cs(a), -1, 1, 0, 1)+0.5*map(cs(a+1.5), -1, 1, 0, 1)   ));
  float sclx = lerp(10,37,0.001*map(cs(a), -1, 1, 0, 1)+0.999*map(cs(a+1.5), -1, 1, 0, 1));
  scale(sclx,sclx,sclx);
  pizza.display(a);
  popMatrix();
}


// Needed to create my own ease functions instead

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

float smoothstep(float edge0, float edge1, float x) {
  // Scale, bias and saturate x to 0..1 range
  x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0); 
  // Evaluate polynomial
  return x * x * (3 - 2 * x);
}
