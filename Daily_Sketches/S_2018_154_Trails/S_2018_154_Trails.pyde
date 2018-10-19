add_library('fisica')
tailLength =355
def setup():
    global world,trail,circle,sections
    size(400,400,P3D)
    smooth(8)
    #ortho()
    Fisica.init(this)
    trail = []
    sections = []
    world = FWorld()
    world.setGravity(0,10)
    world.setEdges()
    #rectMode(CENTER)
    
    circle = FBox(120,120)
    circle.setPosition(width/2,height/2)
    trail = [PVector(circle.getX(),circle.getY(),circle.getRotation()) for i in range(tailLength)]
    world.add(circle)
def drawRect(X,Y,L,W):
    points = []
    return points

def draw():
    background(255)
    #circle.setRotation(constrain(circle.getRotation(),-PI/2,PI/2))
    for index,i in enumerate(trail[::-1]):
        delay = 1.0*index/(len(trail)-1)
        with pushMatrix():
            translate(i.x,i.y,-index*5)
            rotate(i.z)
            noFill()
            stroke(lerp(0,255,delay**0.5))
            ellipse(0,0,2,2)
            rect(-60,-60,120,120)
    trail.append(PVector(circle.getX(),circle.getY(),circle.getRotation()))
    del trail[0]
    #rotateX(PI/4)

    world.step()
    #world.draw()
    
