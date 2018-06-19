Morph sketch;
float a, scl;

void setup() {
  size(400, 400);
  smooth(8);
  blendMode(DIFFERENCE);
  sketch = new Morph(loadShape("TritoHex.svg"));
  scl = 1;
}

void draw() {
  background(0);
  translate(width/2, height/2);
  scale(13);

  pattern(5, 5, PI);

  pushMatrix();
  translate(4.9/2, 0);
  rotate(PI);
  pattern(5, 5, 0);
  popMatrix();
  
  //if (a > TWO_PI) exit();
  //saveFrame("output/animation###.png");
  a+=0.05;
}
void pattern(int tileX, int tileY, float shift) {
  for (int i = -tileX; i < tileX; i++) {
    for (int j = -tileY; j < tileY; j++) {
      float param = 5.0*(i+j)/10;
      sketch.morph(a, param+shift);
      //fill(lerpColor(#FFFFFF,#c7c7c7,1-sin(a+2.0*param+shift)));
      if (j % 2 == 0) {
        sketch.display(i*4.9, j*4.3);
      } else {
        sketch.display(i*4.9+4.9/2, j*4.3);
      }
    }
  }
}
// Set of functions taken from Dave Whyte's sketches

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
