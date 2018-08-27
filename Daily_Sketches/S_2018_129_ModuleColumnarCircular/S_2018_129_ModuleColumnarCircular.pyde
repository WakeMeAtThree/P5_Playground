def setup():
    global colorOptions
    size(400,400,P3D)
    background(0)
    smooth(8)
    ortho()
    translate(width/2,height/2)
    colorOptions = [color(0),
                    color(255)]
    rotateX(PI/6)             
    rotateZ(PI/4)
    noStroke()
    squishedcircularbox(0,0,50,50,550,0.5)
    
def squishedcircularbox(X,Y,L,W,H,val):
    circleres = 130
    points = [PVector(L*cos(TWO_PI*1.0*i/(circleres-1))+L,
                      W*sin(TWO_PI*1.0*i/(circleres-1))+W) for i in range(circleres)]
    center = PVector(L/2.0,W/2.0,H)
    res = 15
    strips = [movePointsToCenter(points,
                                 center,
                                 val*i/(res-1)) for i in range(res)]
    outlines = zip(*strips)+[strips[-1]]
    with pushMatrix():
        translate(X,Y)
        drawMesh(strips)

                

def movePointsToCenter(points,center,amt):
    return [customLerp(i,center,amt) for i in points]
def customLerp(v1,v2,amt):
    x = lerp(v1.x,v2.x,amt)
    y = lerp(v1.y,v2.y,amt)
    z = cosineLerp(v1.z,v2.z,amt**2)
    return PVector(x,y,z)
def cosineLerp(y1,y2,mu):
    mu2 = (1-cos(mu*PI))/2
    return y1*(1-mu2)+y2*mu2
def drawMesh(lines):
    strokeWeight(1)
    for i in range(len(lines)-1):
        wave = 1.0*i/(len(lines)-2)
        with beginShape(QUAD_STRIP):
            for index,j in enumerate(zip(lines[i],lines[i+1])):
                param = 1.0*index/(len(lines[i])-1)
                a = j[0]
                b = j[1]
                c1 = lerpColors(colorOptions,wave)
                fill(c1)
                vertex(a.x,a.y,a.z)
                c2 = lerpColors(colorOptions,wave+1.0/(len(lines)-2))
                fill(c2)
                vertex(b.x,b.y,b.z)
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
