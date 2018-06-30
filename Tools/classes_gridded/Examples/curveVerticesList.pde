ArrayList<PVector> vertices;
Curve aCurve;
void setup() {
  size(400, 400);
  
  vertices = new ArrayList<PVector>();
  vertices.add(new PVector(0,0));
  vertices.add(new PVector(0,150));
  vertices.add(new PVector(300,300));
  vertices.add(new PVector(150,500/4));
  
  translate(width/2,height/2);
  aCurve = new Curve(vertices, true);
  aCurve.display();
}

void draw() {
}
