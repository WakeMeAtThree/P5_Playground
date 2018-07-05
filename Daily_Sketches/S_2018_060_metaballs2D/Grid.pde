class Grid {
  int x, y;
  float spaceX, spaceY;
  ArrayList<PVector> gridPoints;
  ArrayList<Ball> ballList;
  Grid(int x, int y, ArrayList<Ball> ballList) {
    this.x = x;
    this.y = y;
    this.spaceX = 1.0*width/x;
    this.spaceY = 1.0*height/y;

    gridPoints = new ArrayList<PVector>();
    for (int i = 0; i < x; i++) {
      for (int j = 0; j < y; j++) {
        gridPoints.add(new PVector(spaceX*i+spaceX/2, spaceY*j+spaceY/2));
      }
    }
    this.ballList = ballList;
  }

  void display() {
    pushStyle();
    strokeWeight(2);
    rectMode(CENTER);
    for(PVector p: gridPoints){
      if(pointInCircles(p)){
        noStroke();
        fill(0,255,0);
        rect(p.x,p.y,spaceX,spaceY);
      }
      
      
      stroke(128);
      point(p.x,p.y);
    }
    popStyle();
  }

  boolean pointInCircles(PVector point) {
    return summationFunc(point)>=1;
  }

  float summationFunc(PVector point) {
    float output = 0;
    for (Ball b : ballList) {
      float numerator = pow(b.diameter/2, 2);
      float denominator = pow((point.x-b.loc.x), 2)+pow((point.y-b.loc.y), 2);
      output += numerator/denominator;
    }
    return output;
  }
}
