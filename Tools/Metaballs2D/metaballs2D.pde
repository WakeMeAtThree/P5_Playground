/*
Implementation of metaballs and marching squares algorithm using
 the wonderful article written by Jamie Wong as a reference:
 http://jamie-wong.com/2014/08/19/metaballs-and-marching-squares/
*/

ArrayList<Ball> balls;
Grid grid2D;
float a = 0;


void setup() {
  size(400, 400, P2D);
  smooth(8);

  //Instantiate ball list and 2Dgrid
  balls = new ArrayList<Ball>();
  grid2D = new Grid(55, 55, balls);

  //Add balls to ball list
  balls.add(new Ball(new PVector(259.314, 302.736, 15), new PVector(width/2, height/2, 0)));
  balls.add(new Ball(new PVector(318.629, 200, 5), new PVector(width/2, height/2, 0)));
  balls.add(new Ball(new PVector(259.314, 97.2645, 15), new PVector(width/2, height/2, 0)));
  balls.add(new Ball(new PVector(140.686, 97.2645, 24), new PVector(width/2, height/2, 0)));
  balls.add(new Ball(new PVector(140.686, 302.736, 35), new PVector(width/2, height/2, 0)));
  balls.add(new Ball(new PVector(81.3713, 200, 25), new PVector(width/2, height/2, 0)));
  balls.add(new Ball(new PVector(width/2, height/2, 0), new PVector(width/2, height/2, 0)));
}

void draw() {
  background(255);

  //Run ball behavior
  for (int i = 0; i < balls.size(); i++) {
    float param = 1.0 * i/balls.size();
    balls.get(i).run(param);
  }

  //Display metaballs + debug modes
  grid2D.displayMetaballs();
  //grid2D.displayCorners();
  //grid2D.displayCenters();

  //Animate + Save frames
  //saveFrame("output/animation###.png");
  a+=0.2;
  //if(a >= TWO_PI) exit();
}
