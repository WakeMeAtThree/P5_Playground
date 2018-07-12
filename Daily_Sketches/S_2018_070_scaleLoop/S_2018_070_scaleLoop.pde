float a;
void setup() {
  size(400, 400);
  rectMode(CENTER);
  noStroke();
}
void draw() {
  background(0);
  pushMatrix();
  translate(width/2,height/2);
  scale(lerp(1,4,a%1.0));

  fill(255);
  rect(0,0,200,200);
  
  fill(0);
  rect(0,0,lerp(0,100,smoothstep(0.2,0.5,a%1.0)),
           lerp(0,100,smoothstep(0.1,0.3,a%1.0)));
  fill(255);
  rect(0,0,lerp(0,50,smoothstep(0.6,0.9,a%1.0)),
           lerp(0,50,smoothstep(0.5,0.9,a%1.0)));
  popMatrix();
  a+=0.01;
}

float smoothstep(float edge0, float edge1, float x) {
  x = constrain((x - edge0) / (edge1 - edge0), 0.0f, 1.0f); 
  return x * x * (3 - 2 * x);
}
