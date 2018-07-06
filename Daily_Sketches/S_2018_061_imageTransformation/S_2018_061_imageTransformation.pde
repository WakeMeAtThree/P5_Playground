PImage image;
PShader imageShader;
float a;

void setup() {
  size(400, 400, P2D);
  image = loadImage("apple.jpg");
  imageShader = loadShader("imageShader.glsl");
  imageShader.set("imageSampler", image);
  
}

void draw() {
  background(0);

  shader(imageShader);
  drawMesh(15,15,a);
  saveFrame("output/animation###.png");
  a += 0.1;
  if(a >= TWO_PI) exit();
}

ArrayList<PVector[]> drawStrip(int x, int y, float a) {
  ArrayList<PVector[]> stripList = new ArrayList<PVector[]>();
  for (int j = 0; j < x+1; j++) {
    PVector[] strip = new PVector[x+1];
    for (int i = 0; i < y+1; i++) {
      float param = 25.0*(i+j)/(x+1+y+1);
      //Moving vectors
      strip[i] = new PVector(width/y * i + 15*cos(a+param), height/(y-1) * j+ 15*sin(a+param), 0);
      //Static vectors
      //strip[i] = new PVector(width/y * i, height/(y-1) * j, 0);
    }
    stripList.add(strip);
  }
  return stripList;
}

void drawMesh(int x, int y, float a) {
  ArrayList<PVector[]> strips = drawStrip(x, y, a);
  for (int i = 0; i < strips.size()-2; i++) {
    float v1 = 1.0*i/(strips.size()-2);
    float v2 = 1.0*(i+1)/(strips.size()-2);

    PVector[] list1=strips.get(i);    
    PVector[] list2=strips.get((i+1));

    beginShape(QUAD_STRIP);

    for (int j = 0; j < list1.length; j++) {

      float u = 1.0*j/(list1.length-1);
      PVector vec1 = list1[j];
      PVector vec2 = list2[j];

      vertex(vec1.x, vec1.y, u, v1);
      vertex(vec2.x, vec2.y, u, v2);
    }

    endShape();
  }
}