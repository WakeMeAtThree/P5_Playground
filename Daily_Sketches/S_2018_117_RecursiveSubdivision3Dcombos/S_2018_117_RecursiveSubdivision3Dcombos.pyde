def setup():
    global speed,scl,scene,a,c,objects,toon,maxAmount,toggle,X,Y,Z,boxSize
    # Basic setup
    size(400,400,P3D)
    smooth(8)
    frameRate(6)
    ortho()
    textMode(CENTER)
    textAlign(LEFT,CENTER)
    textSize(8)
    scl = 1
    # Initializing
    scene = createGraphics(400,400,P3D)
    toon = loadShader("ToonFrag.glsl", "ToonVert.glsl")
    speed = 1
    # Grid size
    X = 2
    Y = 2
    Z = 2
    
    # Necessary values
    maxAmount = 2**(X*Y*Z) 
    a = 0
    boxSize = 45
    objects = []
    
    # Instantiate objects
    for i in range(X):
        for j in range(Y):
            for k in range(Z):
                objects.append(Boxes(i*boxSize,j*boxSize,k*boxSize,boxSize))


def draw():
    global a
    background(255)
    
    # Run and display the scene

    drawScene(scene)
    image(scene,0,0,width,height)

    # Display text and combination code
    fill(0)
    text(format(a, '#0{}b'.format(X*Y*Z+2)),20,height-16-47+38)
    text('{}/{}'.format(a,2**(X*Y*Z)),20,height-25-47+38)
    
    #Animate
    a += speed

    #saveFrame("2x2x2_text/animation###.png")

def keyPressed():
    global objects,maxAmount,a,scl,speed
    objects = [objects[i] for i in getIndices(a%maxAmount)]
    newObjects = [i.mitosis() for i in objects]
    objects = [j for i in newObjects for j in i]
    #print(newObjects)
    maxAmount = len(objects)
    a = int("".join(["1" if random(1) > 0.5 else "0" for i in range(len(objects))]))
    speed = 0
def getIndices(a):
    return [k for k,i in enumerate(list(format(a, '#0{}b'.format(len(objects))))[2:]) if i == '1']

def drawScene(scene):
    scene.beginDraw()
    scene.clear()
    scene.ortho()
    scene.shader(toon)
    scene.translate(width/2,height/2)
    scene.rotateX(PI/4)
    scene.rotateZ(PI/4)
    scene.directionalLight(51, 102, 126, 
                     0, -2, -1);

    for i in objects:
        i.displayWireFrame(scene)
    for k in getIndices(a):
        objects[k%len(objects)].display(scene)

    scene.endDraw()
    
class Boxes(object):
    def __init__(self,X,Y,Z,Size):
        self.X = X
        self.Y = Y
        self.Z = Z
        self.Size = Size
    def mitosis(self):
        #self.Size *= 2
        deprecating = self.Size/1.1
        spacing = self.Size/1.1
        b1 = Boxes(self.X+deprecating,
                   self.Y+deprecating,
                   self.Z+deprecating,
                   deprecating)
        b2 = Boxes(self.X-deprecating,
                   self.Y+deprecating,
                   self.Z+deprecating,
                   deprecating)
        b3 = Boxes(self.X+deprecating,
                   self.Y-deprecating,
                   self.Z+deprecating,
                   deprecating)
        b4 = Boxes(self.Y-deprecating,
                   self.Y-deprecating,
                   self.Z-deprecating,
                   deprecating)
        b5 = Boxes(self.Y+deprecating,
                   self.Y+deprecating,
                   self.Z-deprecating,
                   deprecating)
        b6 = Boxes(self.Y-deprecating,
                   self.Y+deprecating,
                   self.Z+deprecating,
                   deprecating)
        b7 = Boxes(self.X+deprecating,
                   self.Y-deprecating,
                   self.Z-deprecating,
                   deprecating)
        b8 = Boxes(self.X-deprecating,
                   self.Y-deprecating,
                   self.Z-deprecating,
                   deprecating)
        return [b1,b2,b3,b4,b5,b6,b7,b8]
    def display(self,scene):
        scene.pushMatrix()
        scene.pushStyle()
        
        scene.translate(self.X,self.Y,self.Z)
        scene.fill(255)
        scene.stroke(0)
        scene.box(self.Size)
        
        scene.popStyle()
        scene.popMatrix()
    def displayWireFrame(self,scene):
        scene.pushMatrix()
        scene.pushStyle()
        
        scene.translate(self.X,self.Y,self.Z)
        scene.noFill()
        scene.stroke(0,10)
        scene.box(self.Size)
        
        scene.popStyle()
        scene.popMatrix()
