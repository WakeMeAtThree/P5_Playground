class DataLoader {
  /* Class for handling multiple
   imports of curves/meshes */

  ArrayList<ArrayList<Curve>> curveStates = new ArrayList<ArrayList<Curve>>();
  ArrayList<ArrayList<Mesh>> meshStates = new ArrayList<ArrayList<Mesh>>();
  float waveShift;
  DataLoader(int states, int parts, boolean CrvOrMesh) {

    /* Takes in number of keyframes (states) and
     number of constituent parts in each keyFrame. File naming
     goes like:
     {NumberOfKeyFrame}{NumberOfPart}.{obj/svg}
     */

    color[] options = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)};

    if (CrvOrMesh) {
      for (int i = 1; i < states+1; i++) {
        ArrayList<Curve> curveImports = new ArrayList<Curve>();
        for (int j = 1; j < parts+1; j++) {
          curveImports.add(new Curve(loadShape(i+""+j+".svg"), false, options[(int)i%3]));
        }
        curveStates.add(curveImports);
      }
    } else {
      for (int i = 1; i < states+1; i++) {
        ArrayList<Mesh> meshImports = new ArrayList<Mesh>();
        for (int j = 1; j < parts+1; j++) {
          meshImports.add(new Mesh(loadShape(i+""+j+".obj"), options[(int)i%3]));
        }
        meshStates.add(meshImports);
      }
    }
  }

  /* Coordinate Systems Functions
   TODO: maybe this needs to be 
   inherited? */

  void scale(float scl) {
    for (ArrayList<Curve> crvList : curveStates) {
      for (Curve crv : crvList) {
        crv.scale(scl);
      }
    }
  }

  void translate(PVector dir) {
    for (ArrayList<Curve> crvList : curveStates) {
      for (Curve crv : crvList) {
        crv.translate(dir);
      }
    }
  }

  ArrayList<ArrayList<Curve>> getCurveStates() {
    return this.curveStates;
  }

  ArrayList<ArrayList<Mesh>> getMeshStates() {
    return this.meshStates;
  }
}
