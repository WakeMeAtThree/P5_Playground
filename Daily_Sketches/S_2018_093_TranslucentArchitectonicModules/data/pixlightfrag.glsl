#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif
#define AA 1   // make this 1 is your machine is too slow
#define PI 3.1415926535897932384626433832795

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 lightDir;
varying vec3 ecPosition;

const int MAX_MARCHING_STEPS = 255;
const float MIN_DIST = 0.0;
const float MAX_DIST = 100.0;
const float EPSILON = 0.0001;
uniform float iTime;    
uniform vec3 eye;
uniform vec3 target;
uniform vec3 iResolution;  
uniform vec3 iMouse;  

vec3 phongContribForLight(vec3 k_d, vec3 k_s, float alpha, vec3 p, vec3 eye,
                          vec3 lightPos, vec3 lightIntensity) {
    vec3 N = normalize(ecNormal);
    vec3 L = normalize(lightPos - p);
    vec3 V = normalize(eye - p);
    vec3 R = normalize(reflect(-L, N));
    
    float dotLN = dot(L, N);
    float dotRV = dot(R, V);
    
    if (dotLN < 0.0) {
        // Light not visible from this point on the surface
        return vec3(0.0, 0.0, 0.0);
    } 
    
    if (dotRV < 0.0) {
        // Light reflection in opposite direction as viewer, apply only diffuse
        // component
        return lightIntensity * (k_d * dotLN);
    }
    return lightIntensity * (k_d * dotLN + k_s * pow(dotRV, alpha));
}

vec3 phongIllumination(vec3 k_a, vec3 k_d, vec3 k_s, float alpha, vec3 p, vec3 eye) {
    const vec3 ambientLight = 0.5 * vec3(1.0, 1.0, 1.0);
    vec3 color = ambientLight * k_a;
    float t = 12.8;
    vec3 light1Pos = vec3(4.0 * sin(t),
                          2.0,
                          4.0 * cos(t));
    vec3 light1Intensity = vec3(0.4, 0.4, 0.4);
    
    color += phongContribForLight(k_d, k_s, alpha, p, eye,
                                  light1Pos,
                                  light1Intensity);
    
    vec3 light2Pos = vec3(2.0 * sin(0.37 * t),
                          2.0 * cos(0.37 * t),
                          2.0);
    vec3 light2Intensity = vec3(0.904/2.0,0.946/2.0,0.965/2.0);
    
    color += phongContribForLight(k_d, k_s, alpha, p, eye,
                                  light2Pos,
                                  light2Intensity);    
    return color;
}


void main() {  
  vec3 direction = normalize(lightDir);
  vec3 normal = normalize(ecNormal);
  float intensity = max(0.0, dot(direction, normal));
  
  /* figure out how to replace eye here */
  //vec3 eye = vec3(0.0, 255.0, 5555.0+sin(iTime));

  vec3 K_a = vertColor.xyz*vec3(0.2, 0.2, 0.2);
  vec3 K_d = vertColor.xyz;
  vec3 K_s = vec3(1.0, 1.0, 1.0);
  float shininess = 10.0;

 vec3 color = phongIllumination(K_a, K_d, K_s, shininess, ecPosition, eye);

  //gl_FragColor = vec4(intensity, intensity, intensity, 1) * vertColor;
  gl_FragColor = vec4(color, 1.0);
}
