Table laurel, yanny;
ArrayList<PVector> laurelV,yannyV,morphV;
float scl,a,margin;

void setup() {
  size(500, 500);
  laurel = loadTable("laurel.csv");
  yanny = loadTable("yanny.csv");
  
  laurelV = new ArrayList<PVector>();
  morphV = new ArrayList<PVector>();
  yannyV = new ArrayList<PVector>();
  
  scl = 1.75;
  margin = 25;

  for (TableRow row : laurel.rows()) {
    float x = scl*row.getFloat(0);
    float y = -scl*row.getFloat(1)+height;
    laurelV.add(new PVector(x,y));
    morphV.add(new PVector(x,y));
  }

  for (TableRow row : yanny.rows()) {
    float x = scl*row.getFloat(0);
    float y = -scl*row.getFloat(1)+height;
    yannyV.add(new PVector(x,y));
  }
  println(yannyV.size());
}

void draw(){
  pushStyle();
    resetMatrix();
    noStroke();
    fill(lerpColor(#0099cc, #f2026d, map(cs(a), -1, 1, 0, 1)));//#0CFFD2, #D60043
    rect(0,0,width,height);
    fill(lerpColor(#0099cc, #f2026d, 1-map(cs(a), -1, 1, 0, 1)));
    rectMode(CORNERS);
    rect(0+margin,0+margin,width-margin,height-margin);
  popStyle();
  
  translate(-100,100);
  if(mousePressed) println(mouseX,mouseY);
  for(int i = 0; i < laurelV.size(); i++){
    float param = 3.0  *i/laurelV.size();
    PVector mix = PVector.lerp(laurelV.get(i),yannyV.get(i),map(cs(a+param),-1,1,0,1));
    strokeWeight(8);
    stroke(lerpColor(#0099cc, #f2026d, map(cs(a+param), -1, 1, 0, 1)));
    
    point(mix.x,mix.y);
  }
  
  a += 0.025;
}

// Set of ease functions below borrowed from Dave Whyte's sketches
// who's awesome enough to share it.

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