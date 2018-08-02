#Matrix = [[j for j in range(5)] for i in range(5)]
a = 0
# A sketch I made that makes use of normalize sums across rows and across matrices
# which accidentally led me to generate a Mondrian-ish sort of grid, but I'm
# not interested in using it for that. I'll be inserting my own modules and 
# updating this to a class so that the width and height is resolved by itself
X = 5
Y = 16
margin = 35
def normalizeList(alist,multiply): return [1.0*multiply*i/(sum(alist)+0.0001) for i in alist]

def setup():
    global colors,coloroptions,chance
    size(400,400)
    strokeWeight(3)
    ellipseMode(CORNER)
    frameRate(2)
    #blendMode(EXCLUSION)
    #noStroke()

    coloroptions = ['#000000',
                    '#FFFFFF']
    biases = [1,3,1,15]
    coloroptions = bias(coloroptions,biases)
    coloroptions = shuffle(coloroptions)
    
    colors = [[floor(random(len(coloroptions))) for j in range(X)] for i in range(Y)]
    #chance = [[0 if random(1)>0.2 else j for j in i] for i in Matrix]
def expression(time,i,j):
    amplitude = 5.0
    frequency = 0.1
    delay = 1.0*(i+j)/(X+Y-2)
    
    transformation = sin(TWO_PI*time+delay*frequency)
    transformation += cos(TWO_PI*time+frequency+delay)
    transformation += sin(TWO_PI*time+frequency*2.1+delay)
    transformation += sin(TWO_PI*time+frequency*1.72+delay)
    transformation += cos(TWO_PI*time+frequency*2.221+delay)
    transformation += sin(TWO_PI*time+frequency*3.1122+delay)
    transformation *= amplitude
    return transformation#map(transformation,-amplitude,amplitude,0,1)
def draw():
    #background(255)
    background('#FFFFFF')
    global Matrix,a
    scl = 500
    horizontal = True # [False,True][noise(a)>0.5]
    Matrix = [[expression(a,i,j) for j in range(X)] for i in range(Y)]
    #Matrix = 
    translate(margin,margin)
    if(horizontal):
        #Matrix = [[sin(a+(i+j)*1.0/10) for j in range(5)] for i in range(5)]
        #Matrix = [[noise(scl*i+a,scl*j+a) for j in range(5)] for i in range(10)]
        
        #Normalize horizontally
        Matrix = [normalizeList(i,width-margin*2) for i in Matrix]
        shiftY = 0
        spaceY = 1.0*height/Y
        
        #OPTION 1
        spacey = [i for i in range(Y)]
        #OPTION 2
        #spacey = [1 for i in range(Y)]
        
        spacey = normalizeList(spacey,height-46-margin)
        param = [0,0]
        for row in Matrix:
            shiftX = 0
            param[1] = 0
            for i in row:
                stroke(coloroptions[[0,1][random(1)<0.55]])
                strokeWeight(random(1,3))
                
                #stroke(random(70),230)
                #ellipse(shiftX,shiftY,i,spacey[param[0]])
                drawSomeLines(shiftX,shiftY*1.05,i,spacey[param[0]],25)
                shiftX += i
                param[1]+=1
            shiftY += spacey[param[0]]
            param[0] += 1      
    
    #noLoop()
    a += 0.001
    #saveFrame("irregulardropping/animation###.png")

def keyPressed():
    redraw()

def bias(modules, multiples):
    output = []
    for i,j in zip(modules,multiples):
        output+=[i]*j
    return output

def shuffle(alist):
    jumble = alist
    for i,letter in enumerate(jumble):
        r = int(random(i))
        jumble[i],jumble[r] = jumble[r],jumble[i]
    return jumble

def drawSomeLines(x,y,w,h,n):
    positions = [random(1)*w for i in range(n)]
    with pushMatrix():
        translate(x,y)
        #or use following for rotations
        #translate(x+w/2.0,y+h/2.0)
        #rotate(random(2))
        #translate(-w/2.0,-h/2.0)
        for i in positions:
            with pushMatrix():
                
                line2(i,0,i,h)

def line2(x1,y1,x2,y2):
    p1 = PVector(x1,y1)
    p2 = PVector(x2,y2)
    res = 4
    scl = 2
    points = [p1.copy()]+[PVector.lerp(p1.copy().add(PVector(random(scl),random(scl))),
                                       p2.copy().add(PVector(random(scl),random(scl))),
                                       1.0*i/(res-1)) for i in range(res)]+[p2]
    noFill()
    with beginShape():
        for i in points:
            curveVertex(i.x,i.y)
