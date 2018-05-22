PShape s, init, target;
float a;
ArrayList<PVector> init_verts, target_verts;
boolean toggle;

void setup() {
  size(500, 500);
  background(255);
  s = loadShape("TriCirc.svg");
  frameRate(30);
  // blendMode(DIFFERENCE);
  
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
  
  toggle = true;
}

void draw() {
  //background(100);

  pushStyle();
  fill(255, 50);
  noStroke();
  rect(0, 0, width, height);

  popStyle();

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
  a+=0.1;
  s.disableStyle();
  pushStyle();
  noFill();
  stroke(0);
  strokeWeight(2);

  shape(s, 0, 0, width, height);
  popStyle();
  
  //if(a <= 4*TWO_PI) saveFrame("animation/output####.jpg");d
}
