class Star {
  PVector loc,ploc;
  float pz;
  
  
  Star() {
    loc = new PVector(random(-width, width), 
      random(-height, height), 
      random(0, width));
    ploc = loc;
    pz = loc.z;
  }

  void update() {
    loc.z = loc.z - speed;
    
    //Avoid dividing by zero
    if(loc.z < 1){
          loc = new PVector(random(-width/2, width/2), 
      random(-height/2, height/2), 
      width);
      pz = loc.z;
    }
  }

  void display() {
    
    color somecolor = lerpColor(color(6,207,237),color(236,7,147),map(sin(a),-1,1,0,1));
    fill(somecolor);
    noStroke();
    
    //Stars
    float sx = map(loc.x/loc.z,0,1,0,width);
    float sy = map(loc.y/loc.z,0,1,0,height);
    
    float r = map(loc.z,0,width,8,0);
    ellipse(sx, sy, r, r);
    
    
    //Line Strikes
    float px = map(loc.x/pz,0,1,0,width);
    float py = map(loc.y/pz,0,1,0,height);
    pz = loc.z;
    
    stroke(255);
    strokeWeight(map(speed,0,50,4,1));
    stroke(somecolor);
    line(px,py,sx,sy);

  }
}