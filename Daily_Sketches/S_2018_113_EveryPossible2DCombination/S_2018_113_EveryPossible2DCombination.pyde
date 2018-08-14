from itertools import combinations
def setup():
    global a,c
    size(400,400)
    frameRate(15)
    a = 0
    X = 4
    Y = 4
    spaceX = width/X
    spaceY = height/Y
    
    objects = [Rectangle(spaceX*i,spaceY*j,spaceX,spaceY) for i in range(X) for j in range(Y)]
    c = [comb for i in range(len(objects)) for comb in combinations(objects, i + 1)]

def draw():
    global a
    background(0)
    for k in c[a%len(c)]:
        k.display()
    a += 1

class Rectangle(object):
    def __init__(self,X,Y,W,H):
        self.X = X
        self.Y = Y
        self.W = W
        self.H = H
    def display(self):
        rect(self.X,self.Y,self.W,self.H)
