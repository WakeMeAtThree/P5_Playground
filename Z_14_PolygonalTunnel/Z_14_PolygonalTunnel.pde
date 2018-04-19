PShape s;
float a;
float speed = 10;

void setup() {
  size(500, 500, P3D);
  s = loadShape("geometry.obj");
}

void draw() {
  background(0);
  translate(width/2, height/2, a);
  scale(8.0);

  directionalLight(44.0, 146.0, 211.0, 
    1, 0, 0);

  directionalLight(249, 251, 253, 
    -1, 0, 0);

  shape(s, 0, 0);
  a += speed;
  if (a > 5000 || a < 0) speed *= -1;
  
  saveFrame("animation/Hey####.jpg")
}