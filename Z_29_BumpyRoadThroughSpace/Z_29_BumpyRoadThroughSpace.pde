Star[] stars = new Star[1600];
float[] randomlist = new float[ceil(PI/0.05)];
float speed,a,aspeed;

void setup() {
  size(560, 560);
  //fullScreen();
  background(0);
  
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  
  for(int i = 0; i < randomlist.length; i++){
  randomlist[i] = random(0,5);
  }
  
  a = -1.8;
  aspeed = 0.05;
}

void draw() {
  
  pushStyle();
  fill(0,90);
  noStroke();
  rect(0,0,width,height);
  popStyle();
  speed = map(sin(a),-1,1,0,50);//map(mouseX,0,width,0,50);
  resetMatrix();
  
  translate(width/2+randomlist[int(map(sin(a),-1,1,0,randomlist.length-1))],height/2+100*sin(a));
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].display();
  }
  a += aspeed;
  if(a > 5.1 || a < -1.8) aspeed *= -1;
  //saveFrame("output/animation###.png");
}