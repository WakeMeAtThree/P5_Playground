
import os

def setup():
    global begin,target,a,toon,phrase,blendedColors,someShader
    size(400,400,P2D)
    a = 0
    someShader = loadShader("shader.glsl")
    sanahelwa = loadPoints("data/sanahelwa.csv")
    yaahla = loadPoints("data/yaahla.csv")
    baba = loadPoints("data/baba.csv")
    
    #points = [B for i in sanahelwa]
    
    blendedColors = [PVector(1.0,1.0,1.0) for i in range(len(baba))]
    phrase = [sanahelwa,yaahla,baba]

def draw():
    global a
    background(255)
    try:
        someShader = loadShader("shader.glsl")
    except:
        resetShader()
    
    someShader.set("iResolution", float(width), float(height));
    someShader.set("iMouse", float(mouseX), height-float(mouseY));
    someShader.set("iTime", millis() / 1000.0);
    
    blended = lerpLists(phrase,map(0.5*cs(TWO_PI*a)+0.5*cs(TWO_PI*a+1.5),-1,1,0,1))
    blended = [PVector(i.x,i.y,i.z) for i in blended]
    index = 0
    for pos,colors in zip(blended,blendedColors):
        someShader.set("locations[{}]".format(index),pos.x,height-pos.y)
        someShader.set("radii[{}]".format(index),lerp(1.5,2.0,cs(TWO_PI*a)))
        someShader.set("colors[{}]".format(index),float(colors.x),
                                                  float(colors.y),
                                                  float(colors.z))
        index += 1
    shader(someShader);
    rect(0,0,width,height);
    a += 0.005
    #saveFrame("output3/animation###.png")
    if(a > 1.0): exit()
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
def lerpLists(lists,amt):
    if(len(lists)==1):
        return lists[0]
    spacing = 1.0/(len(lists)-1)
    lhs = floor(amt/spacing)
    rhs = ceil(amt/spacing)
    try:
        return lerpList(lists[lhs], lists[rhs], amt%spacing/spacing)
    except:
        return lerpList(lists[constrain(lhs, 0, len(lists)-2)],
                        lists[constrain(rhs, 1, len(lists)-1)],
                        amt)
def lerpList(list1,list2,amt):
    return [PVector.lerp(i,j,amt) for i,j in zip(list1,list2)]

class Balls(object):
    def __init__(self, pos):
        self.pos = pos
        self.radius = random(5,25)
        #self.colors = PVector(random(1.0),random(1.0),random(1.0))
    