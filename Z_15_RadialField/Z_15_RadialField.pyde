from grow import *

pointslist = []

def setup():
    size(400,400);
    background(0);
    
    for i in range(20):
        for j in range(20):
            d = dist(i*50,j*50,width/2,width/2)
            pointslist.append((d,Node(i*50,j*50)))
    
def draw():
    background(0)
    global pointslist
    for j,i in enumerate(sorted(pointslist)):
        i[1].grow(millis()/1000+15.0*j/len(pointslist))
        i[1].display()
   
    