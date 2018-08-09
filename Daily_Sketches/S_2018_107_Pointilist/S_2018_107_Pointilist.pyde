# Look for faster ways of generating these dots
def setup():
    global points
    size(400,400)
    points = [PVector(width/2,height/2)]
    strokeWeight(4)
    
def draw():
    newPoint(0,0,width,height)
    #for i in points:
        #point(i.x,i.y)

def newPoint(X,Y,W,H):
    newPoint = PVector(random(X,width),
                       random(Y,height))
    valid = True
    edges = [PVector(newPoint.x,newPoint.y),
             PVector(newPoint.x+1,newPoint.y),
             PVector(newPoint.x-1,newPoint.y),
             PVector(newPoint.x,newPoint.y+1),
             PVector(newPoint.x,newPoint.y-1),
             PVector(newPoint.x+1,newPoint.y+1),
             PVector(newPoint.x+1,newPoint.y-1),
             PVector(newPoint.x-1,newPoint.y+1),
             PVector(newPoint.x-1,newPoint.y-1)]
    edges = [get(int(i.x),int(i.y)) for i in edges]
    edges = [red(i)==0 for i in edges]
    
    if(any(edges)):
        valid = False
    # for i in points:
    #     d = PVector.dist(i,newPoint)
    #     if(d < 6): valid = False
    
    if(valid): point(newPoint.x,newPoint.y) #points.append(newPoint) 