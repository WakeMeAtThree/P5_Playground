class Cell {
  PVector center;                      //Cell's centerpoint
  PVector A, B, C, D;                  //Cell's corners
  PVector E, F, G, H;                  //Extension to 3D corners
  PVector AB, AC, CD, BD;              //Cell's midpoints
  boolean[] boolVals = new boolean[4]; //Cell's corner containment booleans (if it's inside a ball)
  float[] cornerVals = new float[4];   //Values of sum for each corner
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
  PVector[] getCorners() {
    PVector[] output = {C, D, B, A};
    return output;
  }
  void addColors(ArrayList<Float> input, ArrayList<Ball> ballList) {
    /*
    1. Reset r,g,b to zero every time
     2. Normalize weights
     3. Multiply each weight with their corresponding ball color contribution
     (OPTIONAL: there is room here to play around with smoothstep )
     4. Add them all up
     5. Divide it by the sum of the normalized weights
     */

    this.red = 0;
    this.green = 0;
    this.blue = 0;
    ArrayList<Float> normalizedStepVals = getNormalized(input);
    float sumWeights = 0;

    for (int i = 0; i < ballList.size(); i++) {
      color ballColor = ballList.get(i).ballColor;
      this.red += red(ballColor)*normalizedStepVals.get(i);
      this.green += green(ballColor)*normalizedStepVals.get(i);
      this.blue += blue(ballColor)*normalizedStepVals.get(i);
      sumWeights +=normalizedStepVals.get(i);
    }
    this.red *= 1/sumWeights;
    this.green *= 1/sumWeights;
    this.blue *= 1/sumWeights;
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

  void display() {
    /* Finds out what case does a cell correspond to, then a
     final interpolation to smooth result from the 90 and 45 degree angles,
     then adds corresponding vertices to display list */

    ArrayList<PVector> verts  = new ArrayList<PVector>();

    switch(getKey()) {
    case 0:
      break;
    case 1:
      AC = interpolate(A, C);
      CD = interpolate(C, D);
      verts.add(CD);
      verts.add(C);
      verts.add(AC);
      break;
    case 2:
      BD = interpolate(B, D);
      CD = interpolate(C, D);
      verts.add(BD);
      verts.add(D);
      verts.add(CD);
      break;
    case 3:
      AC = interpolate(A, C);
      BD = interpolate(B, D);

      verts.add(AC);
      verts.add(C);
      verts.add(D);
      verts.add(BD);
      break;
    case 4:
      AB = interpolate(A, B);
      BD = interpolate(B, D);
      verts.add(BD);
      verts.add(AB);
      verts.add(B);
      break;
    case 5:
      AB = interpolate(A, B);
      BD = interpolate(B, D);
      CD = interpolate(C, D);
      AC = interpolate(A, C);
      verts.add(C);
      verts.add(AC);
      verts.add(AB);
      verts.add(BD);
      verts.add(CD);
      break;
    case 6:
      AB = interpolate(A, B);
      CD = interpolate(C, D);
      verts.add(CD);
      verts.add(AB);
      verts.add(B);
      verts.add(D);
      break;
    case 7:
      AB = interpolate(A, B);
      AC = interpolate(A, C);
      verts.add(AB);
      verts.add(B);
      verts.add(D);
      verts.add(C);
      verts.add(AC);
      break;
    case 8:
      AB = interpolate(A, B);
      AC = interpolate(A, C);
      verts.add(AC);
      verts.add(A);
      verts.add(AB);
      break;
    case 9:
      AB = interpolate(A, B);
      CD = interpolate(C, D);
      verts.add(A);
      verts.add(AB);
      verts.add(CD);
      verts.add(C);
      break;
    case 10:
      AB = interpolate(A, B);
      BD = interpolate(B, D);
      CD = interpolate(C, D);
      AC = interpolate(A, C);
      verts.add(A);
      verts.add(AB);
      verts.add(BD);
      verts.add(D);
      verts.add(CD);
      verts.add(AC);
      break;
    case 11:
      AB = interpolate(A, B);
      BD = interpolate(B, D);
      verts.add(AB);
      verts.add(BD);
      verts.add(D);
      verts.add(C);
      verts.add(A);
      break;
    case 12:
      AC = interpolate(A, C);
      BD = interpolate(B, D);
      verts.add(A);
      verts.add(B);
      verts.add(BD);
      verts.add(AC);
      break;
    case 13:
      BD = interpolate(B, D);
      CD = interpolate(C, D);
      verts.add(A);
      verts.add(B);
      verts.add(BD);
      verts.add(CD);
      verts.add(C);
      break;
    case 14:
      AC = interpolate(A, C);
      CD = interpolate(C, D);
      verts.add(A);
      verts.add(B);
      verts.add(D);
      verts.add(CD);
      verts.add(AC);
      break;
    case 15:
      verts.add(A);
      verts.add(B);
      verts.add(D);
      verts.add(C);
      break;
    }

    pushStyle();
    noStroke();
    fill(this.red, this.green, this.blue);

    //stroke(this.red, this.green, this.blue);
    beginShape();
    for (PVector p : verts) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popStyle();
  }

  PVector interpolate(PVector A, PVector B) {
    /* interpolates between two input (corner)
     points by the factor of (1-f(a))/(f(b)-f(a)) 
     because f(b) needs to be ~one */
    return PVector.lerp(A, B, (1-func(A))/(func(B)-func(A)));
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
