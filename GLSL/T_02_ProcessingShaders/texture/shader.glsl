#ifdef GL_ES
precision mediump float;
#endif

#define PROCESSING_COLOR_SHADER

uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
    vec3 col = vec3(1.);
    //gl_FragColor = vec4(col,1.0);
    gl_FragColor = textureCube(texture,vertTexCoord.st)*vertColor;;
}