from colorPalettes import *

def setup():
    size(400,400,P3D)
    smooth(8)
    ortho()
    
    #Coordinate transformations
    translate(width/2,height/2)
    rotateX(PI/4)
    rotateZ(PI/4)
    
    #Box display
    background(255)
    Box = myBox(*colors1,wf=False)
    Box.displayContours(0,0,100,100,100)
    
    #Create Side Contours + Other Side Contours to finalize it

    
class scene(object):
    def __init__(self,colors=[]):
        pass
    def setup(self):
        pass
    def draw(self):
        pass

class myBox(object):
    def __init__(self,top,front,side,wf=False):
        self.top = top
        self.bottom = front
        self.front = front
        self.side = side
        self.wf = wf
    def display(self,X,Y,L,W,H):
        if(self.wf):
            self.displayWireFrame(X,Y,L,W,H)
        else:
            self.displayShaded(X,Y,L,W,H)
    def displayShaded(self,X,Y,L,W,H):
        #background(self.bg)
        points = [PVector(X,Y),
                  PVector(X+L,Y),
                  PVector(X+L,Y+W),
                  PVector(X,Y+W),
                  PVector(X,Y)]
        pairs = [(points[i],points[i+1]) for i in range(len(points)-1)]
        with pushMatrix():
            #translate(X,Y)
            # Bottom
            fill(self.top)
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,0)
            
            # Top
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,H)
            # Sides
            fill(self.side)
            for k in [0,2]:
                with beginShape(QUAD_STRIP):
                    for i in pairs[k]:
                        vertex(i.x,i.y,0)
                        vertex(i.x,i.y,H)
            # Front
            fill(self.front)
            for k in [1,3]:
                with beginShape(QUAD_STRIP):
                    for i in pairs[k]:
                        vertex(i.x,i.y,0)
                        vertex(i.x,i.y,H)
    def displayContours(self,X,Y,L,W,H):
        #background(self.bg)
        points = [PVector(X,Y),
                  PVector(X+L,Y),
                  PVector(X+L,Y+W),
                  PVector(X,Y+W),
                  PVector(X,Y)]
        pairs = [(points[i],points[i+1]) for i in range(len(points)-1)]
        stroke(0)
        for j in range(0,H+1,5):
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,j)
        noStroke()
        # Bottom
        fill(self.top)
        with beginShape():
            for i in points:
                vertex(i.x,i.y,0)
        
        # Top
        with beginShape():
            for i in points:
                vertex(i.x,i.y,H)
        # Sides
        for k in [0,2]:
            with beginShape(QUAD_STRIP):
                for i in pairs[k]:
                    vertex(i.x,i.y,0)
                    vertex(i.x,i.y,H)
        # Front
        for k in [1,3]:
            with beginShape(QUAD_STRIP):
                for i in pairs[k]:
                    vertex(i.x,i.y,0)
                    vertex(i.x,i.y,H)
        
    def displayWireFrame(self,X,Y,L,W,H):
        #background(self.bg)
        with pushStyle():
            points = [PVector(0,0),
                    PVector(L,0),
                    PVector(L,W),
                    PVector(0,W),
                    PVector(0,0)]
            pairs = [(points[i],points[i+1]) for i in range(len(points)-1)]
            noFill()
            stroke(self.top)
            strokeWeight(lerp(1,5,L/100.0))
            with pushMatrix():
                translate(X,Y)
                # Bottom
                #fill(self.top)
                with beginShape():
                    for i in points:
                        vertex(i.x,i.y,0)
                
                # Top
                with beginShape():
                    for i in points:
                        vertex(i.x,i.y,H)
                # Sides
                #fill(self.side)
                for k in [0,2]:
                    with beginShape(QUAD_STRIP):
                        for i in pairs[k]:
                            vertex(i.x,i.y,0)
                            vertex(i.x,i.y,H)
                # Front
                #fill(self.front)
                for k in [1,3]:
                    with beginShape(QUAD_STRIP):
                        for i in pairs[k]:
                            vertex(i.x,i.y,0)
    def displayTops(self,X,Y,L,W,H):
        #background(self.bg)
        points = [PVector(0,0),
                  PVector(L,0),
                  PVector(L,W),
                  PVector(0,W),
                  PVector(0,0)]
        pairs = [(points[i],points[i+1]) for i in range(len(points)-1)]
        with pushMatrix():
            translate(X,Y)
            # Bottom
            fill(self.bottom)
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,0)
            
            # Top
            fill(self.top)
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,H)
            # Sides
            # fill(self.side)
            # for k in [0,2]:
            #     with beginShape(QUAD_STRIP):
            #         for i in pairs[k]:
            #             vertex(i.x,i.y,0)
            #             vertex(i.x,i.y,H)
            # # Sides
            # fill(self.front)
            # for k in [1,3]:
            #     with beginShape(QUAD_STRIP):
            #         for i in pairs[k]:
            #             vertex(i.x,i.y,0)
            #             vertex(i.x,i.y,H)
