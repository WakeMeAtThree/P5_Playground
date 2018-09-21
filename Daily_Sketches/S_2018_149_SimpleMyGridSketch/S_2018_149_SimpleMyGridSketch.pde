void setup() {
  size(400, 400);
  background(0);
  stroke(255);
  myGrid( 6, 6, 
         8, 5);
}

void myGrid(int X, int Y, 
  float size, float scl) {
  for (int i = 0; i < X; i++) {
    float delayi = 1.0*i/(X-1); 
    line(width*delayi, 0, 
         width*delayi, height);
    for (int j = 0; j < Y; j++) {
      float delayj = 1.0*j/(Y-1);
      myPlus(width*delayi, height*delayj, 
             size, scl);
      line(0, height*delayi, 
           width, height*delayi);
    }
  }
}
void myPlus(float X, float Y, float L, float thickness) {
  pushMatrix();
  pushStyle();
  translate(X, Y);
  strokeCap(SQUARE);
  strokeWeight(thickness);
  line(0, L, 
    0, -L);
  line(L, 0, 
    -L, 0);
  popMatrix();
  popStyle();
}
