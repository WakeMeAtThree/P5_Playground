ArrayList<PVector> lerpVerts(ArrayList<PVector> initial, ArrayList<PVector> target, float a) {
  ArrayList<PVector> output = new ArrayList<PVector>();
  for (int i = 0; i < initial.size(); i++) {
  }
  return output;
}

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
  return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 5));
}

////


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
