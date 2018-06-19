def setup():
    size(1000,1000)
    smooth(8)
    background(255)
    blendMode(DIFFERENCE)
    fill(255)
    noLoop()
    noStroke()
    
def draw():
    #background(255)
    #Move origin to middle of canvas
    translate(width/2,height/2)
    convexPolygon(500,45)

def superElliptic(r,n):
    angles = sorted([random(TWO_PI) for i in range(n+1)])
    options = [random(r),random(r)]
    
    beginShape()
    for index,i in enumerate(angles):
        r = options[index%2==0]
        curveVertex(r*cos(i),r*sin(i))
    endShape(CLOSE)

def keyPressed():
    redraw()
