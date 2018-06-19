#ifdef GL_ES
precision mediump float;
#endif

#define PROCESSING_COLOR_SHADER

uniform vec2 u_resolution;
uniform vec3 u_mouse;
uniform float u_time;

void main() {
    vec2 uv = gl_FragCoord.st/u_resolution;
    
    uv -= .5; //Similar to uv -= vec2(0.5,0.5)
    uv.x *= u_resolution.x/u_resolution.y;

    float d = length(uv);
    float r = 0.3;

    //Smoother circle
    float c = smoothstep(r,r-0.01,d);
    
    //Jagged circle
    //if(d < .3) c = 1.0; else c = 0.0;

    //gl_FragColor = vec4(uv.x,uv.y,0.0,1.0);
    gl_FragColor = vec4(vec3(c),1.0);
}