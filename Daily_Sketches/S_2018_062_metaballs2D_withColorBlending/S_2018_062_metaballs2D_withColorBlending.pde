/*
Implementation of metaballs and marching squares algorithm using
the wonderful article written by Jamie Wong as a reference:
http://jamie-wong.com/2014/08/19/metaballs-and-marching-squares/

2018-07-07: Quite a rough sketch and I will need to factor it out and clean it up
eventually + port it to glsl. Will also implement marching cubes in the near
future hopefully, but after the world cup is over.
*/

ArrayList<Ball> balls;
Grid someGrid;

void setup() {
  size(400, 400, P3D);
  smooth(8);
  balls = new ArrayList<Ball>();
  someGrid = new Grid(100,100, balls);
  for (int i = 0; i < 5; i++) {
    balls.add(new Ball());
  }
}

void draw() {
  background(255);
  someGrid.display();
  //someGrid.displayCorners();
  for (Ball b : balls) {
    b.run();
  }
}