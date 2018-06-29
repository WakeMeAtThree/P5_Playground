/*
 - Gridify
 - Write lerpMeshStates()
 - Make lerpCurveStates and lerpMeshStates part of DataLoader class 
 */

ArrayList<PVector> vertices;
ArrayList<ArrayList<Curve>> curveStates;
DataLoader uno;
Morph due;
float a;

void setup() {
  size(400, 400);

  //new DataLoader(number of keyFrames, number of parts in each keyFrame, true for Curves/alse for Meshes
  uno = new DataLoader(3, 1, true);  
  uno.scale(155);
  uno.translate(new PVector(width/2, height/2));
  
  due = new Morph(uno);

}

void draw() {
  background(255);
  noStroke();
  due.display(a);
  a += 0.01;
}
