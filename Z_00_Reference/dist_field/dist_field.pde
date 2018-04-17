float a = 50;
float b = 10;

void setup() {
  size(400, 400);
}

void draw() {
  background(0);
  for (int i = 0; i < width; i+=5) {
    for (int j = 0; j < height; j+=5) {
      stroke(255, 0, 0);
      float d =dist(mouseX, mouseY, i, j); 
      if (d < a && d > b) {
        point(i, j);
      }
    }
  }
  a += 0.1;
  b += 0.1;
}