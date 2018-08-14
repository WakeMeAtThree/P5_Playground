def setup():
    global scene,a,c,objects,toon,maxAmount,toggle,X,Y,Z,boxSize
    size(400,400,P3D)
    smooth(8)
    scene = createGraphics(400,400,P3D)
    frameRate(7)
    ortho()
    toon = loadShader("ToonFrag.glsl", "ToonVert.glsl")
    X = 3
    Y = 3
    Z = 3
    toggle = True
    maxAmount = 2**(X*Y*Z) 
    a = floor(random(maxAmount))
    boxSize = 45
    objects = []
    translate(width/2,height/2)
    rotateX(PI/4)
    rotateZ(PI/4)

    for i in range(X):
        for j in range(Y):
            for k in range(Z):
                objects.append(Boxes(i*boxSize,j*boxSize,k*boxSize,boxSize))
    textMode(CENTER)
    textAlign(CENTER,CENTER)
    textSize(12)
    # c = [comb for i in range(len(objects)) for comb in combinations(objects, i + 1)]

def draw():
    global a
    background(255)
    drawScene(scene,a)
    image(scene,0,0,width,height)
    print(mouseY)
    fill(0)
    text(format(a, '#0{}b'.format(X*Y*Z+2)),width/2,height-10-47)
    text('{}/{}'.format(a,2**(X*Y*Z)),width/2,height-25-47)
    a += 1
    if(a > maxAmount): exit()
    #saveFrame("3x3x2/animation###.png")

def keyPressed():
    if(key==' '): noLoop()
    if(key=='a'): loop()
    
def getIndices(a):
    return [k for k,i in enumerate(list(format(a, '#0{}b'.format(X*Y+2)))[2:]) if i == '1']
def drawScene(scene,a):
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
        objects[k].display(scene)
    scene.endDraw()
    
class Boxes(object):
    def __init__(self,X,Y,Z,Size):
        self.X = X
        self.Y = Y
        self.Z = Z
        self.Size = Size
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
        scene.stroke(0,20)
        scene.box(self.Size)
        
        scene.popStyle()
        scene.popMatrix()
