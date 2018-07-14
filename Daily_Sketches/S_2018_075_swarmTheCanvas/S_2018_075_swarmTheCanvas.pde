/*
Implementation of metaballs and marching squares algorithm using
 the wonderful article written by Jamie Wong as a reference:
 http://jamie-wong.com/2014/08/19/metaballs-and-marching-squares/
 
 - finish color interpolation
 
 */
boolean toggle = true;
int count = 0;
ArrayList<Ball> balls;
Grid someGrid;
float a = 0;
PGraphics scene,scene2;

void setup() {
  size(400, 400, P2D);
  scene = createGraphics(400, 400, P2D);
  scene2 = createGraphics(400, 400, P2D);
  imageMode(CENTER);
  smooth(8);
  clear();

  //blendMode(EXCLUSION);
  //blendMode(DIFFERENCE);
  balls = new ArrayList<Ball>();
  someGrid = new Grid(125, 125, balls);
  for (int i = 0; i < 200; i++) {
    PVector randomVec1 = new PVector(random(-100, 500), random(1)>=0.5?-200:600, 0);
    PVector randomVec2 = new PVector(random(1)>=0.5?-200:600, random(-100, 500), 0);
    balls.add(new Ball(random(1)>=0.5?randomVec1:randomVec2, new PVector(width/2, height/2, 0)));
  }
}

void draw() {

  background(255);
  if (toggle) {
    drawScene(#000000, #FFFFFF,scene);
      translate(width/2, height/2);
  scale(lerp(1, 1.75, a));
  image(scene, 0, 0);
    //saveFrame("output/animation###.png");
  } else {
    clear();
    drawScene(#FFFFFF, #000000,scene2);
          translate(width/2, height/2);
  scale(lerp(1, 1.75, a));
  image(scene2, 0, 0);
  }

  if (mousePressed) println(a);
  a+=0.01;
  if (a >= 3.3){
    a=0;
    scene.clear();
    toggle = !toggle;
    count++;
  }
  
  //saveFrame("output/animation###.png");
  if(count==2) exit();
  //if (a >= TWO_PI) exit();
}
void drawScene(color back, color front, PGraphics scene) {
  scene.beginDraw();
  scene.background(back);
  someGrid.display(front, scene);
  for (int i = 0; i < balls.size(); i++) {
    float param = 2.0 * i/balls.size();
    balls.get(i).run(param);
  }
  scene.endDraw();
}
// Set of ease functions below borrowed from Dave Whyte's sketches
// who's awesome enough to share it.

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float cs(float q) {
  return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 9));
}

float rndSign() {
  return random(1) >= 0.5 ? 1 : -1;
}
