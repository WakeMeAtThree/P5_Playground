count = 0
def setup():
    global randoms
    size(400,400)
    smooth(8)
    randoms = [random(0.1) for i in range(40)]
def draw():
    background(255)
    stroke(0,50)
    p1 = PVector(width/4,height/2)
    p2 = PVector(mouseX,mouseY)
    dashedLine(p1,p2,"dot",)

def dashedLine(p1,p2,ends=None,randomize=True):
    #Play with these parameters
    

    res = 40
    step = 2
    offsets = lambda i: [0,randoms[i%res]][randomize]
    points = [PVector.lerp(p1,
                           p2,
                           1.0*i/res+offsets(i)) for i in range(res+1)]
    points = [PVector(i.x,i.y+5.0*randoms[index%res]) for index,i in enumerate(points)] 
    for i in range(len(points))[:-1:step]:
        v1 = points[i]
        v2 = points[i+1]
        line(v1.x,v1.y,v2.x,v2.y)
    if(ends): 
        # dot
        with pushStyle():
            strokeWeight(5)
            stroke(0)
            point(p1.x,p1.y)
            point(p2.x,p2.y)
        # plus
        
