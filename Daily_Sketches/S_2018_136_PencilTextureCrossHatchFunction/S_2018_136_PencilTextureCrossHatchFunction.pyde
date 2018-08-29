def setup():
    size(400,400)
    noFill()
    stroke(0)
    
def draw():
    background(255)
    func(mouseX,mouseY)
    #noLoop()

def func(xi=140,yi=140,
         X=400/2,Y=400/2,
         res=50,
         Hatch_dist=5,
         Stroke_length=15):
    for y in range(res):
        ydelay = 1.0*y/(res-1)

        for x in range(res):
            xdelay = 1.0*x/(res-1)
            #Gradient options
            stroke(0,80.0*ydelay)
            #stroke(0,120.0*smoothstep(0.7,0.8,map(sin(ydelay*25.0+25.0*xdelay),-1,1,0,1)))
            #stroke(0,50.0*(xdelay+ydelay))
            with pushMatrix():
                translate(xdelay*X+random(4)+xi,ydelay*Y+random(4)+yi)
                a = 1
                rotate(random(a,a+3))
                for i in range(4):
                    rotate(random(0.2))
                    line(i*Hatch_dist,0,
                         i*Hatch_dist,Stroke_length)
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
            rotate(random(0.2))
            line(i*3,0,
                 i*3,15)
def smoothstep(edge0, edge1, x):
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    return x * x * (3 - 2 * x)
