def setup():
    global a,X,Y,scl
    size(400,400)
    background(255)
    a = 0
    X = 30
    Y = 30
    scl = 2.0
def draw():
    global a
    background(255)
    for i in range(X):
        spaceX = 1.0*i/(X-1)
        for k in range(Y):
            spaceY = 1.0*k/(Y-1)
            
            #ellipse(spaceX*width,spaceY*height,15,15)
            drawLine(spaceX*width,spaceY*height,lerp(0,TWO_PI,noise(scl*spaceX+cos(a),scl*spaceY+sin(a))))
    a += 0.01
    
def drawLine(X,Y,a):
    with pushMatrix():
        translate(X,Y)
        rotate(a)
        strokeWeight(lerp(0,2,a))
        line(0,5,0,-5)
            