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
    ArrayList<int[]> faces) {
    this.vertices = vertices;
    this.faces = faces;
  }

  void display() {
  }

  Mesh lerp(Mesh initial, Mesh target, float a) {
    ArrayList<PVector> morphVerts = lerpVerts(initial.vertices,target.vertices, a);
    color morphColor = lerpColor(initial.color, target.color, a);
    return new Mesh();
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

  void bounce() {
  }

  void projectPoint() {
  }

  void pullPoint() {
  }

  /*Class methods*/
  void loft() {
  }

  void extrudeCrv() {
  }

  void pipe() {
  }
}
