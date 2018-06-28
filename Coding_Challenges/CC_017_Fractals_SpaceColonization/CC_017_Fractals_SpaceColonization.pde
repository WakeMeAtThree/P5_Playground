import java.util.Collections;
Tree tree;
float max_dist = 500;
float min_dist = 1;

void setup(){
  size(400,400);
  tree = new Tree();
  
}

void draw(){
  background(51);
  tree.show();
  tree.grow();
}
