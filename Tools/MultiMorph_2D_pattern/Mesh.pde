import java.util.*;

class Mesh {
  PShape curve;
  ArrayList<PVector> vertices;

  Mesh(PShape curve) {
    this.curve = curve;
    this.vertices = new ArrayList<PVector>();

    //Add all vertices to arraylist
    for (int i = 0; i < curve.getChild(0).getVertexCount(); i++) {
      this.vertices.add(curve.getChild(0).getVertex(i).copy());
    }

  }

  void morph(Mesh initial, Mesh target, float a) {
    //Morphs between initial and target mesh
    for (int i = 0; i < this.vertices.size(); i++) {
      float param = 0.0 * i/this.vertices.size();
      PVector vec = PVector.lerp(initial.vertices.get(i), 
                          target.vertices.get(i), 
                          map(cs(a+param), -1, 1, 0, 1));
      this.vertices.set(i, vec);
    }
    
  }
  void display(float scl) {
stroke(0);
strokeWeight(map(cs(a), -1, 1, 1, 0));
noStroke();
    fill(255);
    pushMatrix();

    scale(scl);

    beginShape();
    for (PVector p : this.vertices) {
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}
