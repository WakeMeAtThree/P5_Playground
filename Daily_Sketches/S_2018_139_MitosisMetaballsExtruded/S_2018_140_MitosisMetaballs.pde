/*
I've got to implement a better collision detection system
for future use
*/

ArrayList<Ball> balls;
ArrayList<CellM> cells;

Grid grid2D;
float a = 0;
float threshold = 35;
int div = 0;
void setup() {
  size(400, 400, P3D);
   ortho(-width/2, width/2, -height/2, height/2, 10, 1000);
  smooth(8);

  //Instantiate ball list and 2Dgrid
  balls = new ArrayList<Ball>();
  cells = new ArrayList<CellM>();
  grid2D = new Grid(55, 55, cells);
  //CellM init = new CellM(new PVector(width/2, height/2), 80, color(random(100, 255), random(100, 255), random(100, 255)));
  CellM init = new CellM(new PVector(width/2, height/2), 80, color(230));
  cells.add(init);

  //Add balls to ball list
  for (int i = 0; i < 5; i++) {
    balls.add(new Ball());
  }

}
void draw() {
  background(0);

  ArrayList<ArrayList<PVector>> curves = grid2D.displayMetaballs();
  rotateX(PI/6);
  
  for(ArrayList<PVector> curveCell: curves){
    beginShape(QUAD_STRIP);
    for(PVector p: curveCell){
      fill(0);
      vertex(p.x,p.y,0);
      fill(255);
      vertex(p.x,p.y,150);
    }
    endShape();
  }
  for (CellM c : cells) {
    c.move();
    c.show();
  }
  for (CellM p : cells) {
    p.highlight = false;
    for (CellM other : cells) {
      if (p != other) {
        
        float d = PVector.dist(p.loc, other.loc);
        if (d < ((p.r+threshold)/2.0 + (other.r+threshold)/2.0)) {
          
          p.highlight = true;
          p.moveAwayFrom(other,other.r);
        }
      }
    }
  }

  if (keyPressed==true) {
    for (int i = cells.size()-1; i >= 0; i--) {
      CellM c = cells.get(i);
      cells.add(c.mitosis());
      cells.add(c.mitosis());
      //cells.add(c.mitosis());
      //cells.add(c.mitosis());
      cells.remove(i);
    }
    div += 1;
  }
  a += 0.05;
  //saveFrame("numerosette/animation###.png");
}

void draw_() {
  background(255);

  //Run ball behavior
  for (int i = 0; i < balls.size(); i++) {
    float param = 1.0 * i/balls.size();
    balls.get(i).run(param);
    //balls.get(i).display();
  }

  //Display metaballs + debug modes
  grid2D.displayMetaballs();
  //grid2D.displayCorners();
  //grid2D.displayCenters();

  //Animate + Save frames
  //saveFrame("output2/animation###.png");
  a+=0.2;
  //if(a >= TWO_PI) exit();
}

void mouseDragged() {
  PVector other = new PVector(mouseX, mouseY); 
  for (CellM p : cells) {
    float d = PVector.dist(p.loc, other);
    if (d < 50.0) {
      p.highlight = true;
      p.moveAway(other);
    }
  }
}
