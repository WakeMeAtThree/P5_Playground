class Ball {
  PVector loc, vel;
  float diameter;
  Ball() {
    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-1, 1), random(-1, 1)).mult(3);
    diameter = random(25, 90);
  }
  void run() {
    update();
    bounce();
    display();
  }
  void update() {
    loc.add(vel);
  }

  void bounce() {
    if (loc.x > width || loc.x < 0) vel.x *= -1;
    if (loc.y > height || loc.y < 0) vel.y *= -1;
  }

  void display() {
    stroke(0);
    noFill();
    ellipse(loc.x, loc.y, diameter, diameter);
  }
}
