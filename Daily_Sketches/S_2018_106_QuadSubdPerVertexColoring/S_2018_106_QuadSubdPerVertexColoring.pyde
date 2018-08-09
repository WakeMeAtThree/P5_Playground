def setup():
    size(1000,1000,P3D)
    colorMode(RGB,1.0,1.0,1.0)
    Quads = []
    Quads.append(Quadrant(0,0,width,height))
    for i in range(15):
        Quads = [i.subdivide() for i in Quads]
        Quads = [j for i in Quads for j in i]
    
    for i in Quads:
        i.display()
    noLoop()
globalCount = 0

class Quadrant(object):
    def __init__(self,x,y,w,h):
        global globalCount 
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.bool = True if (globalCount==0) else (random(1.0)>0.5)
        globalCount += 1
    def subdivide(self):
        if(self.bool):
            cell1 = Quadrant(self.x,self.y,self.w/2.0,self.h/2.0)
            cell2 = Quadrant(self.x+self.w/2,self.y,self.w/2.0,self.h/2.0)
            cell3 = Quadrant(self.x,self.y+self.h/2,self.w/2.0,self.h/2.0)
            cell4 = Quadrant(self.x+self.w/2,self.y+self.h/2,self.w/2.0,self.h/2.0)
            return [cell1,cell2,cell3,cell4]
        return [self]
    def display(self):
        noStroke()
        #noFill
        colors = [[random(1),random(1),random(1)] for i in range(4)]
        with beginShape(QUADS):
            fill(*colors[0])
            vertex(self.x,self.y)
            fill(*colors[1])
            vertex(self.x+self.w,self.y)
            fill(*colors[2])
            vertex(self.x+self.w,self.y+self.h)
            fill(*colors[3])
            vertex(self.x,self.y+self.h)
        #rect(self.x,self.y,self.w,self.h)