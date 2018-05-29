import peasy.PeasyCam;
PeasyCam cam;
ArrayList<PVector> pointsList;
float a, spacing;
PVector eye, center, light1, light2;
float gScale = 2.0;
void setup() {
  size(1000, 500*gScale, P3D);
  smooth(8);
  background(0);
  ortho();

  //Create points in order
  float side = 8*gScale;
  spacing = side*2;
  pointsList = new ArrayList<PVector>(); 
  pointsList.add(new PVector(side, side, 0));
  pointsList.add(new PVector(-side, side, 0));
  pointsList.add(new PVector(-side, -side, 0));
  pointsList.add(new PVector(side, -side, 0));
  pointsList.add(new PVector(side, side, 0));

  //Setting camera and light coordinates
  //eye = new PVector(38.895, 53.456, 47.268);
  eye = new PVector(46.633, 37.374, 58.093);
  eye.mult(22);
  center = new PVector(0, 0, 0);
  light1 = new PVector(-37.984, 44.367, 43.878);
  light2 = new PVector(-30.810, -65.024, 45.515);

}

void draw() {
  background(0);
  lights();
  directionalLight(204, 204, 204, light1.x, light1.y, light1.z);

  //Point camera at the right spot
  camera(eye.x, eye.y, eye.z, 
    center.x, center.y, center.z, 
    0, 0, -1);

  //Move to origin
  translate(130*gScale, 130*gScale);
  if (mousePressed) println(mouseX, mouseY);

  //Ground Plane
  fill(15);
  beginShape();
  vertex(1000, 1000, 0);
  vertex(-1000, 1000, 0);
  vertex(-1000, -1000, 0);
  vertex(1000, -1000, 0);
  endShape(CLOSE);

  for (int i = -14; i < 0; i++) {
    for (int j = -14; j < 0; j++) {
      //Introduce delay based on grid position
      //float param = 5.5*(i+j)/26;
      float param = 1.0*(pow(i, 2)+1*pow(j, 2))/(sqrt(2)*26);
      module(i*spacing, j*spacing, param);
    }
  }


  //Animate
  a -= 0.04;
  if(-a >= TWO_PI) exit();
  saveFrame("output/animation###.png");
}

void module(float x, float y, float param) {
  pushMatrix();
  translate(x, y);

  //Create Tri Mesh
  noStroke();
  beginShape(TRIANGLES);
  for (int i = 0; i < pointsList.size()-1; i++) {
    PVector v1 = pointsList.get(i);
    PVector v2 = pointsList.get(i+1);
    fill(lerpColor(#0CFFD2, #D60043, sin(a+param)),250);
    vertex(0,0, map(sin(a+param), -1, 1, 1, 120));
    vertex(v1.x, v1.y, 0);
    vertex(v2.x, v2.y, 0);
  }   
  endShape();

  popMatrix();
}
