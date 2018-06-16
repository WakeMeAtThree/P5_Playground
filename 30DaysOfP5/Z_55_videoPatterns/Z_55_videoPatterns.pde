
float a;
import processing.video.*;
Movie[][] grid;

Movie mov;

void setup() {
  size(640, 360);
  background(0);
  grid = new Movie[4][3];
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      float param = 25.0*(i+j)/6;
      float f =lerp(0, 1, map(sin(a+param), -1, 1, 0, 1));

      Movie mov = new Movie(this, "vid.webm");
      float t = mov.duration() * f;
      mov.play();
      mov.jump(t);
      mov.speed(4);
      mov.loop();
      grid[i][j]=mov;
    }
  }
}

void draw() {
  int count = 0; 
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 3; j++) {
      grid[i][j].read();
      if (j%2 == 0) {
        image(grid[i][j], i*width/3, j*height/3, width/3, height/3);
      } else {
        image(grid[i][j], i*width/3-width/6, j*height/3, width/3, height/3);
      }
    }
  }

  a += 0.05;
}