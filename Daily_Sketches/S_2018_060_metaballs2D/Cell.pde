class Cell {
  PVector center;         //Cell's centerpoint
  PVector A, B, C, D;     //Cell's corners
  PVector AB, AC, CD, BD; //Cell's midpoints
  boolean[] boolVals = new boolean[4]; //Cell's corner containment booleans
  float[] cornerVals = new float[4];

  Cell(float x, float y, float spaceX, float spaceY) {
    center = new PVector(x, y);

    //Corner Points
    A = center.copy().add(new PVector(-spaceX/2, -spaceY/2));
    B = center.copy().add(new PVector(spaceX/2, -spaceY/2));
    C = center.copy().add(new PVector(-spaceX/2, spaceY/2));
    D = center.copy().add(new PVector(spaceX/2, spaceY/2));

    //Mid Points
    AB = center.copy().add(new PVector(0, -spaceY/2));
    CD = center.copy().add(new PVector(0, spaceY/2));
    AC = center.copy().add(new PVector(-spaceX/2, 0));
    BD = center.copy().add(new PVector(spaceX/2, 0));
  }

  public PVector[] getCorners() {
    PVector[] output = {A, B, D, C};
    return output;
  }

  public int getKey() {
    //int[] values = {0b1000, 0b0100, 0b0010, 0b0001};
    int[] values = {8, 4, 2, 1};
    int output = 0;

    for (int i = 0; i < boolVals.length; i++) {
      if (boolVals[i]) output += values[i];
    }

    return output;
  }

  public void display(color someColor) {
    ArrayList<PVector> verts  = new ArrayList<PVector>();

    switch(getKey()) {
    case 0:
      break;
    case 1:
      //cornerVals = {A, B, D, C};
      AC.y = interpolateVertical(C, A);
      CD.x = interpolateHorizontal(D, C);
      verts.add(CD);
      verts.add(C);
      verts.add(AC);
      break;
    case 2:
      //cornerVals = {A, B, D, C};
      BD.y = interpolateVertical(B, D);
      CD.x = interpolateHorizontal(C, D);
      verts.add(BD);
      verts.add(D);
      verts.add(CD);
      break;
    case 3:
      AC.y = interpolateVertical(A, C);
      BD.y = interpolateVertical(B, D);
      verts.add(AC);
      verts.add(C);
      verts.add(D);
      verts.add(BD);
      break;
    case 4:
      AB.x = interpolateHorizontal(A, B);
      BD.y = interpolateVertical(B, D);
      verts.add(BD);
      verts.add(AB);
      verts.add(B);
      break;
    case 5:
      AB.x=interpolateHorizontal(A, B);
      BD.y=interpolateVertical(B, D);
      CD.x=interpolateHorizontal(C, D);
      AC.y=interpolateVertical(A, C);
      verts.add(C);
      verts.add(AC);
      verts.add(AB);
      verts.add(BD);
      verts.add(CD);
      break;
    case 6:
      AB.x=interpolateHorizontal(A, B);
      CD.x=interpolateHorizontal(C, D);
      verts.add(CD);
      verts.add(AB);
      verts.add(B);
      verts.add(D);
      break;
    case 7:
      AB.x=interpolateHorizontal(A, B);
      AC.y=interpolateVertical(A, C);
      verts.add(AB);
      verts.add(B);
      verts.add(D);
      verts.add(C);
      verts.add(AC);
      break;
    case 8:
    AB.x=interpolateHorizontal(A,B);
    AC.y=interpolateVertical(A,C);
      verts.add(AC);
      verts.add(A);
      verts.add(AB);
      break;
    case 9:
    AB.x=interpolateHorizontal(A,B);
    CD.x=interpolateHorizontal(C,D);
      verts.add(A);
      verts.add(AB);
      verts.add(CD);
      verts.add(C);
      break;
    case 10:
    AB.x=interpolateHorizontal(A,B);
    BD.y=interpolateVertical(B,D);
    CD.x=interpolateHorizontal(C,D);
    AC.y=interpolateVertical(A,C);
      verts.add(A);
      verts.add(AB);
      verts.add(BD);
      verts.add(D);
      verts.add(CD);
      verts.add(AC);
      break;
    case 11:
    AB.x=interpolateHorizontal(A,B);
    BD.y=interpolateVertical(B,D);
      verts.add(AB);
      verts.add(BD);
      verts.add(D);
      verts.add(C);
      verts.add(A);
      break;
    case 12:
    AC.y=interpolateVertical(A,C);
    BD.y=interpolateVertical(B,D);
      verts.add(A);
      verts.add(B);
      verts.add(BD);
      verts.add(AC);
      break;
    case 13:
    BD.y=interpolateVertical(B,D);
    CD.x=interpolateHorizontal(C,D);
      verts.add(A);
      verts.add(B);
      verts.add(BD);
      verts.add(CD);
      verts.add(C);
      break;
    case 14:
    AC.y=interpolateVertical(A,C);
    CD.x=interpolateHorizontal(C,D);
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
    fill(someColor);
    //stroke(0,255,0);
    beginShape();
    for (PVector p : verts) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popStyle();
  }

  float interpolateVertical(PVector B, PVector D) {
    return B.y+(D.y-B.y)*(1-func(B))/(func(D)-func(B));
  }
  float interpolateHorizontal(PVector C, PVector D) {
    return C.x+(D.x-C.x)*(1-func(C))/(func(D)-func(C));
  }
  float func(PVector V) {
    //cornerVals = {A, B, D, C};
    if (V == A) {
      return cornerVals[0];
    }
    if (V == B) {
      return cornerVals[1];
    }
    if (V == C) {
      return cornerVals[3];
    }
    if (V == D) {
      return cornerVals[2];
    }
    return 0.0;
  }
}
