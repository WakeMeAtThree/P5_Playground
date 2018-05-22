// Continuation of the previous sketch, including a square motion
// to the square arrangements

// Parameters to update for rotation + translation
float a;
float b;
float aa;
float bb;

// Flags for indicating direction
boolean right;
boolean down;
boolean left;
boolean up;

//
float[] threshold = {0,100};;

void setup()
{
  size(400, 400);
  rectMode(CENTER);
  //Initialize right motion
  right = true;
}

void draw()
{
  background(0);
  translate(a, b);

  for (int i = -2; i < 6; i++) {
    for (int j = -2; j<13; j++) {

      square1(31+89*i, 18+37*j);
    }
  }
  for (int i = -2; i < 5; i++) {
    for (int j = -2; j < 6; j++) {

      square2(76.1324+90.1*i, 52.9105+90.1*j);
    }
  }
  
  // Flag controls
  if (right) a += 2;
  if (down) b += 2;
  if (left) a -= 2;
  if (up) b -= 2;

  squaremove();
  aa += 0.01;
  bb += 0.05;
}

void squaremove() {
  if (a > threshold[1]) {
    right = false;
    down = true;
  }

  if (b > threshold[1]) {
    down = false;
    left = true;
  }

  if (a < threshold[0]) {
    left = false;
    up = true;
  }

  if (b < threshold[0]) {
    up = false;
    right = true;
  }
}


void square1(float x, float y)
{
  pushMatrix();
  translate(x, y);
  rotate(aa);
  rect(0, 0, 21.7, 21.7);
  rectMode(CENTER);
  popMatrix();
}

void square2(float x, float y)
{
  pushMatrix();
  //Stroke();
  translate(x, y);
  rotate(bb);
  rect(0, 0, 54.319, 54.319);
  rectMode(CENTER);
  popMatrix();
}