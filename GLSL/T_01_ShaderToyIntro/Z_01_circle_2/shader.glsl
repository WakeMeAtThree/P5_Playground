#ifdef GL_ES
precision mediump float;
#endif

#define PROCESSING_COLOR_SHADER

uniform vec2 u_resolution;
uniform vec3 u_mouse;
uniform float u_time;

float Circle(vec2 uv, vec2 p, float r, float blur){
    /*Function that creates a circle given 
    (u, v) coordinates, (x,y) position, radius,
    and blur 
    */
    float d = length(uv-p);
    float c = smoothstep(r,r-0.01,d);
    return c;
}

void main() {
    vec2 uv = gl_FragCoord.st/u_resolution;
    
    uv -= .5;
    uv.x *= u_resolution.x/u_resolution.y;
    
    vec3 col = vec3(0.);
    float mask = Circle(uv, vec2(0.), .4, .05);

    mask -= Circle(uv, vec2(-.13,.1), .07, .01);
    mask -= Circle(uv, vec2(.13,.1), .07, .01);
    
    float mouth = Circle(uv, vec2(0.0,0.0), .3, .02);
    mouth -= Circle(uv, vec2(0.0,0.1), .3, .02);
    
    mask -= max(0.0,mouth);

    col = vec3(1.,0.,1.0) * mask;

    gl_FragColor = vec4(col,1.0);
}