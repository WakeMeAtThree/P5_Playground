float a;
PVector initial, target;
void setup() {
  size(400, 400);
  background(255);

  initial = new PVector(0, 0, 0);
  target = new PVector(width/2, height/2, 0);

  fill(255, 0, 0);
  noStroke();
  ellipse(target.x, target.y, 8, 8);
}

void draw() {
  PVector blend = PLerpinparts(initial, target, a);

  fill(0, 50);
  ellipse(blend.x, blend.y, 8, 8);

  a += 0.01;

  if (a > 3) {
    a = 0;
    initial = target;
    target = new PVector(random(width), random(height),0);
    fill(255, 0, 0);
    noStroke();
    ellipse(target.x, target.y, 16, 16);
  }
}

PVector lerpinparts(PVector init, PVector target, float a) {
  float x = lerp(init.x, target.x, constrain(a, 0.0, 1.0));
  float y = lerp(init.y, target.y, constrain(a-1, 0.0, 1.0));
  float z = lerp(init.z, target.z, constrain(a-2, 0.0, 1.0));
  return new PVector(x, y, z);
}

float radius(float x, float y, float z) {
  return sqrt(pow(x, 2)+pow(y, 2)+pow(z, 2));
}
float theta(float x, float y, float z) {
  return acos(z/radius(x, y, z));
}
float phi(float x, float y, float z) {
  return atan2(y, x);
}

PVector PLerpinparts(PVector v1, PVector v2, float a) {
  float radius1 = radius(v1.x, v1.y, v1.z);
  float theta1 = theta(v1.x, v1.y, v1.z);
  float phi1 = phi(v1.x, v1.y, v1.z);

  float radius2 = radius(v2.x, v2.y, v2.z);
  float theta2 = theta(v2.x, v2.y, v2.z);
  float phi2 = phi(v2.x, v2.y, v2.z);
  float r, theta, phi;

  r = lerp(radius1, radius2, constrain(a, 0.0, 1.0));
  theta = lerp(theta1, theta2, constrain(a-1, 0.0, 1.0));
  phi = lerp(phi1, phi2, constrain(a-2, 0.0, 1.0));

  PVector blend = new PVector(r*sin(theta)*cos(phi), 
    r*sin(theta)*sin(phi), 
    r*cos(theta));
  return blend;
}