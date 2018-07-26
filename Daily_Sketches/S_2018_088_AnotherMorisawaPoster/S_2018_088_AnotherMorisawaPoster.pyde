#Using my mondrianish sketch as a template to tweak into
#the John Maeda's Morisawa posters
a = 0
X = 4
Y = 100
def normalizeList(alist,multiply): 
    return [1.0*multiply*i/(sum(alist)) for i in alist]

def setup():
    global colors,coloroptions,chance,someShapes
    size(282*2,400*2)
    strokeWeight(5)
    ellipseMode(CORNER)
    rectMode(CORNER)
    noStroke()
    
    shapeMode(CORNER)
    someShapes = [loadShape("one.svg"),loadShape("two.svg"),loadShape("three.svg"),loadShape("four.svg")]
    someShapes = [setPShape(i) for i in someShapes]
    #someShapes = [i.disableStyle() for i in someShapes]
    
    coloroptions = [color(225,0,0),color(225,128,0),color(0,50,230),color(255,255,255)]
    biases = [1,3,1,15]
    coloroptions = bias(coloroptions,biases)
    coloroptions = shuffle(coloroptions)
    
    colors = [[floor(random(len(coloroptions))) for j in range(X)] for i in range(Y)]
    #chance = [[0 if random(1)>0.2 else j for j in i] for i in Matrix]

def draw():
    background(255)
    global Matrix,a
    scl = 500
    horizontal = True # [False,True][noise(a)>0.5]
    Matrix = [[1 for j in range(X)] for i in range(Y)]
    #Matrix = [[noise(1*cos(TWO_PI*a+1.0*i/Y),1*sin(TWO_PI*a+1.0*j/X))
    
    if(horizontal):
        #Matrix = [[sin(a+(i+j)*1.0/10) for j in range(5)] for i in range(5)]
        #Matrix = [[noise(scl*i+a,scl*j+a) for j in range(5)] for i in range(10)]
        
        #Normalize horizontally
        Matrix = [normalizeList(i,1.0*width/(j+1)) for j,i in enumerate(Matrix)]
        shiftY = 0
        #spaceY = 1.0*height/Y
        #dynamicY = [lerp(0,5,map(cs(a+5.0*i/Y),-1,1,0,1)) for i in range(Y)]
        #dynamicY = [map(i,-1,1,0,5) for i in dynamicY]
        
        #spaceY = [1.0/(i+1) for i in shiftList(range(Y))[:-1]]
        spaceY = [1.0/(i+1) for i in range(Y)]
        spaceY = normalizeList(spaceY,height+mouseY)
        param = [0,0]
        for j,row in enumerate(Matrix):
            shiftX = 0
            param[1] = 0
            
            for i in row:
                
                with pushMatrix():

                    #fill([color(255,0,255),color(0,255,0),color(0,24,255),color(0,255,0)][param[1]%4])
                    fill(0)
                    #noFill()
                    #strokeWeight(0.5)
                    #stroke(0,150)
                    for k in range(j+1):
                        with pushMatrix():
                            translate(k*width/(j+1),0)
                            shape(someShapes[param[1]%len(someShapes)],shiftX,shiftY,i,spaceY[param[0]])
                            #rect(shiftX,shiftY,i,spaceY[param[0]])
                            #[rect,ellipse][param[1]%2](shiftX,shiftY,i,spaceY[param[0]])
                            
                shiftX += i
                param[1]+=1
            shiftY += spaceY[param[0]]
            param[0] += 1      
    
    #noLoop()
    a += 0.005
    if(a >= 1): exit()
    #saveFrame("output5/animation###.png")
    

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


def ease(p): return 3*p*p - 2*p*p*p;

def ease(p, g):
    if (p < 0.5): 
        return 0.5 * pow(2*p, g);
    else:
        return 1 - 0.5 * pow(2*(1 - p), g);

def sn(q): return lerp(-1, 1, ease(map(sin(q), -1, 1, 0, 1), 5))
def cs(q): return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 5))

def shiftList(alist):
    alist.append(alist[-1])
    return [lerp(alist[i],alist[(i+1)%(len(alist))],map(sin(TWO_PI*a+25.5*i/len(alist)),-1,1,0,1)) for i in range(len(alist))]

def setPShape(someShape):
    someShape.disableStyle()
    #someShape.setStrokeWeight(5)
    #someShape.setFill(color(230))
    return someShape