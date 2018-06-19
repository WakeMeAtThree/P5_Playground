Mesh initial, blend, target;
Meshes pizza;
float a, b;
float scl =1;
void setup() {
  size(400, 400, P3D);
  smooth(8);
  //blendMode(DIFFERENCE);
  ortho();
  pizza = new Meshes(27);
  println();
}

void draw() {
  background(0);
  //background(lerpColor(#FFFFFF, #000000, 1-map(cs(a), -1, 1, 0, 1)));
  lights();
  float dirY = (24 / float(height) - 0.5) * 2;
  float dirX = (93 / float(width) - 0.5) * 2;
  directionalLight(180, 180, 180, -dirX, -dirY, -1);
  if (mousePressed) println(mouseX, mouseY);
  //rotateX(map(317,0,width,-PI/4,PI));
  rotateZ(PI/2+PI);
  rotateX(PI/2);
     
  shearX(PI/4);
 
  translate(-340,203);

  for (int i = -5; i < 6; i++) {
    for (int j = -5; j < 5; j++) {

        float param = -5.0*(i+j)/11;
        //float param = 5.0*(pow(i,2)+pow(j,2)+pow(k,2))/(sqrt(2)*12);
      pushMatrix();
      rotateY(PI/4);
      pushMatrix();
      scale(52,52,52);
      scale(1,1.5,1);
      translate(i*1.5, 0, j*1.5);
      rotateY(2*PI/2);
      module(0, 0, 0, a+param, 1);
      popMatrix();
      popMatrix();
      
    }
  }
  //Animate
  a+=0.04;

  //Save Frames
  if(a > TWO_PI) exit();
  //saveFrame("output/animation###.png");
}
void module(float x, float y, float z, float a, float scl) {
  pushMatrix();
  pizza.morph(a);
  scale(scl);
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
