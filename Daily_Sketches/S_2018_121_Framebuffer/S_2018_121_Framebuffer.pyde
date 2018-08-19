def setup():
    global a, imageShader, buf
    size(400, 400, P2D);
    ortho()
    #img = loadImage("apple.jpg");
    a = 0
    #imageShader = loadShader("imageShader.glsl");
    #imageShader.set("imageSampler", img);
    buf = createGraphics(400,400,P3D)
    someShader = loadShader("shader.glsl")
    drawScene(buf)
    noStroke()

def draw():
    global a
    background(0)
    someShader = loadShader("shader.glsl")
    someShader.set("image",buf.get())

    shader(someShader)
    drawMesh(25,25,a)
    noLoop()
    a += 0.1

def drawStrip(x, y, a):
    stripList = []
    for i in range(x+1):
        parami = 15.0*i/x
        strip = []
        for j in range(y+1):
            paramj = 15.0*j/y
            
            #Moving vectors
            strip.append(PVector(width/y * i + 15*cos(a+parami+paramj)+sin(a+parami+paramj+0.2482),
                                 height/(y-1) * j + 15 * sin(a+parami+paramj)+cos(a+parami+paramj+0.23813),
                                 0))
        stripList.append(strip)
    return stripList
    

def drawMesh(x, y, a):
    strips = drawStrip(x, y, a)
    for i in range(len(strips)-2):
        v1 = 1.0*i/(len(strips)-2);
        v2 = 1.0*(i+1)/(len(strips)-2);
    
        list1=strips[i];    
        list2=strips[i+1];
    
        with beginShape(QUAD_STRIP):
            for index,i in enumerate(zip(list1,list2)):
                u = 1.0 * index/(len(list1)-1)
                vertex(i[0].x,i[0].y,u,v1)
                vertex(i[1].x,i[1].y,u,v2)
def drawScene(scene):
    scene.beginDraw()
    points = [PVector(random(width),random(height)) for _ in range(100)]
    scene.background(255)
    #v1 = PVector(random(width),random(height))
    #v1 = PVector(random(width),random(height))
    #scene.line(0,0,width,height)
    #scene.line(0,0,v1.x,v1.y)
    scene.beginShape()
    for i in points:
        scene.vertex(i.x,i.y)
    scene.endShape()
    scene.endDraw()
