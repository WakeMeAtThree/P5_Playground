import java.util.*;

class Mesh {
  ArrayList<PVector> vertices = new ArrayList<PVector>();
  ArrayList<int[]> faces = new ArrayList<int[]>();
  color meshColor;


  /* Constructor that takes PShape directly */
  Mesh(PShape obj, color meshColor) {

    //Add all vertices to arraylist
    for (int i = 0; i < obj.getChildCount(); i++) {
      for (int j = 0; j < obj.getChild(i).getVertexCount(); j++) {
        PVector vec = obj.getChild(i).getVertex(j);
        this.vertices.add(vec);
      }
    }

    //Remove duplicates from vertices
    this.vertices = new ArrayList<PVector>(new LinkedHashSet(vertices));

    //Add all faces to arraylist
    for (int i = 0; i < obj.getChildCount(); i++) {
      int[] faceindex = new int[obj.getChild(i).getVertexCount()];
      for (int j = 0; j < obj.getChild(i).getVertexCount(); j++) {
        PVector vec = obj.getChild(i).getVertex(j);
        faceindex[j]=vertices.indexOf(vec);
      }
      faces.add(faceindex);
    }

    this.meshColor=meshColor;
  }

  /* Constructor that takes vertices+faces
   (Later on, normals,colors lists/winged-edge) 
   directly */

  Mesh(ArrayList<PVector> vertices, 
    ArrayList<int[]> faces, color meshColor) {
    this.vertices = vertices;
    this.faces = faces;
    this.meshColor = meshColor;
  }

  void display(float a) {
    /* CONSIDER MOVING THIS FUNCTION TO A 
    DIFFERENT CLASS */
    float delayFaces=0;
    float delayVerts=0;
    
    beginShape(QUADS);
    for (int i = 0; i < faces.size(); i++) {
      float param1 = delayFaces *i/faces.size();
      for (int j = 0; j < faces.get(i).length; j++) {
        float param2 = delayVerts * j/faces.get(i).length;
        fill(lerpColor(#0EC0E1, #DD3A7C, map(cs(a+param1+param2), -1, 1, 0, 1)));  

        int index = faces.get(i)[j];
        PVector vec = this.vertices.get(index);
        vertex(vec.x, vec.y, vec.z);
      }
    }
    endShape();
  }

  /* Wishlist */

  void subdivide() {
  }

  void extrudeFace() {
  }

  void smoothMesh() {
  }

  void moveVert() {
  }

  void moveEdges() {
  }

  void moveFaces() {
  }

  void jitter() {
  }

  void bounce(PVector loc, PVector dir) {
  }

  void projectPoint(PVector vec) {
  }

  void pullPoint(PVector vec) {
  }

  /*Class methods*/
  void loft(Curve crv1, Curve crv2) {
  }

  void extrudeCrv(Curve crv, PVector dir) {
  }

  void pipe() {
  }
}

Mesh mlerp(Mesh initial, Mesh target, float a) {
  ArrayList<PVector> morphVerts = lerpVerts(initial.vertices, target.vertices, a);
  color morphColor = lerpColor(initial.meshColor, target.meshColor, a);
  return new Mesh(morphVerts, initial.faces, morphColor);
}
