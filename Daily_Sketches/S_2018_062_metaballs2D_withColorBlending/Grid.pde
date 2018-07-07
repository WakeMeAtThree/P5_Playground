import java.util.Collection;

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

        ArrayList<Float> values = summationFunc(p, ballList);
        
        c.addColors(values, ballList);
        
        //Sum up values
        float sum = 0;
        for (Float v : values) {
          sum += v;
        }
        
        c.cornerVals[i] = sum;

        if (sum >=1) {
          c.boolVals[i]=true;

          //color colorBlend = summationFuncColor(p);


          //stroke(summationFuncColor(p));
          //point(p.x, p.y);
        } else {
          c.boolVals[i]=false;
        }
      }
      //totalRed = totalRed==0 ? 255*4: totalRed;
      //totalGreen = totalGreen==0 ? 255*4: totalGreen;
      //totalBlue = totalBlue==0 ? 255*4: totalBlue;
      
      c.display(ballList.size());

      //}
      //if (pointInCircles(c.center)) {
      //  noStroke();
      //  //fill(0, 255, 0);
      //  //rect(c.center.x, c.center.y, spaceX, spaceY);
      //  strokeWeight(5);
      //  stroke(0, 255, 0);
      //  point(c.center.x, c.center.y);
      //}
      //strokeWeight(2);
      //stroke(128);
      //point(c.center.x, c.center.y);
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
  //public boolean pointInCircles(PVector point) {
  //  /* Inequality expression from the article */
  //  return summationFunc(point, ballList)>=1;
  //}


  public color summationFuncColor(PVector point) {
    /* 2D function from the article */
    float weightTotal = 0;

    float totalRed=0;
    float totalGreen=0;
    float totalBlue=0;

    for (Ball b : ballList) {
      color someColor = b.hello;
      float numerator = pow(b.diameter/2, 2);
      float denominator = pow((point.x-b.loc.x), 2)+pow((point.y-b.loc.y), 2);

      totalRed += red(someColor) * numerator/denominator;
      totalGreen += green(someColor) * numerator/denominator;
      totalBlue += blue(someColor) * numerator/denominator;

      weightTotal += numerator/denominator;
    }
    totalRed *= 1/weightTotal;
    totalGreen *= 1/weightTotal;
    totalBlue *= 1/weightTotal;

    return color(totalRed, totalGreen, totalBlue);
  }
  void updateMidpoints() {
  }
}

ArrayList<Float> summationFunc(PVector point, ArrayList<Ball> ballList) {
  /* 2D function from the article */
  ArrayList<Float> outputList = new ArrayList<Float>();

  for (Ball b : ballList) {
    float numerator = pow(b.diameter/2, 2);
    float denominator = pow((point.x-b.loc.x), 2)+pow((point.y-b.loc.y), 2);
    outputList.add(numerator/denominator);
  }

  return outputList;
}