def setup():
    size(400,400,P3D)
    smooth(8)
    rectMode(CORNER)
    ortho()
    noFill()
    stroke(0)


def draw():
    background(255)
    translate(width/2,height/2-103)
    print(mouseX,mouseY)
    scale(0.5)
    rotateX(PI/6)
    rotateZ(PI/4)
    for i in range(5):
        for j in range(5):
            delay = 15.0*(i+j)/(5+5-2)
            parabolicBox(i*100,j*100,-50,50,sin(millis()/1000.0+delay)*350*noise(13*i,13*j+millis()/1000.0))
            
    
def myBox(X,Y,L,W,H):
    rectMode(CORNER)
    with pushMatrix():
        translate(X,Y)
        #Center Point
        ellipse(W/2.0,H/2.0,15,15)
        
        #Perimeter
        rect(0,0,L,W)
        


def parabolicBox(X,Y,X1,X2,H):
    # X1 = -100
    # X2 = 100
    # H = 100
    with pushMatrix():
        translate(X,Y)
        rectMode(CORNERS)
        strokeWeight(1)
        ellipse(0,0,10,10)
        #fill(255,50)
        stroke(0,0,0)
        rect(X1,X1,X2,X2)
        for i in range(4):
            with pushMatrix():
                rotate(PI/2*i)
                translate(0,X2)
                rotateX(PI/2)
                strokeWeight(14)
                stroke(0,0,0)
                noFill()
                parabola(0,0,X1,X2,H)
                strokeWeight(7)
                stroke(255)
                noFill()
                #parabola(0+0.05,0+0.05,X1,X2,H+0.05)
def parabola(X,Y,a,b,scl):
    with pushMatrix():
        translate(X,Y)
        with beginShape():
            for i in range(floor(a),ceil(b)):
                vertex(i,f(i,a,b,scl))
def f(x,a,b,scl): return scl*(x-a)*(x-b)/(a*b)
