/*
 - Recreate previous sketches using this syntax
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
  a += 0.025;
}

float func(float time, float delay){
  return divide(3,1,1,map(sin(time+delay),-1,1,0,1));
}
float divide(int n, float xRange, float yRange, float j) {
  float outputVal = 0;
  for (int i=0; i<n; i++) {
    float a = float(n);
    outputVal += (yRange/(a-1.))*smoothstep(xRange*i/a,xRange*i/a-0.1,j);
  }
  return outputVal;
}

float smoothstep(float edge0, float edge1, float x) {
  x = constrain((x - edge0) / (edge1 - edge0), 0.0f, 1.0f); 
  return x * x * (3 - 2 * x);
}
