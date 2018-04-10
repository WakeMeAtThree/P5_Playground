class Ball {
  PVector loc;
  PVector vel;
  //PVector acc;

  Ball() {
    loc = new PVector(random(width), random(height));
    vel = PVector.random2D();
  }
  void update(float x, float y) {
    PVector acc = PVector.sub(new PVector(x, y), loc).mult(0.01);
    loc.add(vel);
    vel.add(acc);
    vel.limit(1);
  }

  void display() {
    fill(255);
    stroke(255, 0, 0, 100);
    ellipse(loc.x, loc.y, 5, 5);
  }
}