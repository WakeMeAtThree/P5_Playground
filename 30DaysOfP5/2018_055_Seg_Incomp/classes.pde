
class Segment {
  PVector p1, p2;
  float len;
  Segment(float len, float rot, PVector pos) {
    this.len = len;
    this.p1 = new PVector(-1, 0).mult(this.len).rotate(rot).add(pos);
    this.p2 = new PVector(1, 0).mult(this.len).rotate(rot).add(pos);
  }
  void display() {
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

class Torus {
  ArrayList<Segment> sections;
  Torus(float innerradius, float sectionradius, float[] resolution) {
    sections = new ArrayList<Segment>(); 

    for (int i = 0; i < resolution.length; i++) {
      float angle = TWO_PI*i/resolution.length;
      float x = innerradius*cos(angle);
      float y = innerradius*sin(angle);
      Segment a = new Segment(resolution[i], angle, new PVector(x, y));
      this.sections.add(a);
    }
  }
  void interpolate() {
    for (int j = 0; j < sections.size(); j++) {
      Segment a = sections.get(j%sections.size());
      PVector p1 = a.p1;
      PVector p2 = a.p2;
      Segment b = sections.get((j+1)%sections.size());
      PVector v1 = b.p1;
      PVector v2 = b.p2;

      line(p1.x, p1.y, p2.x, p2.y);
      line(v1.x, v1.y, v2.x, v2.y);

      float left = PVector.dist(p1, p2);
      float right = PVector.dist(v1, v2);
      
      for (int i = 0; i < 25; i++) {
        float param = 1.0*i/25;
        PVector b1 = PVector.lerp(p1, v1, param).mult(CosineInterpolate(left, right, param)/lerp(left, right, param));
        PVector b2 = PVector.lerp(p2, v2, param).mult(CosineInterpolate(left, right, param)/lerp(left, right, param));
        line(b1.x, b1.y, b2.x, b2.y);
      }
    }
  }
  void display() {
    for (Segment s : sections) {
      s.display();
    }
    for (int i = 0; i < sections.size(); i++) {
      PVector sec1p1 = sections.get(i%sections.size()).p1;
      PVector sec1p2 = sections.get((i+1)%sections.size()).p1;
      PVector sec2p1 = sections.get(i%sections.size()).p2;
      PVector sec2p2 = sections.get((i+1)%sections.size()).p2;
      stroke(255, 0, 0);
      //line(sec1p1.x, sec1p1.y, sec1p2.x, sec1p2.y);
      //line(sec2p1.x, sec2p1.y, sec2p2.x, sec2p2.y);
    }

  }
}
