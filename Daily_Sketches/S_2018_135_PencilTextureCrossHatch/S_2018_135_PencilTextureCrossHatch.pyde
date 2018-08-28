def setup():
    size(400,400)
    noFill()
    stroke(0)
    
def draw():
    background(255)
    pencilRect(width/2-50,height/2-50,25,25)
    noLoop()


def pencilRect(x,y,L,W):
        with pushMatrix():
            translate(x,y)
            for l in range(L):
                #gradient
                stroke(0,120.0*(1.0*l/(L-1))**2)
                for w in range(W):
                    
                    for i in range(5):
                        ll = 8
                        strokeWeight(random(0.8,1.2))
                        strokes(l*ll,w*ll,1)


def strokes(x,y,a):
    with pushMatrix():
        translate(x+random(4),y+random(4))
        rotate(random(a,a+3))
        for i in range(4):
            line(i*3,0,
                 i*3,15)
