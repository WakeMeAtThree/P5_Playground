import peasy.*;
ArrayList<PVector> vertices;
float r, theta, phi;
float x, y, z, a;
PeasyCam cam;
void setup() {
  size(500, 500, P3D);
  background(255);
  cam = new PeasyCam(this, 400);
  vertices = new ArrayList<PVector>();
}

void draw() {
  background(255);
  vertices = new ArrayList<PVector>();
  for (float i = 0; i < PI; i+=0.0525) {
    for (float j = 0; j < TWO_PI; j+=0.0525) {
      float param = 1.0*(i+j)/(TWO_PI);
      r = 50*sin(a+param);
      x = r*sin(i)*cos(j);
      y = r*sin(i)*sin(j);
      z = r*cos(i);
      vertices.add(new PVector(x, y, z));
    }
  }


  for (int i = 0; i < vertices.size(); i++) {
    float param = 5.0*i/vertices.size();
    stroke(lerpColor(#FF0000, #0000FF, sin(a+param)));
    PVector vec = vertices.get(i);
    strokeWeight(5);
    point(vec.x, vec.y, vec.z);
  }

  a += 0.1;
}
