PShape s, init, target;
float a;
ArrayList<PVector> init_verts, target_verts;
boolean toggle;
PVector coords;

void setup() {
  size(500, 500);
  background(255);
  blendMode(DIFFERENCE);
  s = loadShape("TriCircFix.svg");
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
  coords=new PVector(284, 252);
  toggle = true;
  s.disableStyle();
}

void draw() {
  background(255);
  scale(1);
  for (int i = 0; i < s.getChild(0).getVertexCount(); i++) {
    PVector v_init = init_verts.get(i);
    PVector v_target;
    v_target = target_verts.get(i);
    
    PVector mix = PVector.lerp(v_init, v_target, 3*cs(a));
    s.getChild(0).setVertex(i, mix);
  }
  
  pushStyle();
    fill(255);
    stroke(0);
    strokeWeight(2);
    PShape curve = s.getChild(0);
    shape(curve, coords.x, coords.y);
  popStyle();
  
  a+=0.02;
  
  if (mousePressed) println(mouseX, mouseY);
}

void mousePressed() {
  coords = new PVector(mouseX, mouseY);
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