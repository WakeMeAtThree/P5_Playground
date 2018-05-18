def ease(p): return 3*p*p - 2*p*p*p;
def ease(p, g): return [1 - 0.5 * pow(2*(1 - p), g),0.5 * pow(2*p, g)][p < 0.5]
def cs(q): return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 5))

class Mesh():
    def __init__(self, objShape):
        self.vertices = []
        self.faces = {}
        
        for i in range(0,objShape.getChildCount()):
        # i is iterating through all faces
            for j in range(0,objShape.getChild(i).getVertexCount()):
                # j is looping through all 4 vertices
                self.vertices.append(objShape.getChild(i).getVertex(j))
        
        for i in range(0,objShape.getChildCount()):
            # i is iterating through all faces
            self.faces[i] = []
            for j in range(0,objShape.getChild(i).getVertexCount()):
                # j is looping through all 4 vertices
                self.faces[i].append(self.vertices.index(objShape.getChild(i).getVertex(j)))
                
    def display(self):
        fill(255, 0, 127, 255)
        stroke(0)
        strokeWeight(0.1)
        
        beginShape(QUADS)

        
        for key, value in self.faces.items():
            for i in value:
                vec = self.vertices[i]
                vertex(vec.x,vec.y,vec.z)
        endShape(QUADS)
