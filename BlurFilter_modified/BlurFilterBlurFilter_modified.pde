/*
Modification of the Blur Filter example in processing to accomodate
for changes to the glsl dynamically as well as included kernels
other than box blur (taken from wikipedia's article on kernel convolutions)
*/

PShader blur;

void setup() {
  size(640, 360, P2D);
  blendMode(NORMAL);
  //blur = loadShader("blur.glsl"); 
  stroke(255, 0, 0);
  //rectMode(corner);
}

void draw() {
  if (mousePressed==true) {
    try {
      blur = loadShader("blur.glsl");
      filter(blur);
    }
    catch(Exception e) {
      resetShader();
    }
  }
  fill(0, 10);
  noStroke();
  //rect(0, 0, width, height);
  //background(0);
  //rect(mouseX, mouseY, 150, 150); 
  strokeWeight(1);
  stroke(255, 0, 0);
  fill(255);
  ellipse(mouseX, mouseY, 100, 100);
}