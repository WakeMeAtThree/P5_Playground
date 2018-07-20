#Matrix = [[j for j in range(5)] for i in range(5)]
a = 0
# A sketch I made that makes use of normalize sums across rows and across matrices
# which accidentally led me to generate a Mondrian-ish sort of grid, but I'm
# not interested in using it for that. I'll be inserting my own modules and 
# updating this to a class so that the width and height is resolved by itself
X = 5
Y = 6
def normalizeList(alist,multiply): return [1.0*multiply*i/(sum(alist)+0.0001) for i in alist]

def setup():
    global colors,coloroptions,chance
    size(400,400)
    strokeWeight(5)
    ellipseMode(CORNER)
    noStroke()
    
    coloroptions = [color(225,0,0),color(225,128,0),color(0,50,230),color(255,255,255)]
    biases = [1,3,1,15]
    coloroptions = bias(coloroptions,biases)
    coloroptions = shuffle(coloroptions)
    
    colors = [[floor(random(len(coloroptions))) for j in range(X)] for i in range(Y)]
    #chance = [[0 if random(1)>0.2 else j for j in i] for i in Matrix]

def draw():
    background(0)
    global Matrix,a
    scl = 500
    horizontal = True # [False,True][noise(a)>0.5]
    Matrix = [[noise(scl*i+a,scl*j+a) for j in range(X)] for i in range(Y)]
    #Matrix = 
    
    if(horizontal):
        #Matrix = [[sin(a+(i+j)*1.0/10) for j in range(5)] for i in range(5)]
        #Matrix = [[noise(scl*i+a,scl*j+a) for j in range(5)] for i in range(10)]
        
        #Normalize horizontally
        Matrix = [normalizeList(i,width) for i in Matrix]
        shiftY = 0
        spaceY = 1.0*height/Y
        param = [0,0]
        for row in Matrix:
            shiftX = 0
            param[1] = 0
            for i in row:
                fill(coloroptions[colors[param[0]][param[1]]])
                ellipse(shiftX,shiftY,i,spaceY)
                shiftX += i
                param[1]+=1
            shiftY += spaceY
            param[0] += 1      
    
    #noLoop()
    a += 0.01

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