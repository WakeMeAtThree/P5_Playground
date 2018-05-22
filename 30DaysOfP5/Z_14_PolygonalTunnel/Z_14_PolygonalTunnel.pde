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
  lightOptions();
  rotateZ(a/1028);
  scale(8.2);
  
  shape(s, 0, 0);
  a += speed;
  if (a > 5000 || a < 0) speed *= -1;

  //saveFrame("animation/Hey####.jpg")
}

void lightOptions() {
  lightSpecular(35.0, 36, 35);
  directionalLight(41.0, 147.0, 214.0, 
    1, 0, 0);

  directionalLight(248, 252, 255, 
    -1, 0, 0);
}