
def setup():
    global someShader,ballList,a
    size(600,600,P3D)
    noStroke()
    someShader = loadShader("shader.glsl")
    ballList = []
    for i in range(500):
        ballList.append(Ball())
    a = 0
    
def draw():
    global a
    for i in ballList:
        i.bounce()
        i.update()
        
    try:
        someShader = loadShader("shader.glsl")
    except:
        resetShader()
    someShader.set("iResolution", float(width), float(height));
    someShader.set("iMouse", float(mouseX), height-float(mouseY));
    someShader.set("iTime", millis() / 1000.0);
    #someShader.set("locations[0]",float(width)/2.0, float(height)/2.0);    # for index,p in enumerate(getPositions(ballList)):
    for index,i in enumerate(ballList):
        someShader.set("locations[{}]".format(index),i.pos.x,height-i.pos.y)
        someShader.set("radii[{}]".format(index),float(1.0*i.radius/width))
        someShader.set("colors[{}]".format(index),float(i.colors.x),
                                                  float(i.colors.y),
                                                  float(i.colors.z))
    shader(someShader);
    rect(0,0,width,height);
    a+=0.01

def getPositions(ballList):
    output = []
    for i in ballList:
        output.append(PVector(i.pos.x,i.pos.y))
    return output

class Ball(object):
    def __init__(self):
        self.radius = random(5,25)
        self.pos = PVector(random(width),random(height))
        self.colors = PVector(random(1.0),random(1.0),random(1.0))
        angle = random(TWO_PI)
        self.vel = PVector(cos(angle),sin(angle)).mult(1)
        self.acc = None
    def run(self):
        self.update()
        self.bounce()
        self.display()
    def update(self):
        self.pos.add(self.vel)
    def bounce(self):
        if(self.pos.x > width or self.pos.x < 0): self.vel.x *= -1
        if(self.pos.y > height or self.pos.y < 0): self.vel.y *= -1
        
    def display(self):
        fill(255,0,0)
        ellipse(self.pos.x,self.pos.y,self.radius*2,self.radius*2)
