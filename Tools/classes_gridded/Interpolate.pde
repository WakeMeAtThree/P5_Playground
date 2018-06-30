float func(int n, float time, float delay) {
  /* 
   Turn divide function into a periodic function
   by mapping a sin function with divide 
   */
  return divide(n, 1, 1, map(sin(time+delay), -1, 1, 0, 1));
}

float divide(int n, float xRange, float yRange, float j) {

  /*
  This function was discovered while playing around with GLSL editor in the BookOfShaders. I was
   trying to create a variable multistep function that is also periodic, this is the first half of it.
   int n : number of steps
   float xRange: max X
   float yRange: max Y
   float j: moving parameter (time, a, etc...)
   */

  float outputVal = 0;
  for (int i=0; i<n; i++) {
    float a = float(n);
    outputVal += (yRange/(a-1.))*smoothstep(xRange*i/a, xRange*i/a-0.2, j);
  }
  return outputVal;
}

float smoothstep(float edge0, float edge1, float x) {
  x = constrain((x - edge0) / (edge1 - edge0), 0.0f, 1.0f); 
  return x * x * (3 - 2 * x);
}

//Polar lerp I wrote a while back. Test other lerping tools I made instead of PVector.lerp
//to see how they turn out

float radius(float x, float y, float z) {
  return sqrt(pow(x, 2)+pow(y, 2)+pow(z, 2));
}
float theta(float x, float y, float z) {
  return acos(z/radius(x, y, z));
}
float phi(float x, float y, float z) {
  return atan2(y, x);
}

PVector PLerp2(PVector v1, PVector v2, float a) {
  float radius1 = radius(v1.x, v1.y, v1.z);
  float theta1 = theta(v1.x, v1.y, v1.z);
  float phi1 = phi(v1.x, v1.y, v1.z);

  float radius2 = radius(v2.x, v2.y, v2.z);
  float theta2 = theta(v2.x, v2.y, v2.z);
  float phi2 = phi(v2.x, v2.y, v2.z);

  float r = lerp(radius1, radius2, a);
  float theta = lerp(theta1, theta2, a);
  float phi = lerp(phi1, phi2, a);

  PVector blend = new PVector(r*sin(theta)*cos(phi), 
    r*sin(theta)*sin(phi), 
    r*cos(theta));
  return blend;
}
