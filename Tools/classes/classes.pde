/*
- Write lerpMeshStates()
- Make lerpCurveStates and lerpMeshStates part of DataLoader class 
- DataLoader without using SVG files
*/
ArrayList<PVector> vertices;
Curve aCurve1, aCurve2, aCurve3;
DataLoader uno;
float a;
ArrayList<ArrayList<Curve>> curveStates;
void setup() {
  size(400, 400);



  //new DataLoader(number of keyFrames, number of parts in each keyFrame, true for Curves/alse for Meshes
  uno = new DataLoader(2, 4, true);
  aCurve1 = new Curve(loadShape("11.svg"), true);
  
  
  uno.scale(25);
  uno.translate(new PVector(width/2,height/2));
  
  curveStates = uno.getCurveStates();
}

void draw() {
  background(255);
  
  for (Curve crv : lerpCurveStates(curveStates, map(cs(a),-1,1,0,1))) {
    noStroke();
    fill(0);
    crv.display();
  }

  a += 0.01;
}

/* Chain of Lerps below */

ArrayList<Curve> lerpCurveStates(ArrayList<ArrayList<Curve>> curveStates, float amt) {
  if (curveStates.size()==1) { 
    return curveStates.get(0);
  }

  float spacing = 1.0/(curveStates.size()-1);
  int lhs = floor(amt / spacing);
  int rhs = ceil(amt / spacing);

  try {
    return curvesLerp(curveStates.get(lhs), curveStates.get(rhs), amt%spacing/spacing);
  } 
  catch(Exception e) {
    return curvesLerp(curveStates.get(constrain(lhs, 0, curveStates.size()-2)), curveStates.get(constrain(rhs, 1, curveStates.size()-1)), amt);
  }
}

ArrayList<Curve> curvesLerp(ArrayList<Curve> c1, ArrayList<Curve> c2, float amt) {
  ArrayList<Curve> blendedCurves = new ArrayList<Curve>();
  for (int i = 0; i < c1.size(); i++) {
    blendedCurves.add(vertsLerp(c1.get(i), c2.get(i), amt));
  }
  return blendedCurves;
}

Curve vertsLerp(Curve crv1, Curve crv2, float amt) {
  ArrayList<PVector> blendVerts = new ArrayList<PVector>();
  for (int i = 0; i < crv1.vertices.size(); i++) {
    blendVerts.add(PVector.lerp(crv1.vertices.get(i), crv2.vertices.get(i), amt));
  }
  return new Curve(blendVerts, crv1.closeState);
}
