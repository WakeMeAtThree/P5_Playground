def setup():
    size(400,400,P3D)
    smooth(8)
    ortho()
    translate(width/2,height/2)
    rotateX(PI/4)
    rotateZ(PI/4)
    noStroke()
    
    Box1 = myBox("#a66b0f","#bfab93","#496676")
    Box2 = myBox("#674f24","#bd9e7f","#891902")
    Box3 = myBox("#0a88b1","#c8c6b4","#c8c6b4")
    Box4 = myBox("#c6b89c","#922317","#cdb697")
    Box5 = myBox("#aa2e22","#759999","#2f3e5d")
    Box6 = myBox("#eae4d6","#f3d74f","#b1080f")
    Box7 = myBox("#82a8cd","#687cc1","#fd67b1","#f5e5ff")
    colors1 = ["#9b6f95","#c39194","#edc39d","#f2d19e"][::]
    colors2 = ["#85b289","#a8c48a","#cfd18f","#edd88e"][::-1]
    colors3 = ["#ef9e90","#d0a499","#99a6ac","#6cc1c4"][::]
    colors4 = ["#f17479","#cb7487","#b092b6","#6da6c4"][::]
    colors5 = ["#f17479","#cb7487","#b092b6","#6da6c4"][::]
    colors6 = ["#f4f4f4","#d480aa","#0d0f0e","#f4f4f4"][::-1]
    colors7 = ["#fab500","#d23b06","#201e1a","#eae2d4"][::-1]
    colors8 = ["#d23b06","#275d95","#201e1a","#eae2d4"][::]
    colors9 = ["#d7a23c","#c9c8b9","#c9c8b9","#282828"][::]
    Box8 = myBox(*colors1)
    #stroke("#8159af")
    Box8.display(0,0,100,100,100)

    

class myBox(object):
    def __init__(self,top,front,side,bg=0):
        self.top = top
        self.bottom = front
        self.front = front
        self.side = side
        self.bg = bg
    def displayTops(self,X,Y,L,W,H):
        background(self.bg)
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
            fill(self.side)
            for k in [0,2]:
                with beginShape(QUAD_STRIP):
                    for i in pairs[k]:
                        vertex(i.x,i.y,0)
                        vertex(i.x,i.y,H)
            # Sides
            fill(self.front)
            for k in [1,3]:
                with beginShape(QUAD_STRIP):
                    for i in pairs[k]:
                        vertex(i.x,i.y,0)
                        vertex(i.x,i.y,H)
    def display(self,X,Y,L,W,H):
        background(self.bg)
        points = [PVector(0,0),
                  PVector(L,0),
                  PVector(L,W),
                  PVector(0,W),
                  PVector(0,0)]
        pairs = [(points[i],points[i+1]) for i in range(len(points)-1)]
        with pushMatrix():
            translate(X,Y)
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
