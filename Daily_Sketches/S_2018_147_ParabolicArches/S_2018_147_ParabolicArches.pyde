def setup():
    size(400,400,P3D)
    smooth(8)
    rectMode(CORNERS)
    ortho()
    noFill()
    stroke(0)

def draw():
    background(255)
    translate(width/2,height/2)
    rotateX(PI/3)
    rotateZ(PI/4)
    parabolicBox(0,0,-100,100,100)
def parabolicBox(X,Y,X1,X2,H):
    # X1 = -100
    # X2 = 100
    # H = 100
    with pushMatrix():
        translate(X,Y)
        ellipse(0,0,10,10)
        rect(X1,X1,X2,X2)
        for i in range(4):
            with pushMatrix():
                rotate(PI/2*i)
                translate(0,X2)
                rotateX(PI/2)
                parabola(X1,X2,H)
def parabola(a,b,scl):
    with beginShape():
        for i in range(a,b):
            vertex(i,f(i,a,b,scl))
def f(x,a,b,scl): return scl*(x-a)*(x-b)/(a*b)
