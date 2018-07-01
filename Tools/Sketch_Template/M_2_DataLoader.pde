class DataLoader {
  /* Class for handling multiple
   imports of curves/meshes */

  ArrayList<ArrayList<Curve>> curveStates = new ArrayList<ArrayList<Curve>>();
  ArrayList<ArrayList<Mesh>> meshStates = new ArrayList<ArrayList<Mesh>>();
  float waveShift;
  boolean CrvOrMesh;
  DataLoader(int states, int parts, boolean CrvOrMesh) {

    /* Takes in number of keyframes (states) and
     number of constituent parts in each keyFrame. File naming
     goes like:
     {NumberOfKeyFrame}{NumberOfPart}.{obj/svg}
     */
    
    //Set the color for each keyFrame state
    color[] options = {#13daff, #f73b87};//{#0EC0E1, #DD3A7C};

    if (CrvOrMesh) {
      for (int i = 1; i < states+1; i++) {
        ArrayList<Curve> curveImports = new ArrayList<Curve>();
        for (int j = 1; j < parts+1; j++) {
          curveImports.add(new Curve(loadShape(i+""+j+".svg"), false, options[(int)(i-1)%3]));
        }
        curveStates.add(curveImports);
      }
    } else {
      for (int i = 1; i < states+1; i++) {
        ArrayList<Mesh> meshImports = new ArrayList<Mesh>();
        for (int j = 1; j < parts+1; j++) {

          meshImports.add(new Mesh(loadShape(i+""+j+".obj"), options[(int)(i-1)%3]));
        }
        meshStates.add(meshImports);
      }
    }
    this.CrvOrMesh = CrvOrMesh;
  }

  void scale(float scl) {
    if (CrvOrMesh) {
      for (ArrayList<Curve> crvList : curveStates) {
        for (Curve crv : crvList) {
          crv.scale(scl);
        }
      }
    } else {
      for (ArrayList<Mesh> meshList : meshStates) {
        for (Mesh msh : meshList) {
          msh.scale(scl);
        }
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
