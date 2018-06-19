boolean displayPoints = false;
int div = 25;
float scl;
float a=50;
float shift;
float speed = 0.05;
ArrayList<Module> mods;
float d;

void setup() {
  size(1000, 1000);
  background(0);
  scl = width/div;
  mods = new ArrayList();

  for (int x = 0; x < div; x++) {
    for (int y = 0; y < div; y++) { 
      mods.add(new Module(2*scl*x, 2*scl*y, scl, frac(a)));
    }
  }
}

void draw() {
  background(0);
  
  for (Module mod : mods) {
    mod.display();
    d = dist(mod.x,mod.y,width/2,height/2);
    //d = map(d, 0, dist(0,0,width/2,height/2), 0, 2);
    float d1 = 1-smoothstep(-120,
                   abs(sin(a*2))*1000,d);
    //print(mouseY);
    mod.setParam(d1);
  }

  a+=speed;
  //if (a>0.99 || a < 0.01) speed *= -1;
}

float frac(float x) {
  return x - floor(x);
}

float smoothstep(float lower, float higher, float x) {
  x = constrain((x - lower)/(higher - lower), 0, 1); 
  return x * x * (3 - 2 * x);
}