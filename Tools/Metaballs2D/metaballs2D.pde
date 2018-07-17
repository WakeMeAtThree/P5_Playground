/*
Hello! I made this implementation of metaballs and marching squares algorithm
using the wonderful article written by Jamie Wong as a reference:
http://jamie-wong.com/2014/08/19/metaballs-and-marching-squares/

I'm setting this up to be extended to 3Dimensions, and hopefully to a glsl shader.
*/

ArrayList<Ball> balls;
Grid grid2D;
float a = 0;


void setup() {
  size(400, 400, P3D);
  smooth(8);

  //Instantiate ball list and 2Dgrid
  balls = new ArrayList<Ball>();
  grid2D = new Grid(55, 55, balls);

  //Add balls to ball list
  for (int i = 0; i < 5; i++) {
    balls.add(new Ball());
  }
}

void draw() {
  background(255);

  //Run ball behavior
  for (int i = 0; i < balls.size(); i++) {
    float param = 1.0 * i/balls.size();
    balls.get(i).run(param);
    //balls.get(i).display();
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
