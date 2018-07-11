PGraphics scene1;
void setup(){
  size(400,400);
  blendMode(SCREEN);
  scene1 = createGraphics(width,height);
}

void draw(){
clear();
drawScene(scene1);
image(scene1,0,0);
fill(255,128,0);
rect(0,0,width,height);

}

void drawScene(PGraphics scene){
  scene.beginDraw();
  scene.blendMode(EXCLUSION);
  scene.background(255);
  scene.fill(255);
  scene.ellipse(mouseX,mouseY,100,100);
  scene.ellipse(width/2,height/2,100,100);
  scene.endDraw();
}
