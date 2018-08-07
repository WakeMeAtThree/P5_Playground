//Author: Ali Al-Saqban (@WakeMeAtThree)
//Title: Metaballs

#ifdef GL_ES
precision highp float;
#endif
#define PROCESSING_COLOR_SHADER

uniform vec2 iResolution;        
uniform vec2 iMouse;
uniform float iTime;             

const int number = 257;
const float scale = 0.004;
uniform vec2 locations[number];
uniform float radii[number];
uniform vec3 colors[number];


float norm(float t, float a, float b){
    return (t-a)/(b-a);
}
float remap(float t, float a, float b, float c, float d){
    return norm(t, a, b) * (d-c) + c;
}

float getMax(float list[number]) {
  int limit = number;
  float maxN = 0.0;
  int maxPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list[i];
    if (value > maxN) {
      maxN = value;
      maxPos = i;
    }
  }
  return maxN;
}
int getMaxP(float list[number]) {
  int limit = number;
  float maxN = 0.0;
  int maxPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list[i];
    if (value > maxN) {
      maxN = value;
      maxPos = i;
    }
  }
  return maxPos;
}


float getMin(float list[number]) {
  int limit = number;
  float minN = 100000000.0;
  int minPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list[i];
    if (value < minN) {
      minN = value;
      minPos = i;
    }
  }
  return minN;
}
int getMinP(float list[number]) {
  int limit = number;
  float minN = 100000000.0;
  int minPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list[i];
    if (value < minN) {
      minN = value;
      minPos = i;
    }
  }
  return minPos;
}


float Circle(vec2 uv, vec2 p, float r, float blur){
    /* Function that creates a circle given 
    (u, v) coordinates, (x,y) position, radius,
    and blur */

    float d = length(uv-p);
    float c = smoothstep(r,r-0.01,d);
    return c;
}
float f_singular(vec2 st,vec2 p,float radius){
    float sum = 0.0;


        float numerator = pow(radius*scale,2.0);
        float denominator = pow(p.x-st.x,2.0)+pow(p.y-st.y,2.0);
        sum = numerator/denominator;

    return sum;
}
float f(vec2 st){
    float sum = 0.0;
    for(int i = 0; i < number; i++){
        vec2 p = locations[i]/iResolution;
        float numerator = pow(radii[i]*scale,2.0);
        float denominator = pow(p.x-st.x,2.0)+pow(p.y-st.y,2.0);
        sum += numerator/denominator;
    }
    return sum;
}

void main()
{
    vec2 st = gl_FragCoord.xy/iResolution.xy;
    vec2 mo = iMouse/iResolution;

    //st.x *= iResolution.x/iResolution.y;
    //float mask = Circle(st, mo, .2, .05);
    
    //Metaballs!
    vec3 col;
    
    float value = f(st);
    int sharpness = 2;
    if(value>=1){
        vec3 avg;
        float sumVals; 
        for(int i = 0; i<number;i++){
            vec2 p = locations[i]/iResolution;
            float f = pow(f_singular(st,p,radii[i]),sharpness);
            avg += colors[i]*f;
            sumVals += f;
        }
        avg *= 1.0/sumVals;
        col += avg*smoothstep(value,0.8,0.9);
    } else {
        col = vec3(0.);
    }

    //Bouncing Balls
    // vec3 col = vec3(0.);
    // float mask;
    // for(int i = 0; i < 100; i++){
    // vec2 p = locations[i]/iResolution;
    // float d = 1.0;
    // mask += Circle(st, p, radii[i], .05);
    // col = d*colors[0] * mask ;
    // }
    
    gl_FragColor = vec4(col,1.0);
}