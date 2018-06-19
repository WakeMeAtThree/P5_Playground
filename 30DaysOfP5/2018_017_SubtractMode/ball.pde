class Ball {
  PVector loc, vel;
  float r1, r2;
  Ball(PVector loc_) {
    loc = loc_;

    float angle = random(PI);
    vel = new PVector(cos(angle), 
      sin(angle)).mult(0);
    //vel = new PVector();
    //r = 50;
  }

  void run(float speed) {
    move(speed);
    bounce();
    display();
  }
  void move(float speed) {
    loc.add(vel);
    //r1 = map(sin(speed*1),-1,1,15,65);
    //r2 = map(cos(speed*0.5),-1,1,14,65);
    //r1 = map(sin(speed*1.4), -1, 1, 65, 15);
    //r2 = map(sin(speed*1.8+1.13), -1, 1, 65, 15);
    float radius = 1.0;
    r1 = map(2*cos(speed),-2,2,15,65);
    r2 = map(2*sin(speed),-2,2,15,65);
    
  }

  void bounce() {
    if (loc.x > width || loc.x < 0) vel.x *= -1;
    if (loc.y > height || loc.y < 0) vel.y *= -1;
  }

  void display() {
    pushStyle();
    blendMode(DIFFERENCE);
    fill(255);
    ellipse(loc.x, loc.y, r1, r2);
    popStyle();
  }
}