/*
Modification of the Blur Filter example in processing to accomodate
for changes to the glsl dynamically as well as included kernels
other than box blur (taken from wikipedia's article on kernel convolutions)
*/

PShader blur;
PImage img;

void setup() {
  size(640, 360, P2D);
  blur = loadShader("blur.glsl"); 
  img = loadImage("bird.jpg"); 
}

void draw() {
  shader(blur);
  image(img, 0, 0);
}
