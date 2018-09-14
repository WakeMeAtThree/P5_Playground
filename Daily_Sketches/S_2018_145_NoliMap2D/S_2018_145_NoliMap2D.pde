import fisica.*;

FWorld world;
int count = 500;

void setup() {
  size(400, 400);
  smooth(8);

  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 0);
  
  FBox myBox = new FBox(40, 20);
  myBox.setPosition(width/3, height/3-10);
  myBox.setDensity(0.2);
  myBox.setNoFill();
  myBox.setStroke(0);
}

void draw() {
  background(255);
  if (frameCount%3==0) {
    if (count > 0) {
      addBox();
      count -= 1;
    }
  }
  world.step();
  world.draw();
}
void addBox() {
  FBox myBox = new FBox(random(2, 30), random(2, 30));
  myBox.setPosition(width/2, height/2);
  myBox.setDensity(0.2);
  myBox.setFill(random(1)>0.4?255:0);
  myBox.setStrokeWeight(random(2));
  myBox.setStroke(255);
  world.add(myBox);
}
