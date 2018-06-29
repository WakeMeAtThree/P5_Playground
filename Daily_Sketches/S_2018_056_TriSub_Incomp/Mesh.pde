import java.util.*;

class Mesh {
  PShape curve;
  ArrayList<PVector> vertices;
  color meshColor;
  Mesh(PShape curve, color meshColor) {
    this.curve = curve;
    this.vertices = new ArrayList<PVector>();

    //Add all vertices to arraylist
    for (int i = 0; i < curve.getChild(0).getVertexCount(); i++) {
      this.vertices.add(curve.getChild(0).getVertex(i).copy());
    }
    this.meshColor = meshColor;
  }

  void morph(float a, Mesh... meshes) {
    //Morphs between initial and target mesh
    for (int i = 0; i < this.vertices.size(); i++) {
      float param = 0.0 * i/this.vertices.size();
      //float param = 1.00*(pow(i,2)+pow(i%4,2))/(sqrt(2)*this.vertices.size());
      PVector vec = lerpVectors(map(cs(a+param), -1, 1, 0, 1),meshes[0].vertices.get(i), 
        meshes[1].vertices.get(i));
      this.vertices.set(i, vec);
    }
  }
  
  PVector lerpVectors(float amt, PVector... vecs) {
    if (vecs.length==1) { 
      return vecs[0];
    }
    float cunit = 1.0/(vecs.length-1);
    return PVector.lerp(vecs[floor(amt / cunit)], vecs[ceil(amt / cunit)], amt%cunit/cunit);
  }
  
  void display(float scl) {

    pushMatrix();
    //stroke(255);
    //strokeWeight(0.02);
    noStroke();
    scale(scl);
    fill(meshColor);
    beginShape();
    int count = 0;
    for (PVector p : this.vertices) {
    float param = 0.0*count/this.vertices.size();
    color option = lerpColor(#FF0000,#FF00FF,map(sin(a+param), -1, 1, 0, 1));
    count++;
    //fill(option,180);
    
      vertex(p.x, p.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
}
