float a;
ArrayList<Float> offsets;
int g_n = 6;
void setup() {
  size(400, 400);
  background(255);
  noFill();
  strokeWeight(1);
  offsets = getRandomSteps(g_n);
}

void draw() {
  background(255);

  translate(width/2, height/2);
  scale(0.25);
  beginShape();
  for (float i = 0; i <= TWO_PI; i+=TWO_PI/500) {
    float param = (i)/(TWO_PI);
    float sum = 0;
    //sum += 0.5*step((0.2+sin(a))%1.0,param);
    //sum += 0.5*step((0.8+sin(a))%1.0,param);
    float r = lerp(50, 200, multistep(g_n,(param+a)%1.0,a));
    vertex(r*cos(i), r*sin(i));
  }
  endShape(CLOSE);

  a+=0.01;
}
ArrayList<Float> getRandomSteps(int n){
  ArrayList<Float> output = new ArrayList<Float>();
  for(int i = 0; i < n; i++){
    output.add(random(1));
  }
  return output;
}
float multistep(int n, float param, float a){
  float output = 0;
  float mult = 1.0*1/n;
  for(int i = 0; i < n; i++){
    float paramt = 1.0*i/n;
    output += paramt*step((a+offsets.get(i))%1.0,param);
  }
  
  return output;
}

float smoothstep(float edge0, float edge1, float x) {
  x = constrain((x - edge0) / (edge1 - edge0), 0.0f, 1.0f); 
  return x * x * (3 - 2 * x);
}
float step(float threshold, float value){
  if(value > threshold){
    return 1.0;
  }
  return 0.0;
}
