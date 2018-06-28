void setup() {
  size(400, 400);
}

void draw() {
  background(51);

  stroke(255);
  translate(200, height);
  branch(100);
}

void branch(float len) {
  line(0, 0, 0, -len);
  float decay = 0.67;
  translate(0, -len);
  
  //Recursion break condition
  if (len > 4) { 

    pushMatrix();
    rotate(map(mouseX, 0, width, 0, TWO_PI));
    branch(len * decay);
    popMatrix();

    pushMatrix();
    rotate(-map(mouseX, 0, width, 0, TWO_PI));
    branch(len * decay);
    popMatrix();
  }
}
