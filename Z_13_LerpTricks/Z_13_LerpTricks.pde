float resolution = 1500;

void setup() {
  size(400, 400);
  colorMode(RGB, 1, 1, 1, 1);
}
float x1(float t) {
  return mouseX+0;//50*cos(t);
}

float y1(float t) {
  return mouseY+50*sin(t);
}

void draw() {
  //background(0);
  fill(0, 0.03);
  rect(0, 0, width, height);
  float t = 1.0*frameCount/10;
  fill(255);

  for (int i = 0; i <= resolution; i++) {
    float param = 1.0*i/resolution;
    float x = lerp(x1(t-15.0*param), width, param);
    float y = lerp(y1(t-15.0*param), height/2, param);
    stroke(abs(sin(t-15.0*param)), 0, 0);
    point(x, y);
  }

  ellipse(x1(t), y1(t), 10, 10);
  ellipse(width, height, 10, 10);
}