def setup():
    global shapes,a,X,Y,spaceX,spaceY
    size(400,400)
    noStroke()
    fill(0)
    a = 0
    
    #Load shapes
    yes = loadShape("yes.svg")
    no = loadShape("no.svg")
    maybe = loadShape("maybe.svg")
    
    #List shapes
    shapes = [no,yes,maybe]
    shapes = [getShapes(i) for i in shapes]
    
    #Divide grid
    X = 8
    Y = 50
    spaceX = 1.0*width/X
    spaceY = 1.0*height/Y
    

def draw():
    global a
    background(255)
    multiplier = 1.0
    for i in range(X+1):
        delayX = multiplier*i/(X)
        for j in range(Y+1):
            delayY = multiplier*j/(Y)
            if(j % 2 == 0):
                module(i*spaceX,j*spaceY,expression(delayX,delayY,a))
            else:
                module(i*spaceX+spaceX/2.0,j*spaceY,expression(delayX,delayY,a))
    #saveFrame("output8/animation###.png")
    if(a > 10.0): exit()
    a += 0.03
def expression(delayX,delayY,a):
    scl = lerp(0.0,2.0,1.0*mouseX/width)
    return multistep(noise(delayX+a,delayY))
def module(X,Y,a):
    with pushMatrix():
        translate(X,Y)
        scale(0.5)
        blended = lerpGroups(shapes,a)
        for subshape in blended:
            with beginShape():
                for i in subshape:
                    vertex(i.x,i.y)
def getShapes(Pshape):
    """Takes a Pshape, goes through all its child elements
    and returns a list of list of points for each child"""
    
    shapes = []
    for i in range(Pshape.getChildCount()):
        pointlist = []
        for j in range(Pshape.getChild(i).getVertexCount()):
            pointlist.append(Pshape.getChild(i).getVertex(j))
        shapes.append(pointlist)
    return shapes
def lerpGroups(groups,amt):
    if(len(groups)==1):
        return groups[0]
    spacing = 1.0/(len(groups)-1)
    lhs = floor(amt/spacing)
    rhs = ceil(amt/spacing)
    try:
        return lerpGroup(groups[lhs], groups[rhs], amt%spacing/spacing)
    except:
        return lerpGroup(groups[constrain(lhs, 0, len(groups)-2)],
                         groups[constrain(rhs, 1, len(groups)-1)],
                         amt)
def lerpGroup(group1,group2,amt):
    return [lerpVectors(i,j,amt) for i,j in zip(group1,group2)]
def lerpVectors(plist1,plist2,amt):
    return [PVector.lerp(i,j,amt) for i,j in zip(plist1,plist2)]

def smoothstep(a,b,x):
    x = constrain((x - a)/
                    (b - a), 0.0, 1.0)
    return x * x * (3 - 2 * x)
def multistep(val):
    y = 0.5*smoothstep(0.1,0.3,val)
    y += 0.5*smoothstep(0.5,0.8,val)
    return y
