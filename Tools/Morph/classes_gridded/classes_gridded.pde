/*
 Hi. 
 This is Ali. 
 I'm writing this on 2018-06-30. I wrote these classes to help me 
 make motion based patterns in a more streamlined approach. I hope
 others can benefit from it as well.
 
 TODO LIST:
 - Recreate previous sketches using this new set of classes
 - Curves accomodating for inner and outer contour shapes OR split curves to accomodate different topologies
 */

ArrayList<PVector> vertices;
ArrayList<ArrayList<Curve>> curveStates;
ArrayList<Morph> data;
DataLoader uno;
Morph due;
float a;

void setup() {
  size(400, 400);

  //Initializing morph list
  data = new ArrayList<Morph>();

  //For loop to create a grid of DataLoader objects
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 6; j++) {
      //DataLoader(number of keyFrames, number of parts in each keyFrame, true for Curves/else for Meshes
      uno = new DataLoader(2, 27, false);  

      /* 
       Coordinate manipulation done on the vectors
       to avoid scaling/messing with strokeWeights default settings
       */

      uno.scale(35);
      uno.translate(new PVector(i*75, j*75));
      uno.waveShift = 1.0*(i+j)/6;

      due = new Morph(uno, true);
      data.add(due);
    }
  }
}

void draw() {
  background(255);
  noStroke();

  for (Morph due : data) {
    due.display(a);
  }

  a += 0.020;
}