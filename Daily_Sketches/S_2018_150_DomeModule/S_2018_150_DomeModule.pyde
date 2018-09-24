def setup():
    global colorOptions
    size(400,400,P3D)
    smooth(8)
    ortho();
    section = circSection(100)
    colorOptions = ["#000000",
                    "#FFFFFF"]
    #translate(width/2,height/2)
    
    rotateX(PI/3);
    noStroke();
    dome(width/2,height/2,50)
    
def circSection(radius):
    section = []
    res = 10
    #radius = 50
    for i in range(res-2):
        ratio = 0.5*i/(res-1)
        section.append(
                PVector(radius*cos(ratio*PI),
                        radius*sin(ratio*PI),
                        0)
                )
    return section

def dome(X,Y,radius):
    section = circSection(radius)
    with pushMatrix():
        translate(X,Y)
        rotateX(PI/2)
        drawMesh(zip(*revolve(section)))
def revolve(section):
    res = 45
    output = [ [vec_rotateY(i,TWO_PI*j/(res-1)) for i in section]
                for j in range(res)]
    return output

def vec_rotateY( v, angle):
    x = v.x*cos(angle)+v.z*sin(angle)
    y = v.y
    z = -v.x*sin(angle)+v.z*cos(angle)
    return PVector(x,y,z)

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
