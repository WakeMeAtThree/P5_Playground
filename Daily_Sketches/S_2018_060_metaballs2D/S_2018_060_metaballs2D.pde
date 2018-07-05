/*
Implementation of metaballs and marching squares algorithm using
the wonderful article written by Jamie Wong as a reference:
http://jamie-wong.com/2014/08/19/metaballs-and-marching-squares/
*/

ArrayList<Ball> balls;
Grid someGrid;

void setup() {
  size(400, 400, P3D);
  smooth(8);
  balls = new ArrayList<Ball>();
  someGrid = new Grid(100,100, balls);
  for (int i = 0; i < 15; i++) {
    balls.add(new Ball());
  }
}

void draw() {
  //background(255);
  someGrid.display();
  //someGrid.displayCorners();
  for (Ball b : balls) {
    b.run();
  }
}
