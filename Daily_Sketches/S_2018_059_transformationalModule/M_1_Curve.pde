class Curve {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  boolean closeState;
  color curveColor;

  /* Constructor that takes PShape directly */

  Curve(PShape curve, boolean closeState, color curveColor) {
    //Add all vertices to arraylist
    for (int i = 1; i < curve.getChild(0).getVertexCount(); i++) {
      this.vertices.add(curve.getChild(0).getVertex(i).copy());
    }

    //Closed curve boolean
    this.closeState = false;
    this.curveColor = curveColor;
  }

  /* Constructor that takes vertices list
   (and possible other attributes in the future */

  Curve(ArrayList<PVector> vertices, boolean closeState, color curveColor) {
    this.vertices = vertices;

    //Closed curve boolean
    this.closeState = closeState;
    this.curveColor = curveColor;
  }

  void display() {
    fill(curveColor);

    beginShape();
    for (PVector p : this.vertices) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
  }

  void scale(float scl) {
    for (int i = 0; i < vertices.size(); i++) {
      vertices.set(i, vertices.get(i).mult(scl));
    }
  }

  /* Wishlist (There's probably another library for this) */

  void offset() {
  }

  void bend() {
  }
}
