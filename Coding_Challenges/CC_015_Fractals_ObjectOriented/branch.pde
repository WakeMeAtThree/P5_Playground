class Branch {
  PVector begin, end;
  boolean finish;

  Branch(PVector begin_, PVector end_) {
    begin = begin_;
    end = end_;
  }

  void display() {
    stroke(255);
    line(begin.x, begin.y, end.x, end.y);
  }

  Branch branchA() {
    
    PVector dir = PVector.sub(end, begin);
    dir.rotate(PI/6);
    dir.mult(0.67);
    PVector newEnd = PVector.add(end, dir);
    Branch right = new Branch(end, newEnd);
    return right;
    //Branch left = new Branch();
  }
  Branch branchB() {
    PVector dir = PVector.sub(end, begin);
    dir.rotate(-PI/4);
    dir.mult(0.67);
    PVector newEnd = PVector.add(end, dir);
    Branch right = new Branch(end, newEnd);
    return right;
  }
  
  void jitter(){
    end.x += random(-1,1);
    end.y += random(-1,1);
  }
}