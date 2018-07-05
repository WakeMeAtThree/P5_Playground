class Ball {
  PVector loc, vel;
  float diameter;
  color hello;
  Ball() {
    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-1, 1), random(-1, 1)).mult(3);
    diameter = random(25, 190);
    //hello = 
    color[] colorOptions = {color(255,0,128),color(0,255,25),color(0,52,255)};
    hello=colorOptions[floor(random(3))];
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
