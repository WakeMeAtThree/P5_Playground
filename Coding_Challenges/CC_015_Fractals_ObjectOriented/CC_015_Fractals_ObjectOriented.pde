
ArrayList<Branch> tree;
ArrayList<PVector> leaves;
int count;


void setup() {
  size(400, 400);
  tree = new ArrayList<Branch>();
  leaves = new ArrayList<PVector>();
  PVector a = new PVector(width/2, height);
  PVector b = new PVector(width/2, height-100);

  Branch root = new Branch(a, b);
  tree.add(root);
}

void mousePressed() {
  for (int i =tree.size()-1; i >= 0; i--) {
    if (!tree.get(i).finish) {
      tree.add(tree.get(i).branchA());
      tree.add(tree.get(i).branchB());
    }
    tree.get(i).finish = true;
  }
  count++;
  if (count % 5 == 0) {
    for (int i = 0; i < tree.size(); i++) {
      if (!tree.get(i).finish) {
        PVector leaf = tree.get(i).end.copy();
        leaves.add(leaf);
      }
    }
  }
}
void draw() {
  background(51);
  for (Branch p : tree) {
    p.display();
    //p.jitter();
  }
  for (PVector p : leaves) {
    fill(255, 0, 100);
    noStroke();
    ellipse(p.x,p.y,8,8);
    p.y += random(0,2);
    //p.jitter();
  }
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