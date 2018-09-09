from random import choice
def setup():
    global a,b,cancelled,shapes,Xn,Yn,ratio,probs
    size(400,400,P3D)
    background(0)
    smooth(8)
    noStroke()
    ortho(-width/2, width/2, 
          -height/2, height/2,
          -1000,10000)
    ellipseMode(CORNER)
    stroke(0,20)
    Yn = 2
    Xn = 2
    probs = [[random(1) for j in range(Xn)] for i in range(Yn)]
    cancelled = [[0 > 0.5 for j in range(Xn)] for i in range(Yn)]
    a = 0
    b = 0

    options = ["LSHAPE","CSHAPE"]
    shapes = [[choice(options) for j in range(Xn)] for i in range(Yn)]
def draw():
    global a,b,ratio
    background(0)
    ratio = [map(sin(TWO_PI*a),-1,1,0.01,1.0),
             map(sin(TWO_PI*a+0.124),-1,1,0.01,1.0)]
    # First grid direction
    Y = [ noise(0.03*sin(i+TWO_PI*a)) for i in range(1,Yn+1) ][::-1]
    Y = normalizeList(Y,height)
    Ypos = sumPrev(Y)

    # Second grid direction
    M = getMatrix(Xn,Yn,width,cancelled)
    Mpos = getPositions(M)
    translate(197+5, 124+11-14)
    print(mouseX,mouseY)
    scale(0.45)
    rotateZ(-PI/2)
    applyMatrix(  
        1.0, 0.0, 1.0,  0.0,
        0.0, 1.0, 0.0,  0.0,
        0.0, 0.0, 1.0,  0.0,
        0.0, 0.0, 0.0,  1.0);
    rotateZ(-PI/4+PI)
    indexY = 0
    for index,i in enumerate(zip(Y,Ypos)):
        Height = i[0]
        YPosition = i[1]
        indexX = 0
        for Width,XPosition in zip(M[index],Mpos[index]):
            # rect(XPosition,YPosition,
            #      Width,Height)
            q = [i for i in Quadrant(XPosition,YPosition,
                                     Width-0.1,Height-0.1,Width*0.64).subdivide()]
            q = [i.subdivide() for i in q]
            q = flatten(q)
            q = [i.display(shapes[indexX][indexY],probs[indexY][indexX]) for i in q]
            indexX += 1
            # boxc(XPosition,YPosition,
            #      Width-0.1,Height-0.1,max([0,Width*1.40]))
        indexY += 1
    #saveFrame("output9/animation###.png")
    if(a > 1.0): exit()
    a += 0.0035
flatten = lambda l: [item for sublist in l for item in sublist]
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

def boxc(X,Y,L,W,H,type="LSHAPE",probability=0):
    # O Shape
    if(type=="OSHAPE"):
        points = [PVector(0,0),
                PVector(L,0),
                PVector(L,W),
                PVector(0,W),
                PVector(0,0)]
    #CShape
    if(type=="CSHAPE"):
        points = [PVector(0,0),
                PVector(L,0),
                PVector(L,W/3.0),
                PVector(L/3.0,W/3.0),
                PVector(L/3.0,2.0*W/3.0),
                PVector(L,2.0*W/3.0),
                PVector(L,W),
                PVector(0,W),
                PVector(0,0)]

    #LShape
    if(type=="LSHAPE"):
        points = [PVector(0,0),
                PVector(L,0),
                PVector(L,W/3.0),
                PVector(L/3.0,W/3.0),
                PVector(L/3.0,W),
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
        # if(probability > 0.75):
        #     with beginShape():
        #         for i in points:
        #             fill(255)
        #             vertex(i.x,i.y,H)
def expression(time,i,j):
    amplitude = 5.0
    frequency = 5.1
    delay = 1.0*(i+j)/(X+Y-2)
    
    # transformation = sin(TWO_PI*time+delay*frequency)
    # transformation += cos(TWO_PI*time+frequency+delay)
    # transformation += sin(TWO_PI*time+frequency*2.1+delay)
    # transformation += sin(TWO_PI*time+frequency*1.72+delay)
    # transformation += cos(TWO_PI*time+frequency*2.221+delay)
    # transformation += sin(TWO_PI*time+frequency*3.1122+delay)
    # transformation *= amplitude
    #return map(transformation,-amplitude,amplitude,0,1.0)
    return noise(i*0.03+cos(TWO_PI*time+frequency+delay),j*0.03+sin(TWO_PI*time+delay*frequency))

def smoothstep(edge0, edge1, x):
    # Scale, bias and saturate x to 0..1 range
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    # Evaluate polynomial
    return x * x * (3 - 2 * x)

globalCount = 0
class Quadrant(object):
    def __init__(self,x,y,w,h,T):
        global globalCount 
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.T = T
        self.bool = True #if (globalCount==0) else (random(1.0)>0.5)
        globalCount += 1
    # def subdivide(self,nx=10,ny=5):
    #         if(self.bool):
    #             output = []
    #             #nx,ny = 3,3
    #             W = self.w/float(nx) 
    #             H = self.h/float(ny)
    #             for i in range(nx):
    #                 for j in range(ny):
    #                     output.append(Quadrant(self.x+i*W,self.y+j*H,W,H))
    #             return output
    #         return [self]
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
    def display(self,type,probability):
        boxc(self.x,self.y,
             self.w-0.1,self.h-0.1,max([0,self.T*9.40]),type,probability)
