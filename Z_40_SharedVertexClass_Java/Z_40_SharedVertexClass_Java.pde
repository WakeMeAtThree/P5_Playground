Mesh initial, blend, target;
float a;

void setup() {
  size(400, 400, P3D);
  smooth(8);
  initial = new Mesh(loadShape("mesh1.obj"));
  blend = new Mesh(loadShape("mesh1.obj"));
  target = new Mesh(loadShape("mesh2.obj"));
}

void draw() {
  fill(lerpColor(#0EC0E1, #DD3A7C, 1-map(cs(a), -1, 1, 0, 1)));
  noStroke();
  rect(0, 0, width, height);
  lights();
  
  //Morph
  blend.morph(initial, target, a);

  //Move origin
  translate(width/2, height/2, 0);
  rotateX(PI-PI/8);
  rotateY(a);
  scale(90);

  //Display
  blend.display(a);
  a+=0.05;
  
  //Save Frames
  if(a > TWO_PI) exit();
  //saveFrame("output/animation###.png");
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
  return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 5));
}