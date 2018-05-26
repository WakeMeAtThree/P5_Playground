class Morph {
  ArrayList<PVector> initial, blend, target;
  boolean even;

  Morph(PShape curves) {
    initial = new ArrayList<PVector>();
    blend = new ArrayList<PVector>();
    target = new ArrayList<PVector>();

    for (int i = 0; i < curves.getChild(0).getVertexCount(); i++) {
      initial.add(curves.getChild(0).getVertex(i).copy());
      blend.add(curves.getChild(0).getVertex(i).copy());
      target.add(curves.getChild(1).getVertex(i).copy());
    }
  }

  void morph(float time, float param) {
    for (int i = 0; i < blend.size(); i++) {
      PVector v_init = initial.get(i);
      PVector v_target = target.get(i);

      PVector mix = PVector.lerp(v_init, v_target, map(cs(a+param), -1, 1, 0, 1));
      blend.set(i, mix);
    }
  }

  void display(float x, float y, float scl) {
    noStroke();
    fill(255);
    pushMatrix();
    translate(x, y);
    if (mousePressed) println(mouseX);
    scale(scl);

    beginShape();
    for (PVector p : blend) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}