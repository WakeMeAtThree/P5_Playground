import peasy.*;



import java.util.Collections;
Tree tree;
float max_dist = 500;
float min_dist = 1;
PeasyCam cam;
void setup(){
  size(400,400,P3D);
  cam = new PeasyCam(this, 500);
  tree = new Tree();
  
}

void draw(){
  background(51);
  tree.show();
  tree.grow();
}
