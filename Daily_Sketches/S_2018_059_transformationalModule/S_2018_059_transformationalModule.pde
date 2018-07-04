/*
 Hi. 
 This is Ali. 
 I'm writing this on 2018-06-30. I wrote these classes to help me 
 make motion based patterns in a more streamlined approach. I hope
 others can benefit from it as well.
 
 TO DO:
 - Fix numbering to start with 0 for
 keyFrames order and parts
 - radial delay/grid delay funcs
 - Combine all your interpolation methods
 - Start using glsl
 */


ArrayList<Morph> data;
DataLoader uno;
Morph due;
float a, globalMult;


void setup() {
  size(400, 400, P3D);
  smooth(8);
  background(0);
  boolean isItACurve = true;
  //Initializing morph list
  data = new ArrayList<Morph>();

  //DataLoader(number of keyFrames, number of parts in each keyFrame, true for Curves/else for Meshes
  uno = new DataLoader(5, 1, isItACurve);  
  uno.scale(85);
  due = new Morph(uno, isItACurve);
  data.add(due);

  //Constant display settings
  noStroke();
  smooth(8);
  ortho();

}

void draw() {
  background(0);

  translate(width/2, height/2);
  light();

  module(a); //Viewing a single module

  //Grid parameters setup
  //int[] xRange = {-6, 6};
  //float xSpacing = 91;
  //println(mouseX,mouseY);
  //int[] yRange = {-6, 6};
  //float ySpacing = 64;
  //grid("HEX", xRange, yRange, xSpacing, ySpacing);
  globalMult = 0.15;

  //Animate
  //if (a>=TWO_PI) exit();
  if(a>=1) exit();
  //saveFrame("output/animation###.png");
  a += 0.005;

}
float maxVal(float v1, float v2){
  float[] output = {v1,v2};
  return max(output);
}
void module(float a) {
  pushMatrix();

  //Module rotation and
  //shearing take place here

  //rotateX(PI-PI/4);
  //rotateZ(lerp(0,PI,map(cs(a),-1,1,0,1)));
  //rotateY(lerp(PI/4,-PI/4,map(cs(a),-1,1,0,1)));
  
  scale(lerp(1,0.25,fract(a)));
  //scale(lerp(1,0.25,smoothstep(0.2,0.5,fract(a))));
  rotate(lerp(0,PI,smoothstep(0.05,0.35,fract(a))));
  for (Morph due : data) {
    due.display(a);
  }
  popMatrix();
}

void grid(String type, int[] x, int[] y, float xSpace, float ySpace) {
  int totalCount = x[0]+x[1]+y[0]+y[1]+1;
  if (type == "RECT") {
    for (int i = x[0]; i < x[1]+1; i++) {
      for (int j = y[0]; j < y[1]+1; j++) {
        float param = gridDelay(i, j, totalCount);

        //Module translations/copies
        //take place here

        pushMatrix();
        translate(xSpace*i, ySpace*j, 0);
        module(a+param);
        popMatrix();
      }
    }
  } else if (type == "HEX") {
    for (int i = x[0]; i < x[1]+1; i++) {
      for (int j = y[0]; j < y[1]+1; j++) {
        float param = gridDelay(i, j, totalCount);

        //Module translations/copies
        //take place here

        pushMatrix();
        if (j % 2 == 0) {
          translate(xSpace*i, ySpace*j, 0);
        } else {
          translate(xSpace*i+xSpace/2, ySpace*j, 0);
        }
        module(a+param);
        popMatrix();
      }
    }
  }
}

void light() {
  //Fancy lighting setup goes here
  lights();
  //noLights();
  float dirY = (50 / float(height) - 0.5) * 2;
  float dirX = (105 / float(width) - 0.5) * 2;
  directionalLight(180, 180, 180, -dirX, -dirY, -1);
}
