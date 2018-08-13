class Ball(object):
    def __init__(self, pos, diam, id, others,boundaries):
        self.pos = pos
        self.diam = diam
        self.vel = PVector(0,0)
        self.id = id
        self.others = others
        self.spring = 0.01
        self.boundaries = boundaries
    def collide(self):
        for i in range(self.id+1,len(self.others)):
            dx = self.others[i].pos.x - self.pos.x
            dy = self.others[i].pos.y - self.pos.y
            distance = sqrt(dx**2+dy**2)
            minDist = self.others[i].diam/2.0 + self.diam/2.0
            if(distance < minDist):
                angle = atan2(dy,dx)
                targetX = self.pos.x + cos(angle) * minDist
                targetY = self.pos.y + sin(angle) * minDist
                ax = (targetX - self.others[i].pos.x) * self.spring
                ay = (targetY - self.others[i].pos.y) * self.spring
                self.vel.x -= ax
                self.vel.y -= ay
                self.others[i].vel.x += ax
                self.others[i].vel.y += ay
    def move(self):
        
        check = [i.contains(self.pos) for i in self.boundaries]
        index = (check.index(True)) if(True in check) else floor(random(len(boundary)))
        boundary = self.boundaries[index]

        if(self.pos.x > boundary.X+boundary.W-self.diam or self.pos.x < boundary.X+self.diam): self.vel.x *= -1
        if(self.pos.y > boundary.Y+boundary.H-self.diam or self.pos.y < boundary.Y+self.diam): self.vel.y *= -1
        self.pos.add(self.vel)
    def display(self):
        ellipse(self.pos.x,self.pos.y,self.diam,self.diam)
class boundary(object):
    def __init__(self,X,Y,W,H):
        self.X = X
        self.Y = Y
        self.W = W
        self.H = H
        
    def contains(self,pos):
        x = self.X
        y = self.Y
        w = self.W
        h = self.H
        if(pos.x >= x and
           pos.x <= x + w and
           pos.y >= y and 
           pos.y <= y + h): return True
        return False

    def display(self):
        noFill()
        stroke(255)
        rect(self.X,self.Y,self.W,self.H)
    def highlight(self):
        if(self.contains(PVector(mouseX,mouseY))):
            fill(255,0,0)
            rect(self.X,self.Y,self.W,self.H)
def setup():
    global balls,boundaries
    size(400,400)
    balls = []
    boundaries = []
    boundaries.append(boundary(0,0,width/2,height/2))
    boundaries.append(boundary(width/2,0,width/2,height/2))
    boundaries.append(boundary(0,height/2,width/2,height/2))
    boundaries.append(boundary(width/2,height/2,width/2,height/2))
    for i in range(55):
        balls.append(Ball(PVector(random(width),random(height)),
                          random(15,25),
                          i,
                          balls,
                          boundaries))

    
def draw():
    background(0)
    for ball in balls:
        ball.collide()
        ball.move()
        ball.display()
    # for i in boundaries:
    #     i.display()
    #     i.highlight()
