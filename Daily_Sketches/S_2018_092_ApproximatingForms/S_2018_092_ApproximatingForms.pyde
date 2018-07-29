
import os

def setup():
    global begin,target,a,toon
    size(400,400,P3D)
    background(255)
    ortho()
    a = 0
    begin = loadPoints("data/sphere")
    target = loadPoints("data/boxes3")
    toon = loadShader("ToonFrag.glsl", "ToonVert.glsl")
    print(len(begin))
    
    #strokeWeight(5)
    noStroke()
    smooth(8)
    #stroke(0,128)

def draw():
    global a
    background(0)

    option = PVector(314, 259)
    #option = PVector(mouseX, mouseY)
    dirY = (option.y / float(height) - 0.5) * 2
    dirX = (option.x / float(width) - 0.5) * 2
    
    directionalLight(204, 204, 204, -dirX, -dirY, -1)
    
    ###
    # translate(width/2,height/2-78)
    # scale(0.7)
    # rotateX(PI/4)
    # rotateZ(PI/4)
    translate(45+9+8,height+37-240+30)
    if(mousePressed): print(mouseX,mouseY)
    scale(0.5)
    rotateZ(-PI/2)
    
    #Applying custom shear Matrix
    
    applyMatrix(  
    1.0, 0.0, 1.0,  0.0,
    0.0, 1.0, 0.0,  0.0,
    0.0, 0.0, 1.0,  0.0,
    0.0, 0.0, 0.0,  1.0);
    
    rotateZ(PI/4)
    shader(toon)
    movePoints = [PVector.lerp(i[0],i[1],map(cs(TWO_PI*a+5.0*k/1000),-1,1,0,1)) for k,i in enumerate(zip(begin,target))]
    for i in movePoints:
        strokeWeight(1)
        with pushMatrix():
            fill(255)
            stroke(0,200)
            #noStroke()
            translate(i.x,i.y,i.z)
            box(lerp(0,55,1.0*205/width))
    for i,j in zip(begin,target):
        strokeWeight(1)
        stroke(0,25)
        #point(i.x,i.y,i.z)
        #line(i.x,i.y,i.z,j.x,j.y,j.z)
    if(mousePressed): print(mouseY)
    a += 0.0025
    #saveFrame("output9/animation###.png")
    if(a >= 1.0): exit()

def loadPoints(fname):
    with open(fname) as f:
        content = f.readlines()
    data = [i.replace('\n','')[1:][:-1].split(',') for i in content]
    data = [PVector(*map(float,i)) for i in data]
    return data


def ease(p): return 3*p*p - 2*p*p*p;

def ease(p, g):
    if (p < 0.5): 
        return 0.5 * pow(2*p, g);
    else:
        return 1 - 0.5 * pow(2*(1 - p), g);

def sn(q): return lerp(-1, 1, ease(map(sin(q), -1, 1, 0, 1), 5))
def cs(q): return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 5))

class bbox(object):
    def __init__(self, scl):
        self.top
        self.bottom
        self.right
        self.left
        self.front
        self.back
        
