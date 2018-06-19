PVector current, display, target;
Polar currentP, displayP, targetP;
float a;
boolean toggle;

void setup() {
  size(400, 400);
  background(255);
  //blendMode(DIFFERENCE);
  
  target = new PVector(random(width), random(height));
  
  targetP = new Polar(random(200),random(TWO_PI));
  currentP = new Polar(0,0);
  displayP = new Polar(0,0);
  
  current = new PVector(0, 0);
  
  display = current.copy();
  println(current.x);
}

void draw() {

  strokeWeight(random(3,5));
  noStroke();
  fill(0,50);
  
  //Ortho lerp
  //if (!toggle) {
  //  display.x = lerp(current.x, target.y, a);
  //} else {
  //  display.y = lerp(current.y, target.y, a);
  //}
  
  //Diagonal lerp random? walk
  //display = PVector.lerp(current,target,a);
  
  
  //Curvey Lerp
  translate(width/2,height/2);
  float radius = lerp(currentP.radius,targetP.radius,a);
  float angle = lerp(currentP.angle,targetP.angle,a);
  displayP = new Polar(radius,angle);
  
  ellipse(displayP.x, displayP.y,5,5);

  a += 0.01;
  if (a > 1) {
    target = new PVector(random(width), random(height));
    targetP = new Polar(random(200),random(TWO_PI));
    currentP = displayP;
    current = display.copy();
    a=0;
    toggle = !toggle;
  }
}
