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
    color[] colorOptions = {#fffc00, #f6cf18, #ffde00, #ff9c00, #ff5400, #ff3c00};
    ballColor=colorOptions[globalCount%colorOptions.length];

    blankConstructor = true;
    globalCount++;
  }
  Ball(PVector start, PVector end) {

    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-1, 1), random(-1, 1)).mult(7);
    diameter = random(125/3, 185/2);

    color[] colorOptions = {#fffc00, #f6cf18, #ffde00, #ff9c00, #ff5400, #ff3c00};
    ballColor=colorOptions[globalCount%colorOptions.length];

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
      loc=PVector.lerp(start, end, map(sin(a+param), -1, 1, 0.1, 0.3));
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
