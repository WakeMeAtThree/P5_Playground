PShape s;
ArrayList<Ball> ballslist;

void setup() {
  size(800,800,P3D);
  background(0);
  noStroke();
  fill(0, 10);
  //blendMode(SUBTRACT);
  ballslist = new ArrayList<Ball>();

  ballslist.add(new Ball(new PVector(0, 0)));
  ballslist.add(new Ball(new PVector(60, 0)));
  ballslist.add(new Ball(new PVector(60, 60)));
  ballslist.add(new Ball(new PVector(0, 60)));

  
}

void draw() {
  translate(width/2, height/2);
  
  beginShape(QUADS);
  normal(0, 0, 1);
  fill(50, 50, 200,10);
  vertex(ballslist.get(0).loc.x, ballslist.get(0).loc.y);
  vertex(ballslist.get(1).loc.x, ballslist.get(1).loc.y);
  fill(200, 50, 50,10);
  vertex(ballslist.get(2).loc.x, ballslist.get(2).loc.y);
  vertex(ballslist.get(3).loc.x, ballslist.get(3).loc.y);
  endShape(CLOSE);
  
  for (Ball p : ballslist) {
    p.run();
  }
}