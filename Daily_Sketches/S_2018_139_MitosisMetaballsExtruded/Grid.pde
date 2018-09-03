class Grid {
  int x, y;
  float spaceX, spaceY;
  ArrayList<Cell> cells;
  ArrayList<CellM> ballList;
  boolean debug;

  Grid(int x, int y, ArrayList<CellM> ballList) {
    this.x = x;
    this.y = y;
    this.spaceX = 1.0*(width+100)/x;
    this.spaceY = 1.0*(width+100)/y;
    this.ballList = ballList;

    //Create 2D grid of cells
    cells = new ArrayList<Cell>();
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        cells.add(new Cell(spaceX*i+spaceX/2, spaceY*j+spaceY/2, spaceX, spaceY));
      }
    }
  }

  ArrayList<ArrayList<PVector>> displayMetaballs() {
     ArrayList<ArrayList<PVector>> curves = new ArrayList<ArrayList<PVector>>();
    for (Cell c : cells) {
      /* Go through each cell */

      for (int i = 0; i < c.getCorners().length; i++) {
        /* Go through each cell's corner points, calculate
         the sum of each ball in the ball list
         to the point */

        PVector p = c.getCorners()[i];
        ArrayList<Float> values = sum(p, ballList);

        //Feed list pre-summed values for each corner to the cell 
        c.addColors(values, ballList, i);

        //Sum up the values
        float sum = 0;
        for (Float v : values) {
          sum += v;
        }

        //If sum is greater or equal to 1
        //Then it's contained by the balls
        if (sum >=1) {
          c.boolVals[i]=true;

          //Debug display of contained corners
          if (debug) {
            pushStyle();
            strokeWeight(5);
            stroke(0, 255, 0);
            point(p.x, p.y);
            popStyle();
          }
        } else {
          c.boolVals[i]=false;
        }

        //Store corner value for later use
        c.cornerVals[i] = sum;
      }

      //Display each cell to form metaball
      ArrayList<PVector> a = c.display();
      curves.add(a);
    }
    return curves;
  }

  void displayCorners() {
    for (Cell c : cells) {
      strokeWeight(2);
      point(c.A.x, c.A.y);
      point(c.B.x, c.B.y);
      point(c.C.x, c.C.y);
      point(c.D.x, c.D.y);
    }
  }

  void displayCenters() {
    for (Cell c : cells) {
      point(c.center.x, c.center.y);
    }
  }

  boolean pointInCircles(PVector point) {
    /* Inequality expression from the article */
    ArrayList<Float> weights = sum(point, ballList);
    float sum=0;
    for (Float a : weights) {
      sum+=a;
    }
    return sum>=1;
  }

  ArrayList<Float> sum(PVector point, ArrayList<CellM> ballList) {
    /* 2D function from the article, returns the output of each ball
     to a cell's point */
    ArrayList<Float> outputList = new ArrayList<Float>();

    for (CellM b : ballList) {
      float numerator = pow(b.r, 2);
      float denominator = pow((point.x-b.loc.x), 2)+pow((point.y-b.loc.y), 2)+pow((point.z-b.loc.z), 2);
      outputList.add(numerator/denominator);
    }

    return outputList;
  }
}
