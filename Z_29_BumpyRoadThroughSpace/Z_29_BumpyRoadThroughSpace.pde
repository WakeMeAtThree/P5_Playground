Star[] stars = new Star[1600];
float[] randomlist = new float[ceil(PI/0.05)];
float speed,a;

void setup() {
  size(800, 800);
  //fullScreen();
  background(0);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  for(int i = 0; i < randomlist.length; i++){
  randomlist[i] = random(0,5);
  }
  
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
  a += 0.05;
  //saveFrame("output/animation###.png");
  //Add a way of reversing value inputs in a better way
 
}