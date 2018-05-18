def setup():
    size(400,400)
    background(255)
    fill(0)
    noLoop()
    noStroke();
    
def draw():
    background(255)
    
    #Move origin to middle of canvas
    translate(width/2,height/2)
    convexPolygon(100,6)

def convexPolygon(r,n):
    """Function written as described by @Hamoid in the Processing discourse forums
    where r is radius of polar coordinate and n is number of vertices"""
    
    angles = sorted([random(TWO_PI) for i in range(n+1)])
    beginShape()
    for i in angles:
        vertex(r*cos(i),r*sin(i))
    endShape(CLOSE)

def keyPressed():
    redraw()