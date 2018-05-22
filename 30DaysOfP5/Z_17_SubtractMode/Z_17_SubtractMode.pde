ArrayList<Ball> Alistballs;
float a;

void setup() {
  size(400, 400);
  background(255);
  smooth(8);
  Alistballs = new ArrayList<Ball>();

  for (int i = -1; i < 12; i++) {
    for (int j =-1; j < 12; j++) {
      if(j % 2 == 0){
      Alistballs.add(new Ball(new PVector(40*i, 40*j)));
      } else {
        Alistballs.add(new Ball(new PVector(40*i+20, 40*j)));
      }
    }
  }
}

void draw() {
  background(255);
  for (Ball p : Alistballs) {
    p.run(a);
  }
  a += 0.025;
  //saveFrame("animation/output####.gif");
}

void mousePressed() {
  Alistballs.add(new Ball(new PVector(mouseX, mouseY)));
}