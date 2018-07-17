int globalCount = 0;

class Ball {
  PVector loc, vel;
  PVector start, end;
  float diameter;
  color ballColor;
  boolean blankConstructor;
  Ball() {
    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-1, 1), random(-1, 1)).mult(7);
    diameter = random(125/3, 185/2);
    color[] colorOptions = {#0EC0E1, #DD3A7C};
    ballColor=color(random(181,255),255,255);

    blankConstructor = true;
    globalCount++;
  }
  Ball(PVector start, PVector end) {

    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-1, 1), random(-1, 1)).mult(7);
    diameter = 45;

    color[] colorOptions = {#13daff, #f73b87};
    //ballColor=colorOptions[globalCount%colorOptions.length];
    ballColor=color(random(255),random(255),random(255));
    this.start = start;
    this.end = end;
    globalCount++;
  }
  void run(float param) {
    update(param);
    if (blankConstructor) bounce();
    //display();
  }
  void update(float param) {
    if (blankConstructor) {
      loc.add(vel);
    } else {
      loc=PVector.lerp(start, end, map(sin(a), -1, 1, 0, 1));
    }
  }

  void bounce() {
    if (loc.x > width || loc.x < 0) vel.x *= -1;
    if (loc.y > height || loc.y < 0) vel.y *= -1;
  }

  void display() {
    noFill();
    ellipse(loc.x, loc.y, diameter, diameter);
  }
}
