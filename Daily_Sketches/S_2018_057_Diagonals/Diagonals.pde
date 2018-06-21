Mesh initial, blend, target;
Meshes pizza;
float a, b;
float scl = 10;
void setup() {
  size(400, 400);
  //blendMode(DIFFERENCE);
  smooth(8);
  pizza = new Meshes(1);
}

void draw() {
  background(lerpColor(#000000, #000000, 1-map(cs(a), -1, 1, 0, 1)));
  pushStyle();
  fill(0, 10);
  rect(0, 0, width, height);
  popStyle();
  if (mousePressed) println(mouseX, mouseY);
  // translate(width/2,height/2);
  //scale(3);
  float x = 33;//109.08;
  float y = 41;//95;
  for (int i = -5; i < 50; i++) {
    for (int j = -5; j < 50; j++) {
      float param = 5.0*(i+j)/55;
      if (j%2==0) {
        module(i*x, j*y, a+param);
      } else {
        module(i*x+x/2, j*y, a+param);
      }
    }
  }


  //Animate
  a+=0.025;

  //Save Frames
  //if(a > TWO_PI) exit();
  //saveFrame("output/animation###.png");
}
void module(float x, float y, float a) {
  pushMatrix();
  translate(x, y);
  pizza.morph(a);
  pizza.display(scl);
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
