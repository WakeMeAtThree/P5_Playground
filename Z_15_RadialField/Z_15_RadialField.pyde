from grow import *

pointslist = []
spacing  = 20
def setup():
    size(1000,1000);
    background(0);
    frameRate(30)
    global pointslist
    randx,randy = width/2,height/2#random(width/2),random(height/2)
    for i in range(50):
        for j in range(50):
            d = dist(i*spacing,j*spacing,randx,randy)
            pointslist.append((d,Node(i*spacing,j*spacing)))
    pointslist = list(enumerate(sorted(pointslist)))
    print(pointslist)
    
def draw():
    background(0)
    global pointslist
    beginShape()
    for j,i in pointslist:
        i[1].grow(millis()/50+50.0*j/len(pointslist))
        mix = lerpColor(color(213,1,68),color(23,239,201),abs(sin(0.1*millis()/50+50.0*j/len(pointslist)*0.1)))
        fill(mix);
        noStroke()
        i[1].display()
    endShape();