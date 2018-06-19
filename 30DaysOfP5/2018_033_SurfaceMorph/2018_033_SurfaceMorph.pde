PShape init, target;
PVector[][] init_verts, target_verts;
float a;

void setup() {
  size(500, 500, P3D);
  smooth(8);
  background(0);
  strokeWeight(0.008);
  stroke(0,20);

  init = loadShape("init.obj");
  init.disableStyle();
  
  target = loadShape("target.obj");
  target.disableStyle();
  
  init.setFill(color(255, 0, 127));
  init.setStroke(color(0));

  init_verts = new PVector[init.getChildCount()][4];
  target_verts = new PVector[target.getChildCount()][4];

  //loadShape apparently loads obj files where each child is a face, which is not what I expected. 
  //Hopefully there's a way where faces are welded and you can iterate over objs in a nicer way
  //or a mesh datastructure perhaps.

  //Copy vertices to ArrayLists
  for (int i = 0; i < init.getChildCount(); i++) {
    for (int j = 0; j < init.getChild(i).getVertexCount(); j++) {
      init_verts[i][j] = (init.getChild(i).getVertex(j).copy());
      target_verts[i][j] = (target.getChild(i).getVertex(j).copy());
    }
  }

}

void draw() {
  background(20);
  
  //Morph
  for (int i = 0; i < init.getChildCount(); i++) {
    float param1 = 1.0 * (i)/(init.getChildCount());
    for (int j = 0; j < init.getChild(i).getVertexCount(); j++) {
      float param2 = 0.0 * (j)/init.getChild(i).getVertexCount();
      PVector v_init = init_verts[i][j];
      PVector v_target = target_verts[i][j];

      PVector mix = PVector.lerp(v_init, v_target, map(cs(0.5*a+param1+param2), -1, 1, 0, 1));
      init.getChild(i).setVertex(j, mix);
    }
  }

  //Light settings
  lights();

  //Setting up coordinate system
  translate(width/2, height/2, 0);
  rotateY(PI/2);
  scale(180);

  //Display  
  beginShape(QUADS);
  for (int i = 0; i < init.getChildCount(); i++) {
    float param1 = 1.0 * i/init.getChildCount();
    for (int j = 0; j< init.getChild(i).getVertexCount(); j++) {
      float param2 = 1.0 * (j)/init.getChild(i).getVertexCount();
      PVector vec = init.getChild(i).getVertex(j);
      fill(lerpColor(#0CFFD2, #D60043, map(cs(0.5*a+param1+param2), -1, 1, 0, 1)));
      vertex(vec.x, vec.y, vec.z);
    }
  }
  endShape();
  
  //Animate
  a += 0.04;
  
  //Save
  if(a >= 2*TWO_PI) exit();
  //saveFrame("output/animation###.png");
}

// Set of ease functions below borrowed from Dave Whyte's sketches

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