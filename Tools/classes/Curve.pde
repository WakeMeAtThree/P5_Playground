class Curve {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  boolean closeState;

  /* Constructor that takes PShape directly */
  Curve(PShape curve, boolean closeState) {

    //Add all vertices to arraylist
    for (int i = 1; i < curve.getChild(0).getVertexCount(); i++) {
      this.vertices.add(curve.getChild(0).getVertex(i).copy());
    }
    
    //Closed curve boolean
    this.closeState = true;

  }

  /* Constructor that takes vertices list
   (and possible other attributes in the future */
   
  Curve(ArrayList<PVector> vertices, boolean closeState) {
    this.vertices = vertices;

    //Closed curve boolean
    this.closeState = closeState;
  }

  void display() {
    if (closeState) {
      beginShape();
      for (PVector p : this.vertices) {
        vertex(p.x, p.y);
      }
      endShape(CLOSE);
    } else {
      beginShape();
      for (PVector p : this.vertices) {
        vertex(p.x, p.y);
      }
      endShape();
    }
  }
  
  void scale(float scl){
    for(int i = 0; i < vertices.size(); i++){
      vertices.set(i,vertices.get(i).mult(scl)); 
    }
  }
  
  void translate(PVector dir){
    for(int i = 0; i < vertices.size(); i++){
      vertices.set(i,vertices.get(i).add(dir)); 
    }    
  }
  
  /* Wishlist */

  void offset() {
  }

  void bend() {
  }
}
