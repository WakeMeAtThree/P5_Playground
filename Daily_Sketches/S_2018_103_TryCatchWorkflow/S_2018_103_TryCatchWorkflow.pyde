#This is demonstrating a Try/Except workflow
#to demonstrate a possible live coding performance
#by changing input data from an external program

def setup():
    global a,X,Y,spaceX,spaceY,pat1
    size(400,400)
    blendMode(DIFFERENCE)
    background(255)
    a = 0
    pat1 = loadShape("pat1.svg")
    
    X = 7
    Y = 7
    spaceX = 1.0*width/X
    spaceY = 1.0*height/Y
   
def draw():
    global a
    try:
        pat1 = loadShape("pat2.svg")
        pat1 = loadShape("pat3.svg")

    except:
        pat1 = loadShape("pat1.svg")

    background(255)
    for i in range(X+2):
        param1 = 1.0*i/(X)
        for j in range(-1,Y+2):
            param2 = 1.0*j/(Y)
            newShape = pat1
            with pushMatrix():
                
                translate(spaceX*i,spaceY*j)
                rotate(lerp(0,TWO_PI,noise(a+param1*0.64,param2*0.63)))
                shape(newShape,0,0,spaceX,spaceY)
    a += 0.02
