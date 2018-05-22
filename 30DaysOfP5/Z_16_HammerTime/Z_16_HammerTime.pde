
PShape s;
PShader blur;
float a,b,c;
float speed = 10;

void setup() {
  size(500, 500, P3D);
  background(0);
  s = loadShape("geometry.obj");
  blur = loadShader("blur.glsl");
}

void draw() {
  //background(0);
  filter(blur);
  translate(width/2, height/2, a);
  scale(map(sin(a),-1,1,0,70));
  lights1();
  
  ////Light options
  //lightFalloff(1.0, 0.0, 0.0);
  //lightSpecular(128, 128, 128);
  //ambientLight(128, 128, 128);
  //directionalLight(128, 128, 128, 0, 1, -1);
  //directionalLight(128, 128, 128, 0, 1, 0);
  
  //Shape Material properties
  s.setFill(color(252, 237, 245, map(sin(a),-1,1,10,150)));
  s.setAmbient(0xff7f7f00);
  //s.setSpecular(0xff0000ff);
  //s.setEmissive(0xffff0000);
  
  rotateX(a);
  rotateY(b);
  rotateZ(c);
  
  shape(s, 0, 0);
  //a += speed;
  //if (a > 5000 || a < 0) speed *= -1;

  //saveFrame("animation/Hey####.jpg");
  a+=0.01;
  b+=0.05;
  c+=0.04;
}

void lights1() {
  lightFalloff(2.0, 0.0, 0.0);
  directionalLight(18.0, 141.0, 219.0, 
    1, 0, 0);

  directionalLight(249, 251, 253, 
    -1, 0, 0);
}