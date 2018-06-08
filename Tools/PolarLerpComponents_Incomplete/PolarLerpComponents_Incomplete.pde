PVector current, display, target;
Polar currentP, displayP, targetP;
float a;
boolean toggle;

void setup() {
  size(400, 400);
  background(255);
  //blendMode(DIFFERENCE);
  
  
  
  targetP = new Polar(random(200),random(TWO_PI));
  currentP = new Polar(0,0);
  displayP = new Polar(0,0);
  
  current = new PVector(1, 0);
  display = new PVector(0, 0);
  target = new PVector(random(width), random(height));
  
  println(current.x);
}

void draw() {

  strokeWeight(random(3,5));
  noStroke();

  fill(0,50);

  display = PLerp(current,target,a);
  println(display);
  
  ellipse(display.x, display.y,5,5);

  a += 0.01;
  if (a > 2) {
     a = 0;
      fill(255,0,0);

    target = new PVector(random(width), random(height));
    targetP = new Polar(random(200),random(TWO_PI));
      ellipse(target.x,target.y,5,5);
    currentP = displayP;
    current = display.copy();

    toggle = !toggle;

  }
}


//

float radius(float x, float y, float z){
  return sqrt(pow(x,2)+pow(y,2)+pow(z,2));
}
float theta(float x, float y, float z){
  return acos(z/radius(x,y,z));
}
float phi(float x, float y, float z){
  return atan2(y,x);
}
PVector PLerpPart2(PVector v1, PVector v2, float a){
 float radius1 = radius(v1.x,v1.y,v1.z);
 float theta1 = theta(v1.x,v1.y,v1.z);
 float phi1 = phi(v1.x,v1.y,v1.z);
 
 float radius2 = radius(v2.x,v2.y,v2.z);
 float theta2 = theta(v2.x,v2.y,v2.z);
 float phi2 = phi(v2.x,v2.y,v2.z);
 
 float r = lerp(radius1,radius2,1);

 float theta = lerp(theta1,theta2,a);

 float phi = lerp(phi1,phi2,a);

 
 PVector blend = new PVector(r*sin(theta)*cos(phi),
                             r*sin(theta)*sin(phi),
                             r*cos(theta));
 return blend;

}
PVector PLerpPart1(PVector v1, PVector v2, float a){
 float radius1 = radius(v1.x,v1.y,v1.z);
 float theta1 = theta(v1.x,v1.y,v1.z);
 float phi1 = phi(v1.x,v1.y,v1.z);
 
 float radius2 = radius(v2.x,v2.y,v2.z);
 float theta2 = theta(v2.x,v2.y,v2.z);
 float phi2 = phi(v2.x,v2.y,v2.z);
 
 float r = lerp(radius1,radius2,a);

 float theta = lerp(theta1,theta2,0);

 float phi = lerp(phi1,phi2,0);

 
 PVector blend = new PVector(r*sin(theta)*cos(phi),
                             r*sin(theta)*sin(phi),
                             r*cos(theta));
 return blend;

}
PVector PLerp(PVector v1, PVector v2, float a){
 float radius1 = radius(v1.x,v1.y,v1.z);
 float theta1 = theta(v1.x,v1.y,v1.z);
 float phi1 = phi(v1.x,v1.y,v1.z);
 
 float radius2 = radius(v2.x,v2.y,v2.z);
 float theta2 = theta(v2.x,v2.y,v2.z);
 float phi2 = phi(v2.x,v2.y,v2.z);
 float r,theta,phi;
if(a <= 1){
  r = lerp(radius1,radius2,a);
  theta = lerp(theta1,theta2,0);
  phi = lerp(phi1,phi2,0);
} else {
  r = lerp(radius1,radius2,1);
  theta = lerp(theta1,theta2,0);
  phi = lerp(phi1,phi2,a/2);  
}

 
 PVector blend = new PVector(r*sin(theta)*cos(phi),
                             r*sin(theta)*sin(phi),
                             r*cos(theta));
 return blend;

}
