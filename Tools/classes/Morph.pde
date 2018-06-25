//class Morph {
//  /* Linear (or other) interpolation of 
//   object attributes (position, color) that
//   can be used to display at a certain 
//   parameter
   
//   Takes multiple states as a list in the order 
//   given*/

//  Mesh[] keyFramesMeshes;
//  ArrayList<Curve>[] keyFramesCurves;

//  /* Constructor for Curve objects */
//  Morph(Mesh... meshes) { 
//    this.keyFramesMeshes=meshes;
//  }

//  /* Constructor for Mesh objects */
//  Morph(ArrayList<Curve>... curves) {
//    this.keyFramesCurves = curves;
//  }

//  void display(float time) {
//    /* Takes a value between 0 and 1 to alternate
//     between states */
//    //this.lerpMeshes(time, keyFramesMeshes).display(time);
//  }

//  ArrayList<Curve> lerpCurves(float amt, ArrayList<ArrayList<Curve>> curves) {
//    if (curves.size()==1) { 
//      return curves.get(0);
//    }

//    float spacing = 1.0/(curves.size()-1);
//    int lhs = floor(amt / spacing);
//    int rhs = ceil(amt / spacing);

//    try {
//      return curveLerp(curves.get(lhs), curves.get(rhs), amt%spacing/spacing);
//    } 
//    catch(Exception e) {
//      return curveLerp(curves.get(constrain(lhs, 0, curves.size()-2)), curves.get(constrain(rhs, 1, curves.size()-1)), amt);
//    }
//  }
//}
///*
//ArrayList<Curve> curveLerp(ArrayList<Curve> v1, ArrayList<Curve> v2, float amt){
//  ArrayList<Curve> blendCurve;
//  for(int i = 0; i < v1.size(); i++){
    
//  }
//  //return output;
//}
//*/
