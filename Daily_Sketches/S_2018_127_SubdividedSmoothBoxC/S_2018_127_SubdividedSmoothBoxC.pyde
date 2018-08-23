def setup():
    global a,b,cancelled,Xn,Yn,ratio,colorOptions,hole
    size(400,400,P3D)
    background(0)
    smooth(8)
    noStroke()
    colorOptions = [color(lerpColor("#000000","#0EC0E1",0.35)),
                    lerpColor("#000000","#0EC0E1",1.0),
                    lerpColor("#FFFFFF","#0EC0E1",0.0)]
    ortho(-width/2, width/2, 
          -height/2, height/2,
          -1000,10000)
    ellipseMode(CORNER)
    #stroke(0,20)
    noStroke()
    Yn = 3
    Xn = 3
    cancelled = [[random(1) for j in range(Xn)] for i in range(Yn)]
    a = 0
    b = 0
    ratio = [0.2,
             0.2]
    hole = random(1)
def draw():
    global a,b
    background(0)
    # First grid direction
    Y = [ map(sin(i+TWO_PI*a),-1,1,0,1.5) for i in range(1,Yn+1) ][::-1]
    Y = normalizeList(Y,height*2.5)
    Ypos = sumPrev(Y)

    # Second grid direction
    M = getMatrix(Xn,Yn,width*3.5,cancelled)
    Mpos = getPositions(M)
    translate(197-0-48, 124+42-39)
    #print(mouseY)
    scale(0.33)
    rotateX(PI/6)
    rotateZ(PI/4)
    for index,i in enumerate(zip(Y,Ypos)):
        Height = i[0]
        YPosition = i[1]
        for index2,j in  enumerate(zip(M[index],Mpos[index])):
            # rect(XPosition,YPosition,
            #      Width,Height)
            Width,XPosition=j[0],j[1]
            chance = cancelled[index][index2]

            q = [i for i in Quadrant(XPosition,YPosition,
                                     Width,Height,Width,chance).subdivide()]
            q = [i.subdivide() for i in q]
            q = flatten(q)
            q = [i.display() for i in q]
            
            # boxc(XPosition,YPosition,
            #      Width-0.1,Height-0.1,max([0,Width*1.40]))

    #saveFrame("output3/animation###.png")
    if(a > 1.0): exit()
    a += 0.004
flatten = lambda l: [item for sublist in l for item in sublist]
# 1D Grid
def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]
def sumPrev(alist): return [0]+[sum(alist[:index+1]) for index,i in enumerate(alist)][:-1]

# 2D Grid
def getMatrix(X,Y,W,chance=None):
    if(chance is None):
        M = [[expression(a,i,j) for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
        
    else:
        M = [[0 if chance[i][j] > 1.0 else expression(a,i,j) for j in range(X)] for i in range(Y)]
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

    return map(transformation,-1,1,0,1.0)

def smoothstep(edge0, edge1, x):
    # Scale, bias and saturate x to 0..1 range
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    # Evaluate polynomial
    return x * x * (3 - 2 * x)

globalCount = 0
class Quadrant(object):
    def __init__(self,x,y,w,h,T, CHANCE):
        global globalCount 
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.T = T
        self.CHANCE = CHANCE
        self.bool = self.CHANCE > 0.05 #if (globalCount==0) else (random(1.0)>0.5)
        globalCount += 1
    def subdivide(self):
        subdPoint = PVector(self.x+self.w*ratio[0],self.y+self.h*ratio[1])
        points = [PVector(self.x,self.y),
                  PVector(self.x+self.w,self.y),
                  PVector(self.x,self.y+self.h),
                  PVector(self.x+self.w,self.y+self.h)]
        distances = [PVector.dist(subdPoint,i) for i in points][::-1]
        distances = normalizeList(distances,1)
        distances = [i**0.6 for i in distances]
        decay = 0.01
        #dists = [map(i,min(distances),max(distances),0,1.0) for i in distances]
        if(self.bool):
            cell1 = Quadrant(self.x,self.y,
                             self.w*ratio[0],self.h*ratio[1], self.T*distances[0],
                             self.CHANCE*decay)
            cell2 = Quadrant(self.x+self.w*ratio[0],self.y,
                             self.w*(1-ratio[0]),self.h*ratio[1], self.T*distances[1],
                             self.CHANCE*decay)
            cell3 = Quadrant(self.x,self.y+self.h*ratio[1],
                             self.w*ratio[0],self.h*(1-ratio[1]), self.T*distances[2],
                             self.CHANCE*decay)
            cell4 = Quadrant(self.x+self.w*ratio[0],self.y+self.h*ratio[1],
                             self.w*(1-ratio[0]),self.h*(1-ratio[1]), self.T*distances[3],
                             self.CHANCE*decay)
            return [cell1,cell2,cell3,cell4]
        return [self]
    def display(self):
        squishedbox(self.x,self.y,
             self.w,self.h,max([0,self.T*5.40]),self.CHANCE)
def lerpColors(colorOptions,amt):
    """Lerp function that takes an amount between 0 and 1, 
    and a list of colors and returns the appropriate
    interpolation"""
    
    if (len(colorOptions)==1): return colorOptions[0]
    spacing = 1.0/(len(colorOptions)-1)
    lhs = floor(amt/spacing)
    rhs = ceil(amt/spacing)
    
    try:
        return lerpColor(colorOptions[lhs], 
                         colorOptions[rhs], 
                         amt%spacing/spacing)
    except:
        return lerpColor(colorOptions[constrain(lhs, 0, len(colorOptions)-2)], 
                         colorOptions[constrain(rhs, 1, len(colorOptions)-1)], 
                         amt);
####
def mousePressed(): print(mouseX)
def squishedbox(X,Y,L,W,H,hole):
    points = [PVector(0,0),
              PVector(L,0),
              PVector(L,W),
              PVector(0,W),
              PVector(0,0)]
    center = PVector(L/2.0,W/2.0,H)
    res = 25
    val = 0.8
    strips = [movePointsToCenter(points,
                                 center,
                                 val*i/(res-1)) for i in range(res)]
    outlines = zip(*strips)+[strips[-1]]

    with pushMatrix():
        translate(X,Y)
        #
        drawMesh(strips)
        
        #Outlines
        with pushStyle():
            noFill()
            stroke(0,0,0,20)
            strokeWeight(3)
            for crv in outlines:
                with beginShape():
                    for p in crv:
                        vertex(p.x,p.y,p.z)
        
        #Dashed lines maybe?
        with pushStyle():
            stroke(color(255),150)
            strokeWeight(10)
            point(center.x,center.y,center.z)
            strokeWeight(4)
            stroke(color(255),110)
            dashedLine(center,PVector(center.x,center.y,0))
            for i in points:
                pass
                #dashedLine(i,center)
                #line(i.x,i.y,i.z,
                #    center.x,center.y,center.z) 

def movePointsToCenter(points,center,amt):
    return [customLerp(i,center,amt) for i in points]
def customLerp(v1,v2,amt):
    x = lerp(v1.x,v2.x,amt)
    y = lerp(v1.y,v2.y,amt)
    z = cosineLerp(v1.z,v2.z,smoothstep(0.2,1.1,amt**2))
    return PVector(x,y,z)
def cosineLerp(y1,y2,mu):
    mu2 = (1-cos(mu*PI))/2
    return y1*(1-mu2)+y2*mu2
def drawMesh(lines):
    strokeWeight(1)
    for i in range(len(lines)-1):
        wave = 1.0*i/(len(lines)-2)
        with beginShape(QUAD_STRIP):
            for index,j in enumerate(zip(lines[i],lines[i+1])):
                param = 1.0*index/(len(lines[i])-2)
                a = j[0]
                b = j[1]
                c1 = lerpColors(colorOptions,wave)
                fill(c1)
                vertex(a.x,a.y,a.z)
                c2 = lerpColors(colorOptions,(wave+1.0/(len(lines)-2)))
                fill(c2)
                vertex(b.x,b.y,b.z)
def lerpColors(colorOptions,amt):
    """Lerp function that takes an amount between 0 and 1, 
    and a list of colors and returns the appropriate
    interpolation"""
    
    if (len(colorOptions)==1): return colorOptions[0]
    spacing = 1.0/(len(colorOptions)-1)
    lhs = floor(amt/spacing)
    rhs = ceil(amt/spacing)
    
    try:
        return lerpColor(colorOptions[lhs], 
                         colorOptions[rhs], 
                         amt%spacing/spacing)
    except:
        return lerpColor(colorOptions[constrain(lhs, 0, len(colorOptions)-2)], 
                         colorOptions[constrain(rhs, 1, len(colorOptions)-1)], 
                         amt);
def dashedLine(p1,p2):
    #Play with these parameters
    res = 70
    step = 2
    
    points = [PVector.lerp(p1,
                           p2,
                           1.0*i/res) for i in range(res+1)]
    for i in range(len(points))[:-1:step]:
        v1 = points[i]
        v2 = points[i+1]
        line(v1.x,v1.y,v1.z,
             v2.x,v2.y,v2.z)
