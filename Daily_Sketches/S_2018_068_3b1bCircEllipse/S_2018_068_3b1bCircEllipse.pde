float a;
void setup() {
  size(400, 400);
  smooth(8);
  strokeWeight(1.5);
  background(0);
  

}
void draw(){
  background(0);
  translate(width/2, height/2);
  Module();
  a+=0.03;
  //saveFrame("output/animation###.png");
  if(a >= TWO_PI)exit();
}


void Module(){
  float r = 155;
  int n = 75;
  float r_smaller = r-lerp(15,r,map(sin(a),-1,1,0,1));
  PVector somePoint = new PVector(r_smaller*cos(a), r_smaller*sin(a));
  strokeWeight(1.5);
  
  for (float i = 0; i < TWO_PI; i+= TWO_PI/n) {
    float param =3.0*i/TWO_PI/n;
    //Points on a circle
    PVector circ = new PVector(r*cos(i), r*sin(i));

    //Lines from Points on Circle to some point
    stroke(78);
    line(circ.x, circ.y, somePoint.x, somePoint.y);

    //Same lines rotate 90 degrees around their centers
    pushMatrix();
    PVector sub = PVector.sub(circ, somePoint).mult(0.5).add(somePoint);
    translate(sub.x, sub.y);
    rotate(PI/2);
    translate(-sub.x, -sub.y);
    stroke(255);
    line(somePoint.x, somePoint.y, circ.x, circ.y);
    popMatrix();
  }
  
  //Some point in yellow
  noStroke();
  fill(255, 255, 0);
  strokeWeight(2);
  ellipse(somePoint.x, somePoint.y, 10, 10);
  
  //Bounding circle
  noFill();
  stroke(#43b5c7);
  ellipse(0, 0, r*2, r*2);
}

// Set of ease functions below borrowed from Dave Whyte's sketches
// who's awesome enough to share it.

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float cs(float q) {
  return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 2));
}