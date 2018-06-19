Table table;
ArrayList<PVector> pointslist;
void setup() {
  size(1000, 1000, P3D);
  ortho();
  table = loadTable("curvey.csv", "header");
  pointslist = new ArrayList<PVector>();
  println(table.getRowCount() + " total rows in table"); 
  stroke(32);
  noFill();
  for (TableRow row : table.rows()) {

    float x = row.getFloat("x");
    float y = row.getFloat("y");
    float z = row.getFloat("z");



    pointslist.add(new PVector(x, y, z));
  }
}

void someshape() {
  beginShape();
  for (PVector p : pointslist) {
    vertex(p.x, p.y, p.z);
  }
  endShape(CLOSE);
}

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popMatrix();
  popStyle();
}

void draw() {
  background(34, 30, 28);
  scale(10);
  push();

  noFill();
  stroke(3);
  strokeWeight(3);
  someshape();
  push();
  stroke(255, 248, 253);
  strokeWeight(1.9);
  someshape();
  pop();
  pop();
}