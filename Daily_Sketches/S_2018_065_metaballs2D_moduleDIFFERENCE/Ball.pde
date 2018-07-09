class Ball {
  PVector loc, vel;
  float diameter;
  color hello;
  PVector start,end;
  Ball(PVector start, PVector end) {
    
    loc = new PVector(random(width), random(height));
    vel = new PVector(random(-1, 1), random(-1, 1)).mult(7);
    diameter = 55;
    //hello = 
    color[] colorOptions = {#0EC0E1, #DD3A7C,#DD3A7C};
    hello=colorOptions[floor(random(3))];
    ///
    this.start = start;
    this.end = end;
  }
  void run(float param) {
    update(param);
    //bounce();
    //display();
  }
  void update(float param) {
    //loc.add(vel);
    loc=PVector.lerp(start,end,map(cs(a*param),-1,1,0,1));
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
