class Morph {
  /* Linear (or other) interpolation of 
   object attributes (position, color) that
   can be used to display at a certain 
   parameter
   
   Takes multiple states as a list in the order 
   given*/

  ArrayList<Mesh> keyFramesMeshes = new ArrayList<Mesh>();
  ArrayList<Curve> keyFramesCurves = new ArrayList<Curve>();

  /* Constructor for Curve objects */
  Morph(Mesh... meshes) {
    this.keyFramesMeshes = meshes;
  }

  /* Constructor for Mesh objects */
  Morph(Curve... curves) {
    this.keyFramesCurves = curves;
  }

  void display(float time) {
    /* Takes a value between 0 and 1 to alternate
     between states */
    this.lerpMeshes(time).display();
  }

  Mesh lerpMeshes(float amt, Mesh... mesh) {
    if (mesh.length==1) { 
      return mesh[0];
    }

    float spacing = 1.0/(mesh.length-1);
    int lhs = floor(amt / spacing);
    int rhs = ceil(amt / spacing);

    try {
      return Mesh.lerp(mesh[lhs], mesh[rhs], amt%spacing/spacing);
    } 
    catch(Exception e) {
      return Mesh.lerp(mesh[constrain(lhs, 0, mesh.length-2)], mesh[constrain(rhs, 1, mesh.length-1)], amt);
    }
  }
}
