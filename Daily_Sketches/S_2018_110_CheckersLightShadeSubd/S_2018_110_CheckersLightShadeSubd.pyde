class Mesh(object):
    def __init__(self, obj):
        self.obj = obj
        self.vertices = []
        self.faces = []
        
        for i in range(obj.getChildCount()):
            for j in range(obj.getChild(i).getVertexCount()):
                v = obj.getChild(i).getVertex(j)
                self.vertices.append(v)
                
        
        for i in range(obj.getChildCount()):
            faceindex = []
            for j in range(obj.getChild(i).getVertexCount()):
                v = obj.getChild(i).getVertex(j)
                faceindex.append(self.vertices.index(v))
            self.faces.append(faceindex)
    def morph(self,initial,target,a):
        self.vertices = [PVector.lerp(i,j,map(cs(TWO_PI*a),-1,1,0,1)) for i,j in zip(initial.vertices,target.vertices)]
    def display(self, a,someScene):
        someScene.noStroke()
        someScene.beginShape(QUADS)
        for index,i in enumerate(self.faces):
            param = 1.0 * index/len(self.faces)
            for j in i:
                someScene.fill(lerpColor("#0EC0E1", "#DD3A7C",0.5*map(cs(TWO_PI*a), -1, 1, 0, 1)+0.5*map(cs(TWO_PI*a+1.5), -1, 1, 0, 1)))
                vec = self.vertices[j]
                someScene.vertex(vec.x,vec.y,vec.z)
        someScene.endShape() 
                        
class Meshes(object):
    def __init__(self,n):
        self.initials = []
        self.blends = []
        self.targets = []
        
        for i in range(n):
            self.initials.append(Mesh(loadShape("init{}.obj".format(i))))
            self.blends.append(Mesh(loadShape("init{}.obj".format(i))))
            self.targets.append(Mesh(loadShape("target{}.obj".format(i))))
    def morph(self,a):
        #self.blends = [ for index,i in enumerate(self.blends)]
        for index,i in enumerate(self.blends):
            i.morph(self.initials[index],self.targets[index],a)
    def display(self,a,someScene):
        for m in self.blends:
            m.display(a,someScene)
            
def ease(p,g):
    return [1-0.5*(2*(1-p))**g,0.5*(2*p)**g][p < 0.5]
def cs(q):
    return lerp(-1,1,ease(map(cos(q),-1,1,0,1),5))

def setup():
    global pizza,a,scl,scene,Quads
    size(500,500,P3D)
    rectMode(CORNER)
    imageMode(CORNER)
    smooth(8)
    ortho()
    a = 0.90
    scl = 16
    pizza = Meshes(28)
    scene = createGraphics(width,height,P3D)
    
    #Subdivision stuff
    Quads = []
    Quads.append(Quadrant(0,0,width,height))
    for i in range(5):
        Quads = [i.subdivide() for i in Quads]
        Quads = [j for i in Quads for j in i]
    
def draw():
    global a
    background(0)
    #drawScene(scene,a)
    for index,i in enumerate(Quads):
        param = 1.0*index/(len(Quads)-1)
        i.display(a+param)
    #image(scene,0,0,width/2,height/2)
    a += 0.0035
    if(a >= 1.0+0.90): exit()
    #saveFrame("output6/animation###.png")
def drawScene(someScene,a):
    someScene.beginDraw()
    someScene.ortho()
    someScene.smooth(8)
    someScene.background(0)
    someScene.lights()
    dirY = (50 / float(height) - 0.5) * 2;
    dirX = (105 / float(width) - 0.5) * 2;
    someScene.directionalLight(180, 180, 180, -dirX, -dirY, -1);
    someScene.translate(width/2,height/2,0);
    module(0, 0, a, scl,someScene);
    someScene.endDraw()
    
def module(x,y,a,scl,someScene):
    someScene.pushMatrix()
    pizza.morph(a)
    someScene.translate(x,y)
    someScene.rotateX(PI-PI/4);
    someScene.rotateZ(lerp(0, PI, map(cs(TWO_PI*a), -1, 1, 0, 1)));
    someScene.rotateY(lerp(PI/4, 0, 0.5*map(cs(TWO_PI*a), -1, 1, 0, 1)+0.5*map(cs(TWO_PI*a+1.5), -1, 1, 0, 1)))
    sclx = lerp(25,45,0.001*map(cs(TWO_PI*a), -1, 1, 0, 1)
                     +0.999*map(cs(TWO_PI*a+1.5), -1, 1, 0, 1));

    someScene.scale(sclx)
    pizza.display(a,someScene)
    someScene.popMatrix()

globalCount = 0
class Quadrant(object):
    def __init__(self,x,y,w,h):
        global globalCount 
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.bool = True if (globalCount==0) else (random(1.0)>0.4)
        globalCount += 1
    def subdivide(self):
        if(self.bool):
            cell1 = Quadrant(self.x,self.y,self.w/2.0,self.h/2.0)
            cell2 = Quadrant(self.x+self.w/2,self.y,self.w/2.0,self.h/2.0)
            cell3 = Quadrant(self.x,self.y+self.h/2,self.w/2.0,self.h/2.0)
            cell4 = Quadrant(self.x+self.w/2,self.y+self.h/2,self.w/2.0,self.h/2.0)
            return [cell1,cell2,cell3,cell4]
        return [self]
    def display(self,param):
        #noStroke()
        #noFill
        colors = [[random(255),random(255),random(255)] for i in range(4)]
        fill(*colors[0])
        stroke(230,26)
        strokeWeight(1)
        noFill()
        drawScene(scene,param)
        #rect(self.x,self.y,self.w,self.h)
        image(scene,self.x,self.y,self.w,self.h)
        # with beginShape(QUADS):
        #     fill(*colors[0])
        #     vertex(self.x,self.y)
        #     fill(*colors[1])
        #     vertex(self.x+self.w,self.y)
        #     fill(*colors[2])
        #     vertex(self.x+self.w,self.y+self.h)
        #     fill(*colors[3])
        #     vertex(self.x,self.y+self.h)
        #rect(self.x,self.y,self.w,self.h)
