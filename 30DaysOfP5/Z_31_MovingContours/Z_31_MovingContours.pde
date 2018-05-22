import java.text.MessageFormat;

float ry, a;
int loop;
ArrayList<PShape> habibi;

void setup() {
  size(500, 500, P3D);
  smooth(8);
  habibi = new ArrayList<PShape>();
  for (int i = 0; i < 111; i++) {
    habibi.add(loadShape(MessageFormat.format("habibi-{0}.obj", i)));
  }
}

void draw() {
  background(0);
  //lights();
  lights1();

  translate(width/2, height/2+100, -200);
  scale(12);
  rotateX(map(height/2, 0, height, 0, PI/2));

  for (int i = 0; i < habibi.size(); i++) {
    float param = 1.0*i/habibi.size();
    pushMatrix();
    rotateZ(ry*param);
    PShape tempShape = habibi.get(i);
    tempShape.setFill(color(252, 237, 245, map(sin(0.1*ry),-1,1,10,150)));
    tempShape.setAmbient(0xff7f7f00);
    
    //tempShape.setEmissive(0xffff0000);
    shape(habibi.get(i));
    popMatrix();
  }
  //saveFrame("output/animation-###.png");

  ry += 1;

}


void lights1() {
  float dirY = ((width/2+width/4) / float(height) - 0.5) * 2;
  float dirX = ((height/2+height/4) / float(width) - 0.5) * 2;
  directionalLight(204, 204, 204, -dirX, -dirY, -1); 
  lightFalloff(100.0, 0.0, 0.0);
  directionalLight(18.0, 141.0, 219.0, 
    dirX, dirY, 0);

  directionalLight(249, 251, 253, 
    -dirX, dirY, 0);
}