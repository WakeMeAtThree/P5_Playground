
PShape init, target;
PVector[][] init_verts, target_verts;
PShader s;

float a, rx, ry;

void setup() {
  size(640, 640, P3D);
  smooth(8);
  background(0);
  s = loadShader("blur.glsl");

  init = loadShape("init2.obj");
  target = loadShape("target2.obj");

  init.setFill(color(255, 0, 127, 255));
  init.setStroke(color(0));

  init_verts = new PVector[init.getChildCount()][4];
  target_verts = new PVector[target.getChildCount()][4];

  //loadShape apparently loads obj files where each child is a face, which is lame. 
  //Hopefully there's a way where faces are welded and you can iterate over objs in a nicer way

  for (int i = 0; i < init.getChildCount(); i++) {
    for (int j = 0; j < init.getChild(i).getVertexCount(); j++) {
      init_verts[i][j] = (init.getChild(i).getVertex(j).copy());
      target_verts[i][j] = (target.getChild(i).getVertex(j).copy());
    }
  }



  //target_verts = new PVector[][];
}

void draw() {
  background(20);

  //Morph
  for (int i = 0; i < init.getChildCount(); i++) {
    float param1 = 1.0*i/init.getChildCount();
    for (int j = 0; j < init.getChild(i).getVertexCount(); j++) {
      float param2 = 1.0 * (j)/init.getChild(i).getVertexCount();
      PVector v_init = init_verts[i][j];
      PVector v_target = target_verts[i][j];

      PVector mix = PVector.lerp(v_init, v_target, map(cs(0.5*a+param1+param2), -1, 1, 0, 1));
      init.getChild(i).setVertex(j, mix);
    }
  }

  //Light settings
  float dirY = (height/2 / float(height) - 0.5) * 2;
  float dirX = (width/2 / float(width) - 0.5) * 2;
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  lights();
  lightSpecular(255, 255, 255);

  //Setting up coordinate system
  translate(width/2, height/2, 0);
  rotateZ(PI);
  rotateY(ry);
  rotateX(rx);
  scale(3.5);

  //Display settings
  init.disableStyle();
  target.disableStyle();
  noFill();
  strokeWeight(0.5);

  stroke(0, 50);

  //Display
  beginShape(QUADS);
  for (int i = 0; i < init.getChildCount(); i++) {
    float param1 = 1.0*i/init.getChildCount();
    for (int j = 0; j < init.getChild(i).getVertexCount(); j++) {
      float param2 = 1.0 * (j)/init.getChild(i).getVertexCount();
      fill(lerpColor(#0CFFD2, #D60043, map(cs(0.5*a+param1+param2), -1, 1, 0, 1.5)));
      PVector vec = init.getChild(i).getVertex(j);
      vertex(vec.x, vec.y, vec.z);
      //shape(init.getChild(i));
    }
  }
  endShape();
  //shape(init);
  //shape(target);

  //Animate
  ry += 0.04;
  //rx += 0.01;
  a += 0.04;
  
  //Save
  if(a >= 2*TWO_PI) exit();
  //saveFrame("output/animation###.png");
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