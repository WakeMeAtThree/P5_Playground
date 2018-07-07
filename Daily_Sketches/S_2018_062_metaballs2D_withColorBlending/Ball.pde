class Ball {
  PVector loc, vel;
  float diameter;
  color hello;
  Ball() {
    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-1, 1), random(-1, 1)).mult(3);
    diameter = random(60, 100);
    //hello = 
    color[] colorOptions = {#0EC0E1, #DD3A7C,#DD3A7C};
    hello=colorOptions[floor(random(2))];
  }
  void run() {
    update();
    bounce();
    //display();
  }
  void update() {
    loc.add(vel);
    //println(hello.y);
  }

  void bounce() {
    if (loc.x > width || loc.x < 0) vel.x *= -1;
    if (loc.y > height || loc.y < 0) vel.y *= -1;
  }

  void display() {
    //stroke(hello);
    //stroke(0);
    noFill();
    ellipse(loc.x, loc.y, diameter, diameter);
  }
}