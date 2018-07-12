float a;
void setup() {
  size(400, 400);
  rectMode(CENTER);
}
void draw() {
  background(0);
  translate(0, lerp(0, 50, a%1));
  rect(width/2, height/2-lerp(0, 50, smoothstep(0.7,0.9,a%1.0)), 50, 50);
  for (int i = 0; i < 5; i++) {
    rect(width/2, height/2+i*50, 50, 50);
  }
  a+=0.01;
}

float smoothstep(float edge0, float edge1, float x) {
  x = constrain((x - edge0) / (edge1 - edge0), 0.0f, 1.0f); 
  return x * x * (3 - 2 * x);
}
