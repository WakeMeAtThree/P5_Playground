class Ball {
  PVector loc, vel;
  float diameter;
  color hello;
  PVector start,end;
  Ball(PVector start, PVector end) {
    
    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-1, 1), random(-1, 1)).mult(7);
    diameter = random(125/3,185/2);
    //hello = 
    color[] colorOptions = {#fffc00,#f6cf18,#ffde00,#ff9c00, #ff5400,#ff3c00};
    hello=colorOptions[globalCount%colorOptions.length];
    ///
    this.start = start;
    this.end = end;
    globalCount++;
  }
  void run(float param) {
    update(param);
    //bounce();
    //display();
  }
  void update(float param) {
    //loc.add(vel);
    loc=PVector.lerp(start,end,map(sin(a+param),-1,1,0.1,0.3));
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
