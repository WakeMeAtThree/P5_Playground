//Fuzzy sketch written as a demonstration of
//generating/sketching ideas 

float radius = 50;

void setup() {
  size(400, 700);
  noLoop();
}

void draw() {
  background(255);
  //Move origin to center
  translate(width/2, radius+25);

  //Testing ideas out, uncomment one by one to check
  stroke(0);
  ellipse(0, 0, radius*2, radius*2);
  translate(0, 2*radius+25);
  idea1();
  translate(0, 2*radius+25);
  idea2();
  translate(0, 2*radius+25);
  idea3();
  translate(0, 2*radius+25);
  idea4();

  //saveFrame("output/test.png");
}
void idea1() {
  stroke(0, 50);
  for (int i = 0; i < 1500; i++) {
    float angle = random(TWO_PI);
    PVector vec = new PVector(cos(angle), sin(angle));
    PVector vecScaled = vec.copy().mult(random(15)+random(radius));
    vec=vec.mult(radius+random(0, random(25)));
    line(vecScaled.x, vecScaled.y, vec.x, vec.y);
  }
}

void idea2() {
  beginShape();
  stroke(0, 250);
  noFill();
  for (int i = 0; i < 150; i++) {
    float angle = random(TWO_PI);
    float r = random(radius-10, radius);
    curveVertex(r*cos(angle), r*sin(angle));
  }
  endShape();
}
void idea3() {

  for (int j = 0; j < 500; j++) {
    beginShape();
    stroke(0, 100);
    noFill();
    for (int i = 0; i < 4; i++) {
      float angle = random(TWO_PI);
      float r = random(0, radius);
      curveVertex(r*cos(angle), r*sin(angle));
    }
    endShape();
  }
}

void idea4() {
  stroke(0, 50);
  for (int i = 0; i < 1500; i++) {
    float angle = random(TWO_PI);
    ArrayList<PVector> pointsList = new ArrayList<PVector>();
    PVector vec = new PVector(cos(angle), sin(angle));
    PVector vecScaled = vec.copy().mult(random(radius));
    vec=vec.mult(radius);
    pointsList.add(vec);
    pointsList.add(vecScaled);
    pointsList.add(new PVector(cos(angle+0.25), sin(angle+0.25)).mult(random(15)+random(radius)));
    pointsList.add(new PVector(cos(angle+0.25), sin(angle+0.25)).mult(random(15)+random(radius)));
    beginShape();
    for (PVector p : pointsList) {
      curveVertex(p.x, p.y);
    }
    endShape();
    //line(vecScaled.x, vecScaled.y, vec.x, vec.y);
  }
}

void keyPressed() {
  redraw();
}
