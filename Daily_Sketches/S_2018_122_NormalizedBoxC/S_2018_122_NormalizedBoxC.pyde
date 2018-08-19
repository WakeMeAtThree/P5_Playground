def setup():
    global a,b,cancelled,Xn,Yn
    size(400,400,P3D)
    background(0)
    smooth(8)
    noStroke()
    ortho(-width/2, width/2, 
          -height/2, height/2,
          -1000,10000)
    ellipseMode(CORNER)
    stroke(0,20)
    Yn = 5
    Xn = 5
    cancelled = [[random(1) > 0.7 for j in range(Xn)] for i in range(Yn)]
    a = 0
    b = 0

def draw():
    global a,b
    background(0)
    # First grid direction
    Y = [ map(sin(i+TWO_PI*a),-1,1,0,1.5) for i in range(1,Yn+1) ][::-1]
    Y = normalizeList(Y,height)
    Ypos = sumPrev(Y)

    # Second grid direction
    M = getMatrix(Xn,Yn,width,cancelled)
    Mpos = getPositions(M)
    translate(197, 124+42)
    scale(0.5)
    rotateX(PI/4)
    rotateZ(PI/4)
    for index,i in enumerate(zip(Y,Ypos)):
        Height = i[0]
        YPosition = i[1]
        for Width,XPosition in zip(M[index],Mpos[index]):
            # rect(XPosition,YPosition,
            #      Width,Height)
            boxc(XPosition,YPosition,
                 Width-0.1,Height-0.1,max([0,Width*1.40]))

    #saveFrame("output31/animation###.png")
    if(a > 1.0): exit()
    a += 0.008

# 1D Grid
def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]
def sumPrev(alist): return [0]+[sum(alist[:index+1]) for index,i in enumerate(alist)][:-1]

# 2D Grid
def getMatrix(X,Y,W=400,chance=None):
    if(chance is None):
        M = [[expression(a,i,j) for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
        
    else:
        M = [[0 if chance[i][j] else expression(a,i,j) for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
    return M

def getPositions(M):
    return [sumPrev(i) for i in M]

def boxc(X,Y,L,W,H):
    points = [PVector(0,0),
              PVector(L,0),
              PVector(L,W),
              PVector(0,W),
              PVector(0,0)]
    with pushMatrix():
        translate(X,Y)
        with beginShape(QUAD_STRIP):
            for i in points:
                fill(0)
                vertex(i.x,i.y,0)
                fill(255)
                vertex(i.x,i.y,H)

def expression(time,i,j):
    amplitude = 5.0
    frequency = 5.1
    delay = 1.0*(i+j)/(X+Y-2)
    
    transformation = sin(TWO_PI*time+delay*frequency)
    transformation += cos(TWO_PI*time+frequency+delay)
    transformation += sin(TWO_PI*time+frequency*2.1+delay)
    transformation += sin(TWO_PI*time+frequency*1.72+delay)
    transformation += cos(TWO_PI*time+frequency*2.221+delay)
    transformation += sin(TWO_PI*time+frequency*3.1122+delay)
    transformation *= amplitude
    return map(transformation,-amplitude,amplitude,0,1.5)

def smoothstep(edge0, edge1, x):
    # Scale, bias and saturate x to 0..1 range
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    # Evaluate polynomial
    return x * x * (3 - 2 * x)
