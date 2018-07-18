add_library('peasycam')
#Matrix = [[j for j in range(5)] for i in range(5)]
a = 0
# A sketch I made that makes use of normalize sums across rows and across matrices
# which accidentally led me to generate a Mondrian-ish sort of grid, but I'm
# not interested in using it for that. I'll be inserting my own modules and 
# updating this to a class so that the width and height is resolved by itself

def normalizeList(alist,multiply): return [1.0*multiply*i/(sum(alist)+0.0001) for i in alist]

def setup():
    size(400,400,P3D)
    strokeWeight(0.01)
    #noStroke()
    cam = PeasyCam(this,100)
    
    #ellipseMode(CORNER)
    

def draw():
    background(255)
    global Matrix,a
    scl = 500

    horizontal = False # [False,True][noise(a)>0.5]
    Matrix = [[noise(scl*i+a,scl*j+a) for j in range(6)] for i in range(6)]
    
    #Uncomment below to randomly get rid of some squares by setting them to 0  
    #Matrix = [[0 if random(1)>0.2 else j for j in i] for i in Matrix]
    
    if(horizontal):
        #Matrix = [[sin(a+(i+j)*1.0/10) for j in range(5)] for i in range(5)]
        #Matrix = [[noise(scl*i+a,scl*j+a) for j in range(5)] for i in range(10)]
        
        #Normalize horizontally
        Matrix = [normalizeList(i,400) for i in Matrix]
        shiftY = 0
        spaceY = 1.0*height/len(Matrix)
        
        for row in Matrix:
            shiftX = 0
            for i in row:
                ellipse(shiftX,shiftY,i,spaceY)
                shiftX += i
            shiftY += spaceY      
    else:
        #Matrix = [[sin(a+(i+j)*1.0/10) for j in range(5)] for i in range(5)]
        #Matrix = [[noise(scl*i+a,scl*j+a) for j in range(5)] for i in range(10)]
        
        #Normalize vertically
        Matrix = [normalizeList(i,400) for i in zip(*Matrix)]
        shiftX = 0
        spaceX = [noise(i*scl+a) for i in range(6)]
        
        #Uncomment below to randomly get rid of some squares by setting them to 0
        #spaceX = [0 if random(1)>0.2 else j for j in spaceX]
        
        spaceX = normalizeList(spaceX,400)
        
        for k,row in zip(spaceX,Matrix):
            param = [0,0]
            shiftY = 0
            for i in row:
                #fill([color(255,255,255),[color(0,0,0),color(255,0,0)][random(1)>0.5]][random(1)>0.9])
                #ellipse(shiftX,shiftY,k,i)
                pushMatrix()
                translate(k/2,i/2,400*noise(a+5.0*sum(param)/len(param))/2)
                translate(shiftX,shiftY)
                scale(k,i,400*noise(a+5.0*sum(param)/len(param)))
                #ellipse(0,0,1,1)
                fill(255,0,0)
                box(1)
                popMatrix()
                shiftY += i
                param[0]+=1
            shiftX += k
            param[1]+=1
    #   noLoop()
    a += 0.01

def keyPressed():
    redraw()