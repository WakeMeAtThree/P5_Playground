class CellM {
  PVector loc;
  float r;
  color ballColor;
  boolean highlight;
  CellM(PVector loc, float r, color c) {
    this.loc = loc.copy();
    this.r = r;
    this.ballColor = c;
  }

  CellM() {
    this.loc  = new PVector(random(width), random(height));
    this.r = 70;
    this.ballColor =  color(random(100, 255), random(50,100), random(100, 255));
  }


  CellM mitosis() {
    //CellM cell = new CellM(this.loc, this.r*0.75, color(lerpColor(color(random(100, 255), random(50,100), random(100, 255)),this.ballColor,0.5)));
    //CellM cell = new CellM(this.loc, this.r*0.75, color(lerpColor(#0EC0E1, #DD3A7C,random(1))));
    CellM cell = new CellM(this.loc, this.r*0.75, lerpColor(this.ballColor, #000000,random(0.35)));
    return cell;
  }
  void bounce(){
    
  }
  void move() {
    PVector vel = PVector.random2D().mult(1.0);
    
    this.loc.add(vel);
  }
  void moveAwayFrom(CellM other,float amount){
    PVector direction = PVector.sub(other.loc,loc).normalize().mult(-7.1);
    this.loc.add(direction);
  }
  
  void moveAway(PVector mouseClick){
    PVector direction = PVector.sub(mouseClick,loc).normalize().mult(5);
    this.loc.add(direction);
  }
  void show() {
    //stroke(this.ballColor);
    noStroke();
    fill(0);
    //ellipse(this.loc.x, this.loc.y, this.r*1.75, this.r*1.75);
  }
}
