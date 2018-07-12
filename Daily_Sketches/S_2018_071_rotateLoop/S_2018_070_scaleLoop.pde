float a;
PVector c0,c1,c2,c3,cm1;
PVector origin;
void setup() {
  size(400, 400,P2D);
  rectMode(CENTER);
  smooth(8);
  blendMode(EXCLUSION);
  noStroke();
  origin = new PVector(0,0);
  cm1 = new PVector(0,0);
  c0 = new PVector(25,25);
  c1 = new PVector(-25,25);
  c2 = new PVector(25,-25);
  c3 = new PVector(-25,-25);
}
void draw() {
  background(0);
  translate(width/2,height/2);
  scale(lerp(1,2,smoothstep(0.1,0.6,a%1.0)));
  rotate(lerp(0,PI/2,0.5*smoothstep(0.3,0.5,a%1.0)+
  0.5*smoothstep(0.7,0.9,a%1.0)));

  
  rectCustom(origin,lerp(0,50,smoothstep(0.4,0.8,a%1.0)));
  rectCustom(PVector.lerp(c0,origin,0.5*smoothstep(0.3,0.5,a%1.0)+
  0.5*smoothstep(0.7,0.9,a%1.0)),50);
  rectCustom(PVector.lerp(c1,origin,a%1.0),50);
  rectCustom(PVector.lerp(c2,origin,a%1.0),50);
  rectCustom(PVector.lerp(c3,origin,0.5*smoothstep(0.3,0.5,a%1.0)+
  0.5*smoothstep(0.7,0.9,a%1.0)),50);


  
  
  a+=0.01;
}

void rectCustom(PVector loc, float size){
  rect(loc.x,loc.y,size,size);
}

float smoothstep(float edge0, float edge1, float x) {
  x = constrain((x - edge0) / (edge1 - edge0), 0.0f, 1.0f); 
  return x * x * (3 - 2 * x);
}

float expStep( float x, float k, float n ){
    return exp( -k*pow(x,n) );
}
