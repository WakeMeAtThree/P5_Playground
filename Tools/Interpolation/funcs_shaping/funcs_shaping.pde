void setup(){
  size(400,400);
//  translate(0,height/2);
  noFill();

}

void draw(){
  background(128);
  float value = map(mouseX, 0, width,0,100);
  //fill(0,255,0);
  
  strokeWeight(1);
  beginShape();
  for(float i = 0; i < width; i+=1){
    
    //vertex(i,sin(i*0.1)*50);
    //vertex(i,floor(i/value)*value);
    vertex(i,i%mouseX);
    //vertex(i,abs(i-value));
    //vertex(i,constrain(i,0,value));
    //vertex(i,smoothstep(0,mouseX,i)*100);
    

    //vertex(i,step(mouseX)*100);
    
  }
  endShape();
}

float smoothstep(float edge0, float edge1, float x) {
  // Scale, bias and saturate x to 0..1 range
  x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0); 
  // Evaluate polynomial
  return x * x * (3 - 2 * x);
}

//float step(){
//    // Step will return 0.0 unless the value is over 0.5,
//    // in that case it will return 1.0
    
//}