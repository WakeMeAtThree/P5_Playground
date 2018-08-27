def setup():
    global a,b,cancelled,Xn,Yn,ratio
    size(400,400,P3D)
    background(0)
    smooth(8)
    noStroke()
    ortho(-width/2, width/2, 
          -height/2, height/2,
          -1000,10000)
    ellipseMode(CORNER)
    stroke(0,20)
    Yn = 15
    Xn = 100
    cancelled = [[random(1) > 0.15 for j in range(Xn)] for i in range(Yn)]
    a = 0
    b = 0
    ratio = [0.2,
             0.2]
def draw():
    global a,b
    background(0)
    Y,Ypos,M,Mpos = getGrid(a)
    vals1 = []
    Y2,Ypos2,M2,Mpos2 = getGrid(2.0*a)
    vals2 = []
    translate(197, 124+42)
    scale(0.5)
    rotateX(PI/4)
    rotateZ(PI/4)
    for index,i in enumerate(zip(Y,Ypos)):
        Height = i[0]
        YPosition = i[1]
        for Width,XPosition in zip(M[index],Mpos[index]):
            vals1.append([XPosition,YPosition,Width-0.1,Height-0.1,max([0,Width*5.40])])
    
    for index,i in enumerate(zip(Y2,Ypos2)):
        Height = i[0]
        YPosition = i[1]
        for Width,XPosition in zip(M2[index],Mpos2[index]):
            vals2.append([XPosition,YPosition,Width-0.1,Height-0.1,max([0,Width*1.40])])
    for i,j in zip(vals1,vals2):
        boxc(*(i+j)[:-1])
    #saveFrame("output15/animation###.png")
    #if(a > 1.0): exit()
    a += 0.008
def getSquare():
    points = [PVector(0,0),
              PVector(L,0),
              PVector(L,W),
              PVector(0,W),
              PVector(0,0)]
def getGrid(a):
    # First grid direction
    Y = [ map(sin(i+TWO_PI*a),-1,1,0,1.5) for i in range(1,Yn+1) ][::-1]
    Y = normalizeList(Y,height)
    Ypos = sumPrev(Y)

    # Second grid direction
    M = getMatrix(a,Xn,Yn,width,cancelled)
    Mpos = getPositions(M)
    return Y,Ypos,M,Mpos
flatten = lambda l: [item for sublist in l for item in sublist]
# 1D Grid
def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]
def sumPrev(alist): return [0]+[sum(alist[:index+1]) for index,i in enumerate(alist)][:-1]

# 2D Grid
def getMatrix(a,X,Y,W=400,chance=None):
    if(chance is None):
        M = [[expression(a,i,j) for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
        
    else:
        M = [[0 if chance[i][j] else expression(a,i,j) for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
    return M

def getPositions(M):
    return [sumPrev(i) for i in M]

def boxc(X1,Y1,L1,W1,H,
         X2,Y2,L2,W2):
    points1 = [PVector(0,0,0),
               PVector(L1,0,0),
               PVector(L1,W1,0),
               PVector(0,W1,0),
               PVector(0,0,0)]
    points2 = [PVector(0,0,H),
               PVector(L2,0,H),
               PVector(L2,W2,H),
               PVector(0,W2,H),
               PVector(0,0,H)]
    with pushMatrix():
        #translate(X,Y)
        with beginShape(QUAD_STRIP):
            for i,j in zip(points1,points2):
                fill(0)
                vertex(i.x+X1,i.y+Y1,0)
                fill(255)
                vertex(j.x+X2,j.y+Y2,H)

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
    return map(transformation,-amplitude,amplitude,0,1.0)

def smoothstep(edge0, edge1, x):
    # Scale, bias and saturate x to 0..1 range
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    # Evaluate polynomial
    return x * x * (3 - 2 * x)

globalCount = 0
class Quadrant(object):
    def __init__(self,x,y,w,h,
                      x2,y2,w2,h2,T):
        global globalCount 
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.T = T
        self.bool = True #if (globalCount==0) else (random(1.0)>0.5)
        globalCount += 1
    def subdivide(self):
        subdPoint = PVector(self.x+self.w*ratio[0],self.y+self.h*ratio[1])
        points = [PVector(self.x,self.y),
                  PVector(self.x+self.w,self.y),
                  PVector(self.x,self.y+self.h),
                  PVector(self.x+self.w,self.y+self.h)]
        distances = [PVector.dist(subdPoint,i) for i in points][::-1]
        distances = normalizeList(distances,1)
        #dists = [map(i,min(distances),max(distances),0,1.0) for i in distances]
        if(self.bool):
            cell1 = Quadrant(self.x,self.y,
                             self.w*ratio[0],self.h*ratio[1], self.T*distances[0])
            cell2 = Quadrant(self.x+self.w*ratio[0],self.y,
                             self.w*(1-ratio[0]),self.h*ratio[1], self.T*distances[1])
            cell3 = Quadrant(self.x,self.y+self.h*ratio[1],
                             self.w*ratio[0],self.h*(1-ratio[1]), self.T*distances[2])
            cell4 = Quadrant(self.x+self.w*ratio[0],self.y+self.h*ratio[1],
                             self.w*(1-ratio[0]),self.h*(1-ratio[1]), self.T*distances[3])
            return [cell1,cell2,cell3,cell4]
        return [self]
    def display(self):
        boxc(self.x,self.y,
             self.w-0.1,self.h-0.1,max([0,self.T*9.40]))
