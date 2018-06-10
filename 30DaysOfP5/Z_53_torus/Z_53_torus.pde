ArrayList<ArrayList<PVector>> torus;
int sectionRes = 40;
int railRes = 100;

float ang1 = TWO_PI/sectionRes;
float ang2 = TWO_PI/railRes;
float a;

void setup() {
  size(400, 400, P3D);
  background(255);
  torus = new ArrayList<ArrayList<PVector>>();
}

void draw() {
  background(255);
  lights();

  //Setup lights and coordinate system
  translate(width/2, height/2, -200);
  rotateX(PI/4);
  rotateZ(a);

  //Display Settings
  strokeWeight(1);
  stroke(255, 0, 128, 50);
  fill(255);

  //Store previous section's radius
  float radius1, radius2;
  radius2=0;
  for (float i = 0; i < TWO_PI+ang2; i+=ang2) {
    //Delay offset
    float param = 15.0*TWO_PI * i/(TWO_PI+ang2);

    //Set radius to the two sections
    radius1 = lerp(5, 35, fract(a+param));
    ArrayList<PVector> vertices1 = torusSection(i, radius2, 200);
    ArrayList<PVector> vertices2 = torusSection(i+ang2, radius1, 200);
    radius2 = radius1;

    //Draw strip
    beginShape(QUAD_STRIP);
    for (int j = 0; j < sectionRes+1; j++) {
      PVector vert1 = vertices1.get(j%sectionRes);
      PVector vert2 = vertices2.get(j%sectionRes);
      vertex(vert1.x, vert1.y, vert1.z);
      vertex(vert2.x, vert2.y, vert2.z);
    }
    endShape();
  }

  //Clear torus elements
  torus = new ArrayList<ArrayList<PVector>>();

  //Animate
  a += 0.01;
  if(a > 0.5) exit();
  //saveFrame("output/animation###.png");
}

ArrayList<PVector> torusSection(float rot, float radius, float offset) {
  /* This function takes in radius of circle section, offset distance 
   from origin, and rotation from origin and returns a list of
   section vertices. Spherical coordinates are used for vectors.
   */

  float phi = 0;
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  for (float i=0; i<=TWO_PI; i+=ang1) {
    PVector vert = new PVector();
    vert.x = offset+radius*sin(i)*cos(phi);
    vert.y = 0 + radius*sin(i)*sin(phi);
    vert.z = radius*cos(i);
    vert.rotate(rot);
    vertices.add(vert);
  }

  return vertices;
}

//Some sample shaping funcs

float func1(float a, float param) {
  return map(sin(a+param), -1, 1, 0, 1);
}

float fract(float x) {
  return x - floor(x);
}

float step(float x, float threshold) {
  // Step will return 0.0 unless the value is over 0.5,
  // in that case it will return 1.0
  if (x>threshold) {
    return 1.0;
  } else {
    return 0.0;
  }
}
