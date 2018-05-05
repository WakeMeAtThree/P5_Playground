String txt;
float y;
void setup() {
  //size(800, 600, P3D);
  fullScreen(P3D);
  String[] lines = loadStrings("space.txt");
  txt = join(lines, "\n");
  y = height;
}

void draw() {
background(0);

fill(238, 213, 75);
textSize(64);
textAlign(CENTER);
rotateX(PI/4);
text(txt, 0, y, width, height);
y-=2;
}
