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
    scale(0.25)
    rotateX(PI/6)
    rotateZ(PI/4)
    X,Y = 15,15
    for i in range(X):
        for j in range(Y):
            delay = 1.0*(i+j)/(X+Y-2)
            parabolicBox(i*100,j*100,-50,50,expression(millis()/1000.0,i,j))#sin(millis()/1000.0+delay)*350*noise(13*i,13*j+millis()/1000.0))
            
    
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
                strokeWeight(3)
                stroke(0,0,0)
                noFill()
                parabola(0,0,X1,X2,H)
                strokeWeight(3)
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
def expression(time,i,j):
    amplitude = 5.0
    frequency = 0.1
    delay = 1.0*(i+j)/(X+Y-2)
    
    transformation = sin(TWO_PI*time+delay*frequency)
    transformation += cos(TWO_PI*time+frequency+delay)
    transformation += sin(TWO_PI*time+frequency*2.1+delay)
    transformation += sin(TWO_PI*time+frequency*1.72+delay)
    transformation += cos(TWO_PI*time+frequency*2.221+delay)
    transformation += sin(TWO_PI*time+frequency*3.1122+delay)
    transformation *= amplitude
    return map(transformation,-amplitude,amplitude,0,100)
