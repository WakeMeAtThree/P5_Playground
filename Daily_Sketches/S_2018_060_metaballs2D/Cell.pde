class Cell {
  PVector center;         //Cell's centerpoint
  PVector A, B, C, D;     //Cell's corners
  PVector AB, AC, CD, BD; //Cell's midpoints
  boolean[] boolVals = new boolean[4]; //Cell's corner containment booleans

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

  public void display() {
    ArrayList<PVector> verts  = new ArrayList<PVector>();

    switch(getKey()) {
    case 0:
      break;
    case 1:
      verts.add(CD);
      verts.add(C);
      verts.add(AC);
      break;
    case 2:
      verts.add(BD);
      verts.add(D);
      verts.add(CD);
      break;
    case 3:
      verts.add(AC);
      verts.add(C);
      verts.add(D);
      verts.add(BD);
      break;
    case 4:
      verts.add(BD);
      verts.add(AB);
      verts.add(B);
      break;
    case 5:
      verts.add(C);
      verts.add(AC);
      verts.add(AB);
      verts.add(BD);
      verts.add(CD);
      break;
    case 6:
      verts.add(CD);
      verts.add(AB);
      verts.add(B);
      verts.add(D);
      break;
    case 7:
      verts.add(AB);
      verts.add(B);
      verts.add(D);
      verts.add(C);
      verts.add(AC);
      break;
    case 8:
      verts.add(AC);
      verts.add(A);
      verts.add(AB);
      break;
    case 9:
      verts.add(A);
      verts.add(AB);
      verts.add(CD);
      verts.add(C);
      break;
    case 10:
      verts.add(A);
      verts.add(AB);
      verts.add(BD);
      verts.add(D);
      verts.add(CD);
      verts.add(AC);
      break;
    case 11:
      verts.add(AB);
      verts.add(BD);
      verts.add(D);
      verts.add(C);
      verts.add(A);
      break;
    case 12:
      verts.add(A);
      verts.add(B);
      verts.add(BD);
      verts.add(AC);
      break;
    case 13:
      verts.add(A);
      verts.add(B);
      verts.add(BD);
      verts.add(CD);
      verts.add(C);
      break;
    case 14:
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
    fill(0, 255, 0);
    //stroke(0,255,0);
    beginShape();
    for (PVector p : verts) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popStyle();
  }
}