class Box {
  PVector pos;
  float r;
  color colored;
  Box(PVector pos, float r) {
    this.pos = pos;
    this.r = r;
    this.colored = color(random(255),random(255),random(255));;
  }
  
  ArrayList<Box> generate() {
    ArrayList<Box> boxes = new ArrayList<Box>();
    for (int x = -1; x < 2; x++) {
      for (int y = -1; y < 2; y++) {
        for (int z = -1; z < 2; z++) {
          int sum = abs(x) + abs(y) + abs(z);
          if(sum > 1){ //<= 1
          float newR = r/3;
          Box b = new Box(new PVector(pos.x+x*newR, 
                                      pos.y+y*newR, 
                                      pos.z+z*newR), 
                                              newR);
          boxes.add(b);
          }
        }
      }
    }
    return boxes;
  }
  
  void show() {
    pushMatrix();
fill(colored);
    //stroke(0);
    noStroke();
    translate(pos.x, pos.y, pos.z);
    box(r);
    popMatrix();
  }
}