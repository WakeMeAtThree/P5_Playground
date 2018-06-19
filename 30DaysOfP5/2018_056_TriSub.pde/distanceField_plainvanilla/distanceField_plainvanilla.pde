float max_dist;

void setup() {
  size(400, 400);
  colorMode(RGB, 1, 1, 1, 1);
  max_dist = PVector.dist(new PVector(width, height), new PVector(0, 0));
}

void draw() {
  background(0);


  for (int i = 0; i <= width; i+=10) {
    for (int j = 0; j <= height; j+=10) {

      float d = dist(mouseX, mouseY, i, j);
      d = (1-map(d, 0, max_dist, 0, 1));
      
      d = 1.0*abs(sin(d*20.6));

      noStroke();
      fill(d, 0, 0);
      ellipse(i, j, 10, 10);
    }
  }
}