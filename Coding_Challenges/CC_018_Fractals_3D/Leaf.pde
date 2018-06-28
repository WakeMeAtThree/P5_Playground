class Leaf{
  PVector pos;
  boolean reached = false;
  
  Leaf(PVector pos_){
    //You can play around with how to 
    //vary the positions here
    
    //pos = new PVector(random(width),random(height));
    pos = pos_;
  }
  void reached(){
    reached = true;
  }
  
  void show(){
    noStroke();
    fill(255);
    //ellipse(pos.x,pos.y,4,4);
  }
}
