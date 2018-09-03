class Cell {
  PVector center;                      //Cell's centerpoint
  PVector A, B, C, D;                  //Cell's corners
  PVector E, F, G, H;                  //Extension to 3D corners
  PVector AB, AC, CD, BD;              //Cell's midpoints
  boolean[] boolVals = new boolean[4]; //Cell's corner containment booleans (if it's inside a ball)
  float[] cornerVals = new float[4];   //Values of sum for each corner

  float[] cornerReds = new float[4];
  float[] cornerGreens = new float[4];
  float[] cornerBlues = new float[4];
  PVector[] cornerColors = new PVector[4];

  float red, green, blue;              //Sum of RGB values for entire cell

  Cell(float x, float y, float spaceX, float spaceY) {
    //Center point
    center = new PVector(x, y);

    //Corner Points
    A = center.copy().add(new PVector(-spaceX/2, -spaceY/2, 0));
    B = center.copy().add(new PVector(spaceX/2, -spaceY/2, 0));
    C = center.copy().add(new PVector(-spaceX/2, spaceY/2, 0));
    D = center.copy().add(new PVector(spaceX/2, spaceY/2, 0));

    //Mid Points
    AB = center.copy().add(new PVector(0, -spaceY/2, 0));
    CD = center.copy().add(new PVector(0, spaceY/2, 0));
    AC = center.copy().add(new PVector(-spaceX/2, 0, 0));
    BD = center.copy().add(new PVector(spaceX/2, 0, 0));
  }
  PVector getColor(PVector V) {
    //cornerVals = {C, D, B, A};
    if (V == C) {
      return cornerColors[0];
    }
    if (V == D) {
      return cornerColors[1];
    }
    if (V == B) {
      return cornerColors[2];
    }
    if (V == A) {
      return cornerColors[3];
    }
    return new PVector(0, 0, 0);
  }
  PVector getMidColor(PVector V) {
    if (V == AB) {
      return interpolateColors(A, B);
    }
    if (V == AC) {
      return interpolateColors(A, C);
    }
    if (V == CD) {
      return interpolateColors(C, D);
    }
    if (V == BD) {
      return interpolateColors(B, D);
    }
    return new PVector(0, 0, 0);
  }

  PVector[] getCorners() {
    PVector[] output = {C, D, B, A};
    return output;
  }
  void addColors(ArrayList<Float> input, ArrayList<CellM> ballList, int index) {
    /*
    1. Reset r,g,b to zero every time
     2. Normalize weights
     3. Multiply each weight with their corresponding ball color contribution
     (OPTIONAL: there is room here to play around with smoothstep )
     4. Add them all up
     5. Divide it by the sum of the normalized weights
     */

    //this.red = 0;
    //this.green = 0;
    //this.blue = 0;
    //ArrayList<Float> normalizedStepVals = getNormalized(input);
    //float sumWeights = 0;

    //for (int i = 0; i < ballList.size(); i++) {
    //  color ballColor = ballList.get(i).ballColor;
    //  this.red += red(ballColor)*normalizedStepVals.get(i);
    //  this.green += green(ballColor)*normalizedStepVals.get(i);
    //  this.blue += blue(ballColor)*normalizedStepVals.get(i);
    //  sumWeights +=normalizedStepVals.get(i);
    //}
    //this.red *= 1/sumWeights;
    //this.green *= 1/sumWeights;
    //this.blue *= 1/sumWeights;
    cornerReds[index] = 0;
    cornerGreens[index] = 0;
    cornerBlues[index] = 0;
    ArrayList<Float> normalizedStepVals;
    if(input.size()==1){
      normalizedStepVals = new ArrayList<Float>();
      normalizedStepVals.add(input.get(0));
    } else {
    normalizedStepVals = getNormalized(input);
    }
    float sumWeights = 0;

    for (int i = 0; i < ballList.size(); i++) {
      color ballColor = ballList.get(i).ballColor;
      cornerReds[index] += red(ballColor)*normalizedStepVals.get(i);
      cornerGreens[index] += green(ballColor)*normalizedStepVals.get(i);
      cornerBlues[index] += blue(ballColor)*normalizedStepVals.get(i);
      sumWeights +=normalizedStepVals.get(i);
    }
    cornerReds[index] *= 1/sumWeights;
    cornerGreens[index] *= 1/sumWeights;
    cornerBlues[index] *= 1/sumWeights;

    cornerColors[index] = new PVector(cornerReds[index], cornerGreens[index], cornerBlues[index]);
  }

  int getKey() {
    /* Returns the key for each case of a cell to be used
     for look up table for marching squares */

    //int[] values = {0b1000, 0b0100, 0b0010, 0b0001};
    int[] values = {1, 2, 4, 8};
    int output = 0;

    for (int i = 0; i < boolVals.length; i++) {
      if (boolVals[i]) output += values[i];
    }

    return output;
  }

  void interp() {
    AB = interpolate(A, B);
    AC = interpolate(A, C);
    CD = interpolate(C, D);
    BD = interpolate(B, D);
  }
  ArrayList<PVector> display() {
    /* Finds out what case does a cell correspond to, then a
     final interpolation to smooth result from the 90 and 45 degree angles,
     then adds corresponding vertices to display list */

    ArrayList<PVector> verts  = new ArrayList<PVector>();
    ArrayList<PVector> vertColors = new ArrayList<PVector>(); 

    interp();

    switch(getKey()) {
    case 0:
      break;
    case 1:
      verts.add(CD);
      //verts.add(C);
      verts.add(AC);

      vertColors.add(getMidColor(CD));
      vertColors.add(getColor(C));
      vertColors.add(getMidColor(AC));
      break;
    case 2:
      verts.add(BD);
      //verts.add(D);
      verts.add(CD);

      vertColors.add(getMidColor(BD));
      vertColors.add(getColor(D));
      vertColors.add(getMidColor(CD));
      break;
    case 3:
      verts.add(AC);
      //verts.add(C);
      //verts.add(D);
      verts.add(BD);

      vertColors.add(getMidColor(AC));
      vertColors.add(getColor(C));
      vertColors.add(getColor(D));
      vertColors.add(getMidColor(BD));
      break;
    case 4:
      verts.add(BD);
      verts.add(AB);
      //verts.add(B);

      vertColors.add(getMidColor(BD));    
      vertColors.add(getMidColor(AB));
      vertColors.add(getColor(B));
      break;
    case 5:
      //verts.add(C);
      verts.add(AC);
      verts.add(AB);
      verts.add(BD);
      verts.add(CD);

      vertColors.add(getColor(C));
      vertColors.add(getMidColor(AC));    
      vertColors.add(getMidColor(AB));
      vertColors.add(getMidColor(BD));    
      vertColors.add(getMidColor(CD));
      break;
    case 6:
      verts.add(CD);
      verts.add(AB);
      //verts.add(B);
      //verts.add(D);
      vertColors.add(getMidColor(CD));
      vertColors.add(getMidColor(AB));
      vertColors.add(getColor(B));
      vertColors.add(getColor(D));
      break;
    case 7:
      verts.add(AB);
      //verts.add(B);
      //verts.add(D);
      //verts.add(C);
      verts.add(AC);
      vertColors.add(getMidColor(AB));
      vertColors.add(getColor(B));
      vertColors.add(getColor(D));
      vertColors.add(getColor(C));
      vertColors.add(getMidColor(AC));
      break;
    case 8:
      verts.add(AC);
      //verts.add(A);
      verts.add(AB);
      vertColors.add(getMidColor(AC));
      vertColors.add(getColor(A));
      vertColors.add(getMidColor(AB));
      break;
    case 9:
      //verts.add(A);
      verts.add(AB);
      verts.add(CD);
      //verts.add(C);
      vertColors.add(getColor(A));
      vertColors.add(getMidColor(AB));
      vertColors.add(getMidColor(CD));
      vertColors.add(getColor(C));
      break;
    case 10:
      //verts.add(A);
      verts.add(AB);
      verts.add(BD);
      //verts.add(D);
      verts.add(CD);
      verts.add(AC);
      vertColors.add(getColor(A));
      vertColors.add(getMidColor(AB));
      vertColors.add(getMidColor(BD));
      vertColors.add(getColor(D));
      vertColors.add(getMidColor(CD));
      vertColors.add(getMidColor(AC));
      break;
    case 11:
      verts.add(AB);
      verts.add(BD);
      //verts.add(D);
      //verts.add(C);
      //verts.add(A);

      vertColors.add(getMidColor(AB));
      vertColors.add(getMidColor(BD));
      vertColors.add(getColor(D));
      vertColors.add(getColor(C));
      vertColors.add(getColor(A));
      break;
    case 12:
      //verts.add(A);
      //verts.add(B);
      verts.add(BD);
      verts.add(AC);
      vertColors.add(getColor(A));
      vertColors.add(getColor(B));
      vertColors.add(getMidColor(BD));
      vertColors.add(getMidColor(AC));
      break;
    case 13:
      //verts.add(A);
      //verts.add(B);
      verts.add(BD);
      verts.add(CD);
      //verts.add(C);
      vertColors.add(getColor(A));
      vertColors.add(getColor(B));
      vertColors.add(getMidColor(BD));
      vertColors.add(getMidColor(CD));
      vertColors.add(getColor(C));
      break;
    case 14:
      //verts.add(A);
      //verts.add(B);
      //verts.add(D);
      verts.add(CD);
      verts.add(AC);
      vertColors.add(getColor(A));
      vertColors.add(getColor(B));
      vertColors.add(getColor(D));
      vertColors.add(getMidColor(CD));
      vertColors.add(getMidColor(AC));

      break;
    case 15:
      //verts.add(A);
      //verts.add(B);
      //verts.add(D);
      //verts.add(C);
      vertColors.add(getColor(A));
      vertColors.add(getColor(B));
      vertColors.add(getColor(D));
      vertColors.add(getColor(C));
      break;
    }

    pushStyle();
    noStroke();
    beginShape();
    for (int i = 0; i < verts.size(); i++) {
      PVector p = verts.get(i);
      PVector pColor = vertColors.get(i);
      //fill(pColor.x, pColor.y, pColor.z);
      noFill();
      stroke(255);
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popStyle();
    return verts;
  }

  PVector interpolate(PVector A, PVector B) {
    /* interpolates between two input (corner)
     points by the factor of (1-f(a))/(f(b)-f(a)) 
     because f(b) needs to be ~one */
    return PVector.lerp(A, B, (1-func(A))/(func(B)-func(A)));
  }

  PVector interpolateColors(PVector A, PVector B) {
    /* interpolates between two input (corner)
     points by the factor of (1-f(a))/(f(b)-f(a)) 
     because f(b) needs to be ~one */

    return PVector.lerp(getColor(A), getColor(B), (1-func(A))/(func(B)-func(A)));
  }

  float func(PVector V) {
    /* Takes in one of the corner vectors {A,B,C,D}
     and returns their corresponding corner value (sum of 
     ball list contribution) */

    //cornerVals = {C, D, B, A};
    if (V == C) {
      return cornerVals[0];
    }
    if (V == D) {
      return cornerVals[1];
    }
    if (V == B) {
      return cornerVals[2];
    }
    if (V == A) {
      return cornerVals[3];
    }
    return 0.0;
  }
}
