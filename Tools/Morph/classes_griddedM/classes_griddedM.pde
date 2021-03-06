/*
 Hi. 
 This is Ali. 
 I'm writing this on 2018-06-30. I wrote these classes to help me 
 make motion based patterns in a more streamlined approach. I hope
 others can benefit from it as well.
 TO DO:
 - Fix numbering to start with 0 for
 keyFrames order and parts
 */

ArrayList<Morph> data;
DataLoader uno;
Morph due;
float a,globalMult;

void setup() {
  size(400, 400, P3D);
  boolean isItACurve = false;
  //Initializing morph list
  data = new ArrayList<Morph>();

  //DataLoader(number of keyFrames, number of parts in each keyFrame, true for Curves/else for Meshes
  uno = new DataLoader(2, 27, isItACurve);  
  uno.scale(2);
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
  lights();

  //module(a);
  int[] xRange = {-6,6};
  float xSpacing = 55;
  
  int[] yRange = {-6,6};
  float ySpacing = 35;
  grid("HEX",xRange,yRange,xSpacing,ySpacing);
  globalMult = 0.35*sin(a);
  a += 0.020;
}

void module(float a) {
  pushMatrix();

  //Module rotation and
  //shearing take place here

  rotateX(PI/4);
  rotateZ(PI/4+func(3,a,1));
  for (Morph due : data) {
    due.display(a);
  }
  popMatrix();
}

void grid(String type,int[] x, int[] y,float xSpace, float ySpace) {
  int totalCount = x[0]+x[1]+y[0]+y[1]+1;
  if (type == "RECT") {
    for (int i = x[0]; i < x[1]+1; i++) {
      for (int j = y[0]; j < y[1]+1; j++) {
        float param = globalMult*(i+j)/totalCount;

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
        float param = globalMult*(i+j)/totalCount;

        //Module translations/copies
        //take place here

        pushMatrix();
        if(j % 2 == 0) {
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
}
