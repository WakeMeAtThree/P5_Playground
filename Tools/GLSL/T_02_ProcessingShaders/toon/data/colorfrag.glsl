#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform float fraction;

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

void main() {
  float intensity = max(0.0, dot(vertLightDir, vertNormal));
  vec4 color;
  if(intensity > pow(0.95, fraction)){
    color=vec4(vec3(1.0),1.0);
  } else if(intensity > pow(0.5, fraction)){
    color=vec4(vec3(.6),1.0);
  } else if(intensity > pow(0.25, fraction)){
  color=vec4(vec3(.4),1.0);
  } else {
    color = vec4(vec3(0.2),1.0);
  }
  vec4 col = vec4(1.,.5,.2,1.);
  gl_FragColor = color*col;
}