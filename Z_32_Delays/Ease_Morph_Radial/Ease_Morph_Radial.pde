import java.util.Collections;
import java.util.Comparator;
import java.util.List;

PShape s, init, target;
float a;
ArrayList<PVector> init_verts, target_verts;
boolean toggle;
PVector coords;
List<PVector> modules = new ArrayList<PVector>();

void setup() {
  size(500, 500);
  background(255);
  //blendMode(DIFFERENCE);
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
  coords=new PVector(284, 252);
  //coords=new PVector(527, 274);
  //coords = new PVector(447, 211);
  toggle = true;

  for (int i = -15; i < 15; i++) {
    for (int j = -15; j < 15; j++) {
      float param = 3.5 * (i+j)/60;
      if (j % 2 == 0) {
        modules.add(new PVector(coords.x*i, coords.y*j));
      } else {
        modules.add(new PVector(coords.x*i-coords.x/2, coords.y*j));
      }
    }
  }
  sortPoints();
}

void draw() {
  background(255);



  a+=0.032;
  s.disableStyle();
  pushStyle();

  noStroke();
  strokeWeight(2);
  pushMatrix();
  translate(222, 222);
  scale(0.15);
  for (int i = 0; i < modules.size(); i++) {
    float param = 4.5 * i/modules.size();
    PVector loc = modules.get(i);
    module(loc.x, loc.y, a+param);
  }
  popMatrix();
  popStyle();
if(a >= TWO_PI) exit();
  //saveFrame("output/animation###.png");
  if (mousePressed) println(mouseX, mouseY);
}

void module(float x, float y, float a) {
  color fillColor = lerpColor(color(10, 159, 101,255), color(184, 27, 72,100), cs(a)); 
  fill(fillColor);
  for (int i = 0; i < s.getChild(0).getVertexCount(); i++) {
    PVector v_init = init_verts.get(i);
    PVector v_target;
    v_target = target_verts.get(i);
    PVector mix = PVector.lerp(v_init, v_target, map(cs(a), -1, 1, -0.2, 3.6));
    s.getChild(0).setVertex(i, mix);
  }

  PShape curve = s.getChild(0);
  shape(curve, x, y);
}

void mousePressed() {
  coords = new PVector(mouseX, mouseY);
}

// Sorting points list
void sortPoints() {

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