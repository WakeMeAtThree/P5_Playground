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
  /* Constructor that takes table made from csvfile */

  Curve(Table table, boolean closeState, color curveColor) {
    //Add all vertices to arraylist
    for (TableRow row : table.rows()) {
      PVector point = new PVector(row.getFloat(0), row.getFloat(1), row.getFloat(2));
      this.vertices.add(point);
    }
    //Closed curve boolean
    this.closeState = false;
    this.curveColor = curveColor;
  }

  void display() {
    //fill(curveColor);
    
    outerDisplay();
    innerDisplay();
  }
  void outerDisplay(){
        noFill();
    pushStyle();
      stroke(255);
      strokeWeight(5);
      beginShape();
        for (PVector p : this.vertices) {
              PVector pp = p.mult(1);
              vertex(pp.x, pp.y, pp.z);
        }
      endShape();

    popStyle();
  }
  void innerDisplay(){
    //PVector cameraV = new PVector(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0)).rotate(a);
    
      float x = modelX(width/2, height/2, (height/2.0) / tan(PI*30.0 / 180.0));
      float y = modelY(width/2, height/2, (height/2.0) / tan(PI*30.0 / 180.0));
      float z = modelZ(width/2, height/2, (height/2.0) / tan(PI*30.0 / 180.0));
      PVector cameraV = new PVector(x,y,z);
            pushStyle();
        pushMatrix();
          stroke(0);
          strokeWeight(10);

          
            beginShape();
            for (PVector p : this.vertices) {
              PVector pp = p.add(PVector.sub(cameraV,p).normalize().mult(-1));
              
              vertex(pp.x, pp.y, pp.z);
            }
            endShape();
        popMatrix();
        popStyle();
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
