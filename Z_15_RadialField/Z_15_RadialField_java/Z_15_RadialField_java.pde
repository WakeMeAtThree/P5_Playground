import java.util.Collections;
import java.util.Comparator;
import java.util.List;

class Node {
  int x, y;
  float r;
  public Node(int x, int y) {
    this.x = x;
    this.y = y;
    this.r = 15.0;
  }

  void grow(float speed) {
    this.r = map(35*abs(sin(speed*0.1)), 0, 35, 15, 35);
  }

  void display() {
    ellipse(this.x, this.y, this.r, this.r);
  }
}


int spacing = 20;
List<Node> nodes = new ArrayList<Node>();
int nodesize;
void setup() {
  size(1000, 1000);
  background(0);
frameRate(15);
  
  for (int i = 0; i < 50; i++) {
    for (int j = 0; j < 50; j++) {
      nodes.add(new Node(i*spacing, j*spacing));
    }
  }
  
  //Shout out to mrsirrisrm from Reddit for helping out with java sort
  Collections.sort(nodes, new Comparator<Node>() {
    @Override
      public int compare(Node lhs, Node rhs) {
      double d1 = Math.hypot(lhs.x - width/2, lhs.y - height/2);
      double d2 = Math.hypot(rhs.x - width/2, rhs.y - height/2);
      return d1 < d2 ? -1 : (d1 == d2 ? 0 : 1);
    }
  }
  );
  
  nodesize = nodes.size();
}

void draw() {
  background(0);
  for (int j = 0; j < nodesize; j++) {
    Node p = nodes.get(j);
    float param = (1.0*j/nodesize);
    p.grow(millis()/500.0+param*25.0);
    color mix = lerpColor(color(213, 1, 68), color(23, 239, 201), abs(sin(0.1*millis()/50+50.0*j/nodes.size()*0.1)));
    fill(mix);
    noStroke();
    p.display();
  }
  
  //saveFrame("animation/output####.png");
}