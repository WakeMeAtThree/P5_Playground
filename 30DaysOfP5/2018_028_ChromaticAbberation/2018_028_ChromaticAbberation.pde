//Chromatic abberation trick I learnt from Dave Whyte

PImage red, green;

void setup() {
  size(400, 400);
  background(0);
}

void draw() {
  background(0);
  float offsetx = map(mouseX, 0, width, 0.000,0.1);
  float offsety = map(mouseY, 0, height, 0.000,0.1);
  if(mousePressed) println(offsetx,offsety);
  
  //Get red channel pixels
  push();
    mySketch();
  pop();
  red = get();

  //Get green channel pixels
  background(0); 
  push();
    scale(1+offsetx, 1+offsetx);
    mySketch();
  pop();
  green = get();

  //Get blue channel pixels
  background(0);
  push();
    scale(1+offsety, 1+offsety);
    mySketch();
  pop();

  //Load pixels in pixels array
  loadPixels();
  red.loadPixels();
  green.loadPixels();

  //Update shifted pixels from each channel
  for (int i=0; i<pixels.length; i++)
    pixels[i] = color(red(red.pixels[i]), green(green.pixels[i]), blue(pixels[i]));
  updatePixels();
}

void mySketch() {
  //Random arbitrary sketch goes here
  rectMode(CENTER);
  fill(255);
  rect(width/2, height/2, 100, 100);
}

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}