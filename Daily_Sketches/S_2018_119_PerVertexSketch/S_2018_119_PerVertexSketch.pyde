def setup():
    global a
    size(400,400,P3D)
    smooth(8)
    ortho()
    a = 0
def draw():
    global a
    background(0)
    ortho(-width/2, width/2, 
          -height/2, height/2)
    X = 15
    Y = 15
    sz = 50
    sx = 80
    sy = 80
    rotateX(PI/4)

    rotateZ(PI/4)
    stroke(0,20)
    for i in range(X):
        parami = 5.0*i/(X-1)
        for j in range(-Y,Y):
            paramj = 5.0 * j/(Y-1)
            with pushMatrix():
                translate(i*sx,j*sy,0)
                boxc(sz,sz,100,sn(TWO_PI*a+parami+paramj))
    a += 0.0025
    if(a > 1.0): exit()
    #saveFrame("output/animation###.png")
def boxc(L,W,H,T):
    points = [PVector(0,0),
              PVector(L,0),
              PVector(L,W),
              PVector(0,W),
              PVector(0,0)]
    #noStroke()
    #
    #
    with beginShape(QUAD_STRIP):
        for i in points:
            fill(lerp(255,0,T))
            vertex(i.x,i.y,0)
            fill(lerp(0,255,T))
            vertex(i.x,i.y,lerp(-H,H,T))

def smoothstep(edge0, edge1, x):
    # Scale, bias and saturate x to 0..1 range
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    # Evaluate polynomial
    return x * x * (3 - 2 * x)

def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]
def sn(q): return smoothstep(0.0,0.8,sin(q))#lerp(-1, 1, ease(map(sin(q), -1, 1, 0, 1), 5))
