class Branch {
  Branch parent;
  PVector pos, dir, saveDir;
  int count = 0;
  float len = 8;
  
// First constructor
  Branch(PVector pos_, PVector dir_){
    parent = null;
    pos = pos_.copy();
    dir = dir_.copy();
    saveDir = dir.copy();
  }
  
// Second constructor
  Branch(Branch p) {
    parent = p;
    pos = parent.next();
    dir = parent.dir.copy();
    saveDir = dir.copy(); 
  }

  PVector next() {
    PVector v = PVector.mult(dir, len);
    PVector next = PVector.add(pos, v);
    return next;
  }
  
  void reset(){
    count = 0;
    dir = saveDir.copy();
  }

}
