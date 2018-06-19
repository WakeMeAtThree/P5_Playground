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
}

void draw() {
  background(255);
  scale(0.5);

  if (a == 1) {
    toggle = !toggle;
    a = 0;
  }
  for (int i = 0; i < s.getChild(0).getVertexCount(); i++) {
    PVector v_init = init_verts.get(i);
    PVector v_target;
    v_target = target_verts.get(i);

    PVector mix = PVector.lerp(v_init, v_target, 3*sin(a));

    s.getChild(0).setVertex(i, mix);
  }
  a+=0.02;
  s.disableStyle();
  pushStyle();
  //noFill();
  fill(255);
  stroke(0);
  strokeWeight(2);
  PShape curve = s.getChild(0);
  for (int i = -1; i < 30; i++) {
    for (int j = -1; j < 30; j++) {
      if (j % 2 == 0) {
        shape(curve, coords.x*i, coords.y*j);
      } else {
        shape(curve, coords.x*i-coords.x/2, coords.y*j);
      }
    }
  }
  popStyle();

  saveFrame("animation/output####.jpg");
  if (mousePressed) println(mouseX, mouseY);
}

void mousePressed() {
  coords = new PVector(mouseX, mouseY);
}
