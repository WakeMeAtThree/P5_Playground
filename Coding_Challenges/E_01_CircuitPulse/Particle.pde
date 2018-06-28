class Particle {
  ArrayList<PVector> old = new ArrayList<PVector>();
  float x, y, ang, speed;
  int c, sz, tailLength;
  boolean dead = false;

  Particle(float x, float y, float ang, int c) {
    this.x = x;
    this.y = y;
    this.ang = ang;
    this.speed = 3;
    this.c = c;
    this.sz = 5;
    this.tailLength = 8;
  }

  void update() {
    if (random(1) > 0.95f) {
      if (random(1) > 0.5f) {
        ang += PI/4;
      } else {
        ang -= PI/4;
      }
    }

    old.add(new PVector(x, y));

    while (old.size() > tailLength) {
      old.remove(0);
    }

    x += cos(ang)*speed;
    y += sin(ang)*speed;

    if (old.get(0).x < 0 || old.get(0).x > width || old.get(0).y < 0 || old.get(0).y > height) {
      dead = true;
    }
  }

  void show() {
    fill(c, 255, 255);
    //ellipse(x, y, sz, sz);
    if (old.size() > 0) {
      for (int i = 0; i < old.size(); i++) {
        fill(c, 255, 255, map(i, 0, old.size() - 1, 0, 255)) ;
        ellipse(old.get(i).x, old.get(i).y, sz, sz);
      }
    }
  }
}