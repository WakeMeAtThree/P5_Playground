# Needed to create a mesh data structure so that
# I can move vertices without gaps.
# Useful Resource: http://www.enseignement.polytechnique.fr/informatique/INF562/Slides/MeshDataStructures.pdf

from Mesh import *
init = None
target = None
blendMesh = None
a = 0

def setup():
    global init,target,blendMesh
    size(400,400,P3D)
    background(0)
    smooth(8)
    
    ##import meshes
    init = Mesh(loadShape("init2.obj"));
    blendMesh = Mesh(loadShape("init2.obj"));
    target = Mesh(loadShape("target2.obj"));  
    
    ##Light settings

    lights();
    

    
    

    
def draw():
    global a
    background(0)
    
    #Morph
    blendMesh.vertices = [PVector.lerp(j[0],j[1],map(cs(0.5*a+1.0*i/len(init.vertices)),-1,1,0,1)) for i,j in enumerate(zip(init.vertices,target.vertices))]
    
    #Setting up coordinate system
    translate(width/2, height/2, 0);
    rotateZ(PI);
    scale(3.5);
    
    #Display
    fill(lerpColor(color(0x0CFFD2), color(0xD60043), map(cs(a), -1, 1, 0, 1)))
    blendMesh.display()
    
    #Animate 
    a += 0.05;

def ease(p): return 3*p*p - 2*p*p*p;
def ease(p, g): return [1 - 0.5 * pow(2*(1 - p), g),0.5 * pow(2*p, g)][p < 0.5]
def cs(q): return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 5))
