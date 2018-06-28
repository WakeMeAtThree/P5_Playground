class Tree {
  ArrayList<Leaf> leaves = new ArrayList<Leaf>();
  ArrayList<Branch> branches = new ArrayList<Branch>();
  Tree() {
    //Add leaves to Tree
    int amount = 5;
    float Xspacing = width/amount;
    float Yspacing = height/amount;
//Hexagonal leaf seeds;
    for (int i = 0; i < amount; i++) {
      for (int j = 0; j < amount; j++) {
        for(int k = 0; k < 10; k++){
        if (j % 2 == 0) {
          PVector pos = new PVector(Xspacing*i, Yspacing*j,k*Xspacing);
          leaves.add(new Leaf(pos));
        } else {
          PVector pos = new PVector(Xspacing*i+Xspacing/2, Yspacing*j,k*Xspacing);
          leaves.add(new Leaf(pos));
        }
        }
      }
    }

    //Add root to branches
    PVector rpos = new PVector(width/2, height/2,0); 
    PVector rdir = new PVector(0, -1,0);
    Branch root = new Branch(rpos, rdir);
    branches.add(root);
    Branch current = new Branch(root);

    //
    while (!closeEnough(current)) {
      Branch trunk = new Branch(current);
      branches.add(trunk);
      current = trunk;
    }
  }

  boolean closeEnough(Branch b) {
    for (Leaf l : leaves) {
      float d = PVector.dist(b.pos, l.pos);
      if (d < max_dist) {
        return true;
      }
    }
    return false;
  }
  void grow() {
    //First loop
    for (Leaf l : leaves) {
      Branch closest = null;
      PVector closestDir = null;
      float record = -1; //What does this do again?
      // comment
      for (Branch b : branches) {
        PVector dir = PVector.sub(l.pos, b.pos);
        float d = dir.mag();
        if (d < min_dist) {
          l.reached();
          closest = null;
          break;
        } else if (d > max_dist) {
          //Why is this blank?
        } else if (closest == null || d < record) {
          closest = b;
          closestDir = dir;
          record = d;
        }
      }

      // comment
      if (closest != null) {
        closestDir.normalize();
        closest.dir.add(closestDir);
        closest.count++;
      }
    }

    //Second loop
    for (int i = leaves.size()-1; i >= 0; i--) {
      if (leaves.get(i).reached) {
        leaves.remove(i);
      }
    }

    //Third loop
    for (int i = branches.size()-1; i >= 0; i--) {
      Branch b = branches.get(i);
      if (b.count > 0) {
        b.dir.div(b.count);
        b.dir.normalize();
        Branch newB = new Branch(b);
        branches.add(newB);
        b.reset();
      }
    }
  }
  void show() {
    for (Leaf l : leaves) {
      l.show();
    }
    for (Branch b : branches) {
      if (b.parent != null) {
        stroke(255);
        line(b.pos.x, b.pos.y, b.pos.z,
             b.parent.pos.x, b.parent.pos.y, b.parent.pos.z);
      }
    }
  }
}
