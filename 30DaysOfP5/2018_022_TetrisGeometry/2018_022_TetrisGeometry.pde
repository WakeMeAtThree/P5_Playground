int[][] choices = {{0, 1, 2, 3}, 
                   {0, 3, 2, 1}, 
                   {1, 2, 3, 0}, 
                   {1, 0, 3, 2}, 
                   {2, 1, 0, 3}, 
                   {2, 3, 0, 1}, 
                   {3, 2, 1, 0}, 
                   {3, 0, 1, 2}};

void setup() {
  size(400, 400);
  background(0);
  colorMode(HSB,1,1,1,1);
  noLoop();
}


void draw() {
  twobytwo();
}

void keyPressed() {
  redraw();
}

void twobytwo() {  
  ArrayList<PVector> pointslist;
  int[] options = choices[floor(random(choices.length-1))];

  PVector[] points = {new PVector(0, 0), 
                      new PVector(width/2, 0), 
                      new PVector(0, height/2), 
                      new PVector(width/2, height/2)};

  // 0
  PVector p0 = points[options[0]];
  fill(0.2, 1, 1);
  rect(p0.x, p0.y, width/2, height/2);

  // 1
  PVector p1 = points[options[1]];
  //fill(255, 1, 1);
  rect(p1.x, p1.y, width/2, height/2);

  // 2
  PVector p2 = points[options[2]];
  //fill(255, 1, 1);
  rect(p2.x, p2.y, width/2, height/2);

  // 3
  PVector p3 = points[options[3]];
  fill(0.8, 1, 1);
  rect(p3.x, p3.y, width/2, height/2);
}