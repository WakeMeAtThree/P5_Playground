float a;
Box b;
ArrayList<Box> sponge;
void setup() {
  size(400, 400, P3D);
  sponge = new ArrayList<Box>();
  b = new Box(new PVector(0, 0, 0), 200);
  sponge.add(b);
}

void draw() {
  background(51);
  stroke(255);
  noFill();

  translate(width/2, height/2);
  rotateX(a);
  rotateY(a*0.4);
  rotateZ(a*0.1);
  for (Box b : sponge) {
    b.show();
  }

  a += 0.01;
}

void mousePressed(){
  ArrayList<Box> next = new ArrayList<Box>();
  for(Box b: sponge){
    next.addAll(b.generate());
  }
  sponge = next;
}