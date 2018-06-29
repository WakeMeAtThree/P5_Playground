float a;

void setup() {
  size(400, 400);
  //  translate(0,height/2);
  noFill();
}

void draw() {
  background(128);
  float value = map(mouseX, 0, width, 0, 100);
  //fill(0,255,0);

  strokeWeight(1);
  if (mousePressed)println(mouseY, mouseX);
  beginShape();
  for (float i = 0; i < width; i+=1) {
    float param = i/width;
    vertex(i,func(a,param));
  }
  endShape();
  a += 0.025;
}

float func(float time, float delay){
  return divide(8,width,height,map(sin(time+delay),-1,1,0,width));
}
float divide(int n, float xRange, float yRange, float j) {
  float outputVal = 0;
  for (int i=0; i<n; i++) {
    float a = float(n);
    outputVal += (yRange/(a-1.))*smoothstep(xRange*i/a,xRange*i/a-5.55,j);
  }
  return outputVal;
}
