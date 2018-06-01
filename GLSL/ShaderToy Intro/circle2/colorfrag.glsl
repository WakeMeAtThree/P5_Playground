#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;

void main() {
  vec2 uv = fragCoord.xy;
  gl_FragColor = vertColor;
}