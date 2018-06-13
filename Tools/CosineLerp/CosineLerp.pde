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
  
  //Ortho lerp
  //if (!toggle) {
  //  display.x = lerp(current.x, target.y, a);
  //} else {
  //  display.y = lerp(current.y, target.y, a);
  //}
  
  //Diagonal lerp random? walk
  float radius = Clerp(0.5,10,a);
  display = VClerp(current,target,a);
  println(display);
  
  //Curvey Lerp
  //translate(width/2,height/2);
  //float radius = lerp(currentP.radius,targetP.radius,a);
  //float angle = lerp(currentP.angle,targetP.angle,a);
  //displayP = new Polar(radius,angle);
  
  ellipse(display.x, display.y,radius,radius);

  a += 0.01;
  if (a > 1) {
      fill(255,0,0);

    target = new PVector(random(width), random(height));
    targetP = new Polar(random(200),random(TWO_PI));
      ellipse(target.x,target.y,5,5);
    currentP = displayP;
    current = display.copy();
    a=0;
    toggle = !toggle;
  }
}

PVector PLerp(PVector v1, PVector v2, float a){
 float radius1 = dist(0,0,v1.x,v1.y);
 float angle1 = atan(v1.y/v1.x);
 
 float radius2 = dist(0,0,v2.x,v2.y);
 float angle2 = atan(v2.y/v2.x);
 
 float r = lerp(radius1,radius2,a);
 float theta = lerp(angle1,angle2,a);
 
 PVector blend = new PVector(r*cos(theta),r*sin(theta));
 return blend;

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

PVector PLerp2(PVector v1, PVector v2, float a){
 float radius1 = radius(v1.x,v1.y,v1.z);
 float theta1 = theta(v1.x,v1.y,v1.z);
 float phi1 = phi(v1.x,v1.y,v1.z);
 
 float radius2 = radius(v2.x,v2.y,v2.z);
 float theta2 = theta(v2.x,v2.y,v2.z);
 float phi2 = phi(v2.x,v2.y,v2.z);
 
 float r = lerp(radius1,radius2,a);
 float theta = lerp(theta1,theta2,a);
 float phi = lerp(phi1,phi2,a);
 
 PVector blend = new PVector(r*sin(theta)*cos(phi),
                             r*sin(theta)*sin(phi),
                             r*cos(theta));
 return blend;

}

float Clerp(
   float y1,float y2,
   float mu)
{
   float mu2;

   mu2 = (1-cos(mu*PI))/2;
   return (y1*(1-mu2)+y2*mu2);
}

PVector VClerp(PVector v1, PVector v2, float mu){
  return new PVector(Clerp(v1.x,v2.x,mu),Clerp(v1.y,v2.y,mu*0.65));
}
