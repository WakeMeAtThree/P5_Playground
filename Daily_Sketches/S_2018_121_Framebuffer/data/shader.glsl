#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D image;
varying vec4 vertTexCoord;

void main() {
  vec2 st = vertTexCoord.st;   
  vec3 imageColor = texture2D(image, st).rgb;
  gl_FragColor = vec4(imageColor, 1.0);  
}