class Ball {
  PVector loc, vel, acc;
  Ball(PVector loc_) {
    loc = loc_;
    float angle = random(TWO_PI);
    vel = new PVector(cos(angle), sin(angle));
    //acc = new PVector(random(width),random(height));
  }
  void run() {
    update();
    bounce();
    display();
  }
  void update() {
    acc = PVector.random2D(); 
    vel.add(acc);
    loc.add(vel);
    vel.limit(10);
    
  }

  void bounce() {
    if (loc.x > width/2 || loc.x < -width/2) vel.x *= -1;
    if (loc.y > height/2 || loc.y < -height/2) vel.y *= -1;
  }
  
  void display(){
    point(loc.x,loc.y);
  }
}