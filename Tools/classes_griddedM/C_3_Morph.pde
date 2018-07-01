class Morph {
  ArrayList<ArrayList<Curve>> curveStates;
  ArrayList<ArrayList<Mesh>> meshStates;
  boolean option;
  float waveShift;

  Morph(DataLoader curvesORmeshes, boolean option) {
    if (option) {
      this.curveStates = curvesORmeshes.getCurveStates();
    } else {
      this.meshStates = curvesORmeshes.getMeshStates();
    }
    this.waveShift = curvesORmeshes.waveShift;
    this.option = option;
  }
  void display(float a) {

    /* 
     Let's unpack what's happening here bit by bit.
     lerpCurveStates() takes in curveStates from DataLoader and a lerping amount
     and returns a blended set of curves. 
     */

    if (option) {
      for (Curve crv : lerpCurveStates(curveStates, func(curveStates.size(), a, waveShift))) {
        crv.display();
      }
    } else {
      for (Mesh msh : lerpMeshStates(meshStates, func(meshStates.size(), a, waveShift))) {
        msh.display();
        
      }
    }
  }

  /* Adaption of lerping across multiple keyframes from Jeremy Douglass. Check his forum post on 
   List-Based interpolations in the following links:
   https://forum.processing.org/two/discussion/25310/list-based-interpolations/p1
   */

  /* Chain of Lerps below (for Meshes) */

  ArrayList<Mesh> lerpMeshStates(ArrayList<ArrayList<Mesh>> meshStates, float amt) {
    if (meshStates.size()==1) { 
      return meshStates.get(0);
    }

    float spacing = 1.0/(meshStates.size()-1);
    int lhs = floor(amt / spacing);
    int rhs = ceil(amt / spacing);

    try {
      return meshesLerp(meshStates.get(lhs), meshStates.get(rhs), amt%spacing/spacing);
    } 
    catch(Exception e) {
      return meshesLerp(meshStates.get(constrain(lhs, 0, meshStates.size()-2)), meshStates.get(constrain(rhs, 1, meshStates.size()-1)), amt);
    }
  }

  ArrayList<Mesh> meshesLerp(ArrayList<Mesh> c1, ArrayList<Mesh> c2, float amt) {
    ArrayList<Mesh> blendedMeshes = new ArrayList<Mesh>();
    for (int i = 0; i < c1.size(); i++) {
      blendedMeshes.add(vertsLerpM(c1.get(i), c2.get(i), amt));
    }
    return blendedMeshes;
  }

  Mesh vertsLerpM(Mesh msh1, Mesh msh2, float amt) {
    ArrayList<PVector> blendVerts = new ArrayList<PVector>();
    color blendColor = lerpColor(msh1.meshColor, msh2.meshColor, amt);
    for (int i = 0; i < msh1.vertices.size(); i++) {
      blendVerts.add(PVector.lerp(msh1.vertices.get(i), msh2.vertices.get(i), amt));
    }
    return new Mesh(blendVerts, msh1.faces, blendColor);
  }

  /* Chain of Lerps below (for curves) */

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
    color blendColor = lerpColor(crv1.curveColor, crv2.curveColor, amt);
    for (int i = 0; i < crv1.vertices.size(); i++) {
      blendVerts.add(PVector.lerp(crv1.vertices.get(i), crv2.vertices.get(i), amt));
    }
    return new Curve(blendVerts, crv1.closeState, blendColor);
  }
}