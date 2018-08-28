def setup():
    size(400,400)
    noFill()
    
def draw():
    background(255)
    pencilRect(width/2-50,height/2-50,100,100)
    noLoop()


def pencilRect(x,y,L,W):
        with pushMatrix():
            translate(x,y)
            for l in range(L):
                for w in range(W):
                    stroke(random(255),200)
                    for i in range(10):
                        ll = random(1)
                        strokes(l*ll,w*ll,random(1))


def strokes(x,y,a):
    with pushMatrix():
        translate(x+random(15),y+random(15))
        rotate(random(a,a+2))
        line(0,0,0,5)
