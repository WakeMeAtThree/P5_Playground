Morph sketch;
float a, scl;

void setup() {
  size(400, 400);
  blendMode(DIFFERENCE);
  sketch = new Morph(loadShape("TritoCirc.svg"));
  scl = 1;
}

void draw() {
  background(255);
  translate(width/2, height/2);
  scl = constrain(1.0*mouseX/width,0.2,1);
  
  for (int i = -5; i < 5; i++) {
    for (int j = -5; j < 5; j++) {
      float param = 4.0*(i+j)/(82);
      sketch.morph(a, param);
      if (j % 2 == 0) {
        sketch.display(i*280*scl, j*245*scl, scl);
      } else {
        sketch.display(i*280*scl-(280*scl/2), j*245*scl, scl);
      }
    }
  }

  a+=0.025;
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
