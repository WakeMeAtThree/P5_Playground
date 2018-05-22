class Module {
  float x;
  float y;
  float scl;
  float param;

  Module(float x_, float y_, float scl_, float param_) {
    x = x_;
    y = y_;
    scl = scl_;
    param = param_;
  }
  void setParam(float value)
  {
    this.param = value;
  }

  void display() {
    pushMatrix();

    translate(x, y);
    if (displayPoints) {
      strokeWeight(4);
      stroke(255);
      //Origin
      point(0, 0);

      //Inner Square
      point(0, -0.414214*scl);
      point(0, 0.414214*scl);
      point(-0.414214*scl, 0);
      point(0.414214*scl, 0);

      //Outer square
      point(0, -1*scl);
      point(0, 1*scl);
      point(1*scl, 0);
      point(-1*scl, 0);
    }

    this.edge(0, scl, true, false, param);
    this.edge(90, scl, true, false, param);
    this.edge(180, scl, true, false, param);
    this.edge(270, scl, true, false, param);

    this.edge(45, scl, false, true, param);
    this.edge(135, scl, false, true, param);
    this.edge(225, scl, false, true, param);
    this.edge(315, scl, false, true, param);
    popMatrix();
  }

  void edge(float angle, float scl, boolean move, boolean mirror, float param) {
    pushMatrix();
    rotate(radians(angle));
    if (mirror) rotate(map(param, 0, 1, 0, PI/2));
    if (move) translate(0, map(param, 0, 1, 0, -0.586*scl));

    this.elline(0, scl*1, 0.828*scl, param);
    popMatrix();
  }

  void elline(float x, float y, float r, float param) {
    pushMatrix();
    noStroke();
    fill(lerpColor(#0CFFD2, #D60043, map(param, 0, 1, 0, 1)));
    translate(x, y);
    ellipse(0, 0, r, r*0.1);
    popMatrix();
  }
}