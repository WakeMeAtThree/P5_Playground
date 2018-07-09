PGraphics frame;
float a = 0;
float b = 0;
float c = 0;
void setup(){
  size(400,400,P2D);
  smooth(8);
  frame = createGraphics(400,10000);
  
  //frameRate(35);
}

void draw(){
  background(0);
  drawScene(frame);
  translate(0,-a);
  image(frame,0,0);
  a += 3;
  b += 0.1;
  c += 0.05;
}

void drawScene(PGraphics scene){
  scene.beginDraw();
  //scene.background(255,0,0);
  scene.strokeCap(SQUARE);
  scene.noFill();
  scene.strokeWeight(8);
  scene.stroke(lerpColor(#ff0060,#ffde00,map(sin(2*b),-1,1,0,1)),255);
  scene.ellipse(width/2,150+a,map(sin(b),-1,1,25,255),
                                   map(sin(b+0.5)+sin(0.5*b+0.5)+sin(2.4*b+0.2),-3,3,25,100));
  
  scene.endDraw();
}

void drawAnotherScene(PGraphics scene){
  scene.beginDraw();
  //scene.background(255,0,0);
  scene.noFill();
  scene.strokeWeight(12);

  //scene.stroke(lerpColor(#ff0060,#ffde00,map(sin(2*b),-1,1,0,1)),255);
  ellipseCustom(width/2,150+a,
                map(sin(b),-1,1,25,125),
                map(sin(b+0.5)+sin(0.5*b+0.5)+sin(2.4*b+0.2),-3,3,25,100),
                scene);
  
  scene.endDraw();
  
}

void ellipseCustom(float x, float y, float rx, float ry,PGraphics pg) {
  float increment = TWO_PI/14;
  for (float i = 0; i < TWO_PI; i+=increment) {
    pg.beginShape();
    float param = 5.0*i/TWO_PI;
    //lerpColors would work nice here
    pg.stroke(lerpColor(#129bce,#ff0060,sin(param+0.005*a)),220);
    pg.vertex(x+rx*cos(i+c), y+ry*sin(i+c));
    pg.vertex(x+rx*cos(i+increment+c), y+ry*sin(i+increment+c));
    pg.endShape();
  }
}
