class Curve {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  /* Constructor that takes PShape directly */
  Curve(PShape curve) {

    //Add all vertices to arraylist
    for (int i = 0; i < curve.getChild(0).getVertexCount(); i++) {
      this.vertices.add(curve.getChild(0).getVertex(i).copy());
    }
  }

  /* Constructor that takes vertices list
   (and possible other attributes in the future */
  Curve(ArrayList<PVector> vertices) {
    this.vertices = vertices;
  }

  void display() {
  }

  /* Wishlist */

  void offset() {
  }

  void bend() {
  }
}
