PShape s;
ArrayList<PShape> curveslist;
float a;

void setup() {
  size(400, 400);
  curveslist = new ArrayList<PShape>();
  s = loadShape("hexy.svg");
  s.setFill(color(255,0,0));
  for (int i = 0; i < s.getChildCount(); i++) {
    curveslist.add(s.getChild(i));
  }
}

void draw() {
  //background(196);
  fill(196,1);
  noStroke();
  rect(0,0,width,height);
  
  float frequency = 0.9;
  float multiplier = 9.3;
  
  for (PShape s : curveslist) {
    
    for (int i = 0; i < s.getVertexCount(); i++) {
      PVector v = s.getVertex(i);
      float param = 1.0*i/s.getVertexCount();
      v.x += sin(a*frequency+param*multiplier)+random(-5,5);
      v.y += sin(a*frequency+param*multiplier)+random(-5,5);
      s.setVertex(i, v);
      
    }
  }
  a+=0.1;

  s.disableStyle();  
  fill(255,0,0,10);
  shape(s, 0, 0, width, height);
}