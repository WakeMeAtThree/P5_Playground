#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;

void main() {
  vec4 col = vec4(1.,.0,.5,1.);
  gl_FragColor = col*vertColor;
}