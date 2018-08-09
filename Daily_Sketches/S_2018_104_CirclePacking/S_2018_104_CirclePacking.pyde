def setup():
    global circles
    size(400,400)
    circles = []
    circles.append(Circle(width/2,height/2))
    
     
def draw():
    background(0)
    newCircle()
    for c in circles:
        if(c.growing):
            if(c.edges()):
                c.growing = False
            else:
                overlapping = False
                for other in circles:
                    if(c != other):
                        d = dist(c.x,c.y,other.x,other.y)
                        strokeval = 1
                        if(d < c.r + other.r + strokeval):
                            c.growing = False
                            break
                            #overlapping = True
                        
        c.show()
        c.grow()
def newCircle():
    x,y = random(width),random(height)
    valid = True
    for c in circles:
        d = dist(x,y,c.x,c.y)
        if(d < c.r):
            valid = False
            break
    if(valid): circles.append(Circle(x,y))
            

class Circle(object):
    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.pos = PVector(x,y)
        self.r = 1
        self.speed = random(1)
        self.growing = True
        
    def show(self):
        stroke(255)
        noFill()
        ellipse(self.x,self.y,self.r*2,self.r*2)
    def grow(self):
        if(self.growing):
            self.r += self.speed
        
    def edges(self):
        return (self.x+self.r > width) or (self.x-self.r < 0) or (self.y+self.r > height) or (self.y-self.r < 0)
