PVector current, display, target;
float a;
boolean toggle;

void setup() {
  size(400, 400);
  background(255);
  //blendMode(DIFFERENCE);
  target = new PVector(random(width), random(height));
  current = new PVector(0, 0);
  display = current.copy();
  println(current.x);
}

void draw() {

  strokeWeight(random(3,5));
  noStroke();
  fill(0,50);
  if (!toggle) {
    display.x = lerp(current.x, target.y, a);
  } else {
    display.y = lerp(current.y, target.y, a);
  }
  //Diagonal lerp random? walk
  //display = PVector.lerp(current,target,a);
  rect(display.x, display.y,15,15);

  a += 0.01;
  if (a > 1) {
    target = new PVector(random(width), random(height));
    current = display.copy();
    a=0;
    toggle = !toggle;
  }
}
