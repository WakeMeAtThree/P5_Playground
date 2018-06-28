
void setup() {
  size(400, 400);
  
  

  //float r = 100;
}

void draw(){
  background(51);
  translate(width/2, height/2);
  float a = mouseX/2;
  float b = mouseY/2;
  float n = 2;
  if(mousePressed) n = map(mouseX,0,width,0,10);
  strokeWeight(5); 
  noFill();
  stroke(255);

  beginShape();
  for (float i = 0; i < TWO_PI; i +=0.1 ) {
    //float x = r*cos(i);
    //float y = r*sin(i);
    float na = 2/n;
    float x = pow(abs(cos(i)),na) * a * sgn(cos(i));
    float y = pow(abs(sin(i)),na) * b * sgn(sin(i));
    vertex(x, y);
  }
  endShape(CLOSE);
}

int sgn(float x){
  if(x > 0){
    return 1;
  } else if (x < 0) {
    return -1;
  } else { 
    return 0;
  }
}
