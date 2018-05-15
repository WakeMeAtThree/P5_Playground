import java.util.Collections;
import java.util.Comparator;
import java.util.List;

boolean displayPoints = false;
int div = 15;
float scl, shift, a;
List<PVector> modules = new ArrayList<PVector>();

void setup() {
  size(500, 500);
  background(0);
  scl = width/div;

  for (int x = 0; x < div; x++) {
    for (int y = 0; y < div; y++) {
      modules.add(new PVector(2*scl*x, 2*scl*y));
    }
  }
sortPoints();
}

void draw() {
  background(0);

  for (int i = 0; i < modules.size(); i++) {
    float param = 5.0*i/modules.size();
    float x = modules.get(i).x;
    float y = modules.get(i).y;
    module(x, y, scl, sin(a+param));
  }

  a+=0.05;
}

void module(float x, float y, float scl, float param) {
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

  edge(0, scl, true, false, param);
  edge(90, scl, true, false, param);
  edge(180, scl, true, false, param);
  edge(270, scl, true, false, param);

  edge(45, scl, false, true, param);
  edge(135, scl, false, true, param);
  edge(225, scl, false, true, param);
  edge(315, scl, false, true, param);
  popMatrix();
}

void edge(float angle, float scl, boolean move, boolean mirror, float param) {
  pushMatrix();
  rotate(radians(angle));
  if (mirror) rotate(map(param, -1, 1, 0, PI/2));
  if (move) translate(0, map(param, -1, 1, 0, -0.586*scl));

  elline(0, scl*1, 0.828*scl, param);
  popMatrix();
}


void elline(float x, float y, float r, float param) {
  pushMatrix();
  noStroke();
  fill(lerpColor(#0CFFD2, #D60043, map(param, -1, 1, 0, 1)));
  translate(x, y);
  ellipse(0, 0, r, r*0.1);
  popMatrix();
}


void sortPoints(){
  
  Collections.sort(modules, new Comparator<PVector>() {
    @Override
      public int compare(PVector lhs, PVector rhs) {
      double d1 = Math.hypot(lhs.x - width/2, lhs.y - height/2);
      double d2 = Math.hypot(rhs.x - width/2, rhs.y - height/2);
      return d1 < d2 ? -1 : (d1 == d2 ? 0 : 1);
    }
  }
  );
}