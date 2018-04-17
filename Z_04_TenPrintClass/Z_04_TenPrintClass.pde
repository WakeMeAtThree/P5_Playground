class TenPrint {
  float x;
  float y;
  float space;
  float tolerance;

  TenPrint(float x_, float y_, float space_) {
    x = x_;
    y = y_;
    space = space_;
    tolerance = 0.5;
  }

  void run() {
    update();
    display();
  }

  void update() {
    //Update X across the canvas
    x = x+space;

    //Wrap x,y around (torroidal)
    if (x > width) {
      x = 0;
      y = y+space;
    }
    if (y > height) {
      x = 0;
      y = 0;
    }
  }

  void display() {
    //Color and weight settings
    strokeWeight(10);
    stroke(random(0, 0.1), 0.9, 0.9, 0.8);

    //The crux of the print algorithm, switch direction based on tolerance
    if (Math.random() > tolerance) {
      line (x, y, 
        x+space, y+space);
    } else {
      line (x, y+space, 
        x+space, y);
    }
  }
}