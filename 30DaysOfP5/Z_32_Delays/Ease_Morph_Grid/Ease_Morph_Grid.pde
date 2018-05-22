PShape s, init, target;
float a;
ArrayList<PVector> init_verts, target_verts;
boolean toggle;
PVector coords;

void setup() {
  size(500, 500);
  background(255);
  blendMode(DIFFERENCE);
  s = loadShape("TriCircSmooth.svg");
  frameRate(30);

  init_verts = new ArrayList<PVector>();
  target_verts = new ArrayList<PVector>();

  for (int i = 0; i < s.getChild(0).getVertexCount(); i++) {
    init_verts.add(s.getChild(0).getVertex(i).copy());
  }
  for (int i = 0; i < s.getChild(1).getVertexCount(); i++) {
    target_verts.add(s.getChild(1).getVertex(i).copy());
  }

  //init_vertices s.getChild(0);
  //target = s.getChild(1);
  //coords=new PVector(284, 252);
  //coords=new PVector(527, 274);
  coords = new PVector(447,211);
  toggle = true;
}

void draw() {
  background(255);
  scale(0.25);


  a+=0.025;
  s.disableStyle();
  pushStyle();

  noStroke();
  strokeWeight(2);


  for (int i = -1; i < 30; i++) {
    for (int j = -1; j < 30; j++) {
      float param = 3.5 * (i+j)/60;
      if (j % 2 == 0) {
        module(coords.x*i, coords.y*j, a+param);
      } else {
        module(coords.x*i-coords.x/2, coords.y*j, a+param);
      }
    }
  }
  popStyle();

  if (mousePressed) println(mouseX, mouseY);
}

void module(float x, float y, float a) {
  color fillColor = lerpColor(color(243, 105, 45), color(143, 23, 183), cs(a)); 
  fill(fillColor);
  for (int i = 0; i < s.getChild(0).getVertexCount(); i++) {
    PVector v_init = init_verts.get(i);
    PVector v_target;
    v_target = target_verts.get(i);
    PVector mix = PVector.lerp(v_init, v_target, map(cs(a), -1, 1, 0, 3));
    s.getChild(0).setVertex(i, mix);
  }

  PShape curve = s.getChild(0);
  shape(curve, x, y);
}

void mousePressed() {
  coords = new PVector(mouseX, mouseY);
}

// Set of ease functions I learnt from Dave Whyte's sketches

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