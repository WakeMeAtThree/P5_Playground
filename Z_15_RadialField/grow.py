class Node(object):
    def __init__(self,x_,y_):
        self.x = x_
        self.y = y_
        self.r = 15
    def grow(self,speed):
        self.r = map(35*abs(sin(speed*0.1)),0,35,15,35);
        #fill(abs(sin(speed))*255,0,0)
    def display(self):
        ellipse(self.x,self.y,self.r,self.r)