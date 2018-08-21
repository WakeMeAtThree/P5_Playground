def setup():
    global t,colorOptions
    size(400,400,P2D)
    smooth(8)
    c = color(120) #"#0EC0E1"
    colorOptions = [lerpColor("#000000",c,0.15),
                    lerpColor("#000000",c,0.35),
                    c,
                    lerpColor("#FFFFFF",c,0.15)][::-1]
    t = 0
    
def draw():
    background(255)
    global t
    p1 = PVector(0,0)
    p2 = PVector(width,height)
    
    translate(width/2,height/2)
    lines = []
    n = int(constrain(15*noise(30.0*t),3,15))
    l = 55

    for i in range(n):
        param = 1.0*i/(n-1)
        angle = param*TWO_PI
        p1 = PVector(50*cos(angle),50*sin(angle))
        p2 = PVector(150*cos(angle),150*sin(angle))
        lines.append(drawLine(p1,p2,l))
    drawMesh(lines)
    noStroke()
    
    t += 0.0025
def drawMesh(lines):
    strokeWeight(1)
    for i in range(len(lines)-1):
        wave = 1.0*i/(len(lines)-2)
        with beginShape(QUAD_STRIP):
            for index,j in enumerate(zip(lines[i],lines[i+1])):
                param = 1.0*index/(len(lines[i])-1)
                a = j[0]
                b = j[1]
                
                ease1 = map(sin(TWO_PI*(param+wave+t)),-1,1,0,1)**1.8
                c1 = lerpColors(colorOptions,ease1)
                fill(c1)
                vertex(a.x,a.y)
                
                ease2 = map(sin(TWO_PI*(param+wave+t+1.0/(len(lines)-2))),-1,1,0,1)**1.8
                c2 = lerpColors(colorOptions,ease2)
                #fill(c2)
                vertex(b.x,b.y)

def drawLine(p1,p2,res):
    return [PVector.lerp(p1,
                         p2,
                         1.0*i/(res-1)) for i in range(res)]
def dashedLine(p1,p2):
    #Play with these parameters
    res = 20
    step = 2
    
    points = [PVector.lerp(p1,
                           p2,
                           1.0*i/res) for i in range(res+1)]
    for i in range(len(points))[:-1:step]:
        v1 = points[i]
        v2 = points[i+1]
        line(v1.x,v1.y,v2.x,v2.y)

def lerpColors(colorOptions,amt):
    """Lerp function that takes an amount between 0 and 1, 
    and a list of colors and returns the appropriate
    interpolation"""
    
    if (len(colorOptions)==1): return colorOptions[0]
    spacing = 1.0/(len(colorOptions)-1)
    lhs = floor(amt/spacing)
    rhs = ceil(amt/spacing)
    
    try:
        return lerpColor(colorOptions[lhs], 
                         colorOptions[rhs], 
                         amt%spacing/spacing)
    except:
        return lerpColor(colorOptions[constrain(lhs, 0, len(colorOptions)-2)], 
                         colorOptions[constrain(rhs, 1, len(colorOptions)-1)], 
                         amt);
