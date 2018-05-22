
PShape init, target;
PVector[][] init_verts, target_verts;
PShader s;

float a, rx, ry;

public void setup() {
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

public void draw() {
  //Blurred background
  background(20);

  filter(s);

  pushStyle();
  //fill(20, 35);
  //rect(0, 0, width, height);
  popStyle();


  //Morph
  for (int i = 0; i < init.getChildCount(); i++) {
    for (int j = 0; j < init.getChild(i).getVertexCount(); j++) {
      float param = 2.0 * (i+j)/4024;
      PVector v_init = init_verts[i][j];
      PVector v_target = target_verts[i][j];

      PVector mix = PVector.lerp(v_init, v_target, map(sin(0.5*a+param), -1, 1, 0, 1));
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
  strokeWeight(1.5);
  
  stroke(0, 50);

  //Display
  for (int i = 0; i < init.getChildCount(); i++) {
    float param = 1.0 * i/init.getChildCount();
    fill(lerpColor(#0CFFD2, #D60043, map(sin(0.5*a+param), -1, 1, 0, 1.5)));
    //shape(init.getChild(i));
  }
  shape(init);
  //shape(target);

  //Animate
  ry += 0.05;
  rx += 0.01;
  a += 0.05;
}
