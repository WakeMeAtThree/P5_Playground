Mesh initial, blend, target;
float a;

void setup() {
  size(400, 400, P3D);
  smooth(8);
  initial = new Mesh(loadShape("InitMesh.obj"));
  blend = new Mesh(loadShape("InitMesh.obj"));
  target = new Mesh(loadShape("targetMesh.obj"));
}

void draw() {
  fill(lerpColor(#0EC0E1, #DD3A7C, 1-map(sin(a), -1, 1, 0, 1)));
  noStroke();
  rect(0, 0, width, height);
  lights();
  
  //Morph
  blend.morph(initial, target, a);

  //Move origin
  translate(width/2, height/2, 0);
  rotateX(PI);
  rotateY(0.1*a);
  scale(85);

  //Display
  blend.display(a);
  a+=0.1;
  
  //Save Frames
  if(a > TWO_PI) exit();
  saveFrame("output/animation###.png");
}
