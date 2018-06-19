#ifdef GL_ES
precision mediump float;
#endif

#define PROCESSING_COLOR_SHADER
#define S(a, b, t) smoothstep(a,b,t)
#define sat(x) clamp(x, 0., 1.)
uniform vec2 u_resolution;
uniform vec3 u_mouse;
uniform float u_time;

float remap(float t, float a, float b, float c, float d){
    return clamp(((t-a)/(b-a)) * (d-c) + c,c,d);
}
vec2 within(vec2 uv, vec4 rect){
    return (uv-rect.xy)/(rect.zw-rect.xy);
}
vec4 Eye(vec2 uv){
    uv -= .5;
    float d = length(uv);
    vec4 irisCol = vec4(.3,.5,1.,1.);
    vec4 col = mix(vec4(1.),irisCol, S(.1,.7,d)*.5); 
    col.rgb *= 1. - S(.45, .5, d)*.5*sat(-uv.y-uv.x);
    col.rgb = mix(col.rgb,vec3(0.),S(.3,.28,d)); 
    irisCol.rgb *= 1. + S(.3, .05, d);
    col.rgb = mix(col.rgb,irisCol.rgb,S(.28,.25,d));
    col.rgb = mix(col.rgb,vec3(0.),S(.16,.14,d));
    float highlight = S(.1, .09, length(uv-vec2(-.15,.15)));
    //INCOMPLETE, PAUSED HERE
    //highlight += S(.1, .09, length(uv-vec2(-.15,.15)));
    col.rgb = mix(col.rgb, vec3(1.), highlight);
    col.a = S(.5,.48,d);
    return col;
}
vec4 Mouth(vec2 uv){
    vec4 col = vec4(0.);
    return col;
}
vec4 Head(vec2 uv){
    vec4 col = vec4(.9,.65,.1,1.);
    float d = length(uv);
    
    col.a = S(.5,.49,d);
    
    float edgeShade = remap(d,.35,.5,0,1);
    edgeShade *= edgeShade;

    col.rgb *= 1.-edgeShade*.5;
    col.rgb = mix(col.rgb, vec3(.6,.3,.1), S(.47,.48,d));
    float highlight = S(.41,.405,d);
    highlight *= remap(uv.y,.41,-.1,.75,0.);
    col.rgb = mix(col.rgb,vec3(1.),highlight);

    d = length(uv-vec2(.25,-.2));
    float cheek = S(.2,.01,d)*.4;
    cheek *= S(.17, .16, d);
    col.rgb = mix(col.rgb,vec3(1.,.1,.1),cheek);

    return col;
}
vec4 Smiley(vec2 uv){
    vec4 col = vec4(0.);
    
    uv.x = abs(uv.x);
    vec4 head = Head(uv);
    vec4 eye = Eye(within(uv,vec4(.03,-.1,.37,.25)));

    col = mix(col,head,head.a);
    col = mix(col,eye,eye.a);
    return col;
}

void main(){
    vec2 uv = gl_FragCoord.st/u_resolution;
    uv -= .5;
    uv.x *= u_resolution.x/u_resolution.y;
    
    gl_FragColor = Smiley(uv);

}