float a = 0;
float b = 0;
PShader blur;
void setup(){
  size(600,600,P2D);
  //blendMode(ADD);
  colorMode(HSB,1,1,1,1);
  background(1);
  blur = loadShader("blur.glsl");
}

void draw(){
  fill(1,0.0001);
  noStroke();
  rect(0,0,width,height);
  filter(blur);
  translate(width/2,height/2);
  rotate(a);
  scale(map(sin(b),-1,1,0,1.25));
  strokeWeight(6);
  stroke(map(sin(a+PI),0,1,0.2,0.6),0.8,abs(sin(a+1.5*PI))+0.9+0.1,0.55);
  pushStyle();
  strokeWeight(10);
  stroke(map(sin(a+PI),0,1,0.2,0.6),1,abs(sin(a+1.5*PI))+0.9+0.1);
  point(-width/4,-height/4);
  point(width/4,height/4);
  popStyle();
  line(-width/4,-height/4,width/4,height/4);
  
  a += 0.147+noise(millis()/1000)/10 ;
  b += 0.123457;
  
  //saveFrame("animation/output####.png");
  
  
  
}