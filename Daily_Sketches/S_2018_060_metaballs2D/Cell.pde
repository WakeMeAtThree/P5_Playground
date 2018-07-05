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

  PVector[] getCorners() {
    PVector[] output = {A, B, C, D};
    return output;
  }

  int getKey() {
    //int[] values = {0b1000, 0b0100, 0b0010, 0b0001};
    int[] values = {8, 4, 2, 1};
    int output = 0;

    for (int i = 0; i < boolVals.length; i++) {
      if (boolVals[i]) output += values[i];
    }

    return output;
  }

  void display() {
    ArrayList<PVector> verts  = new ArrayList<PVector>();

    switch(getKey()) {
    case 0:
      break;
    case 1:
      verts.add(CD);
      verts.add(D);
      verts.add(BD);
      break;
    case 2:
      verts.add(AC);
      verts.add(C);
      verts.add(CD);
      break;
    case 3:
      break;
    case 4:
      break;
    case 5:
      break;
    case 6:
      break;
    case 7:
      break;
    case 8:
      break;
    case 9:
      break;
    case 10:
      break;
    case 11:
      break;
    case 12:
      break;
    case 13:
      break;
    case 14:
      break;
    case 15:
      break;
    }

    pushStyle();
    noStroke();
    fill(0, 255, 0);
    beginShape();
    for (PVector p : verts) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popStyle();
  }
}