class Springy {
  PVector p1, p2;
  float delay1,delay2;
  float r1,r2;
  float speed1,speed2;
  int resolution;
  ArrayList<PVector> controlPoints;

  Springy(PVector p1, PVector p2, int resolution) {
    this.resolution = resolution;
    
    this.p1 = p1;
    this.p2 = p2;
    
    this.delay1 = random(15);
    this.delay2 = random(15);
    
    this.r1 = 25;
    this.r2 = 25;
    
    this.speed1 = random(3);
    this.speed2 = random(3);
    
    controlPoints = new ArrayList<PVector>();
  }
  
  void coil() {
    controlPoints = new ArrayList<PVector>();
    for (int i = 0; i <= resolution; i++) {
      float param = 1.0*i/resolution;
      PVector _p1 = P(p1, r1, this.speed1*time+param*delay1);
      PVector _p2 = P(p2, r2, this.speed2*time+param*delay2);
      this.controlPoints.add(PVector.lerp(_p1, _p2, param));

      //Display
    }
  }

  void display() {
    PVector point1 = this.controlPoints.get(0);
    PVector point2 = this.controlPoints.get(resolution);
    noStroke();
    ellipse(point1.x, point1.y, 5, 5);
    ellipse(point2.x, point2.y, 5, 5);
    
    pushStyle();
    stroke(255,150);
    noFill();
    //beginShape();
    for (int i = 0; i < this.controlPoints.size(); i++) {
      float param = 1.0 * i/this.controlPoints.size();
      PVector p = this.controlPoints.get(i);
      stroke(lerpColor(#FF0000,#0000FF,param));
      strokeWeight(3);
      point(p.x, p.y);
    }
    //endShape();

    popStyle();
  }

  PVector P(PVector loc, float r, float shift) {
    return new PVector(r*cos(time+shift)+loc.x+4.51*cos(time+shift+1.24), r*sin(time+shift)+loc.y);
  }
}
