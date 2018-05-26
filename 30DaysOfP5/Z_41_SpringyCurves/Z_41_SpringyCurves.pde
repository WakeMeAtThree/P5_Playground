/*
Applying what I've learnt from Etienne Jacob's tutorial on 
his trick with looping curves. Managed to turn it into an 
adaptable class for future use.
*/

Springy a;
ArrayList<Springy> polysprings;
float time;

void setup() {
  size(500, 500);
  background(0);

  polysprings = new ArrayList<Springy>();
  
  ArrayList<PVector> vertices = polygon(width/2.0, height/2.0, 200.0, 7);
  //ArrayList<PVector> vertices = new ArrayList<PVector>();
  //for(int i = 0; i < 55; i++){
  //  vertices.add(new PVector(random(width),random(height)));
  //}
  vertices.add(vertices.get(0));
  for (int i = 0; i < vertices.size()-1; i++) {
    Springy temp = new Springy(vertices.get(i), vertices.get(i+1), 500);
    polysprings.add(temp);
  }

  a = new Springy(new PVector(mouseX, mouseY), new PVector(width/2, height/2), 25);

  println(polygon(width/2.0, height/2.0, 200.0, 5));
}

void draw() {
  background(0);

  for (Springy a : polysprings) {
    a.coil();
    a.display();
  }
  //a = new Springy(new PVector(mouseX, mouseY), new PVector(width/2, height/2), 500);
  //a.delay1 = 25*sin(time);
  //a.r1 = 25*sin(time);
  //a.r2 = 25;//*sin(time+PI);
  //a.coil();
  //a.display();

  time += 0.05;
}

ArrayList<PVector> polygon(float x, float y, float radius, int npoints) {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  float angle = TWO_PI / npoints;

  for (float a = 0; a < TWO_PI; a += angle) {
    float x_ = x + radius*cos(a);
    float y_ = y + radius*sin(a);
    vertices.add(new PVector(x_, y_));
  }
  return vertices;
}
