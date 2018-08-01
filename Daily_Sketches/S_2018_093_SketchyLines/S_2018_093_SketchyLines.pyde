def setup():
    global step, spaceY,a
    size(400,400)
    strokeWeight(3)
    strokeCap(ROUND)
    background(255)
    step = 50
    spaceY = height/3.0
    a = 0

def normalizeList(alist,multiply): 
    return [1.0*multiply*i/(sum(alist)) for i in alist]

def someDraw(x,y,step1,step2,positions,d):
    with pushMatrix():
        #translate(x,y)
        with pushStyle():
            stroke(255,0,0)
            #rect(0,0,step1,step2)
        translate(x + step1/2.0, y + step2/2.0)
        rotate(d);
        translate(-step1/2.0, -step2/2.0)
        for i in positions:
            line2(i*step1,0,
                 i*step1,step2)

def draw():
    global a
    background(255)
    shiftY = 0
    for y in range(37,width-37,37):
        for x in range(step,height-step, step):
            strokeWeight(random(1,3))
            stroke(random(70),230)
            d = 0.1*(x+y)/(width+height)
            someDraw(x,y,step,step,[random(1) for i in range(20)],d)
            #if(y < spaceY): someDraw(x,y,step,step,[random(1) for i in range(20)])
            #elif(y < spaceY*2): someDraw(x,y,step,step,[random(1) for i in range(20)])
            #else: someDraw(x,y,step,step,[random(1) for i in range(20)])

    noLoop()
    a+=0.01

def line2(x1,y1,x2,y2):
    p1 = PVector(x1,y1)
    p2 = PVector(x2,y2)
    res = 3
    scl = 2
    points = [p1]+[PVector.lerp(p1.copy().add(PVector(random(scl),random(scl))),
                                p2.copy().add(PVector(random(scl),random(scl))),
                                1.0*i/res) for i in range(res)]+[p2]
    noFill()
    with beginShape():
        for i in points:
            curveVertex(i.x,i.y)
