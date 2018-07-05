
class Grid {
  int x, y;
  float spaceX, spaceY;

  //ArrayList<PVector> gridPoints;
  //ArrayList<PVector> cornerPoints;
  ArrayList<Cell> cells;

  ArrayList<Ball> ballList;
  Grid(int x, int y, ArrayList<Ball> ballList) {
    this.x = x;
    this.y = y;
    this.spaceX = 1.0f*width/x;
    this.spaceY = 1.0f*height/y;

    cells = new ArrayList<Cell>();
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        cells.add(new Cell(spaceX*i+spaceX/2, spaceY*j+spaceY/2, spaceX, spaceY));
      }
    }

    this.ballList = ballList;
  }

  public void display() {
    pushStyle();

    rectMode(CENTER);
    for (Cell c : cells) {

      for (int i = 0; i < c.getCorners().length; i++) {
        PVector p = c.getCorners()[i];
        if (pointInCircles(p)) {
          c.boolVals[i]=true;
          strokeWeight(5);
          stroke(0, 255, 0);
          point(p.x, p.y);
        } else {
          c.boolVals[i]=false;
        }
      }
    //c.display();

      //}
      //if (pointInCircles(c.center)) {
      //  noStroke();
      //  //fill(0, 255, 0);
      //  //rect(c.center.x, c.center.y, spaceX, spaceY);
      //  strokeWeight(5);
      //  stroke(0, 255, 0);
      //  point(c.center.x, c.center.y);
      //}
      strokeWeight(2);
      stroke(128);
      point(c.center.x, c.center.y);
    }
    popStyle();
  }

  public void displayCorners() {
    for (Cell c : cells) {
      strokeWeight(2);
      point(c.A.x, c.A.y);
      point(c.B.x, c.B.y);
      point(c.C.x, c.C.y);
      point(c.D.x, c.D.y);
    }
  }
  public boolean pointInCircles(PVector point) {
    /* Inequality expression from the article */
    return summationFunc(point)>=1;
  }

  public float summationFunc(PVector point) {
    /* 2D function from the article */
    float output = 0;
    for (Ball b : ballList) {
      float numerator = pow(b.diameter/2, 2);
      float denominator = pow((point.x-b.loc.x), 2)+pow((point.y-b.loc.y), 2);
      output += numerator/denominator;
    }
    return output;
  }
}