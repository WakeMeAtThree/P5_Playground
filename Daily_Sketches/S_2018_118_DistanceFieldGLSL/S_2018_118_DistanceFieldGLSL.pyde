
def setup():
    global someShader,ballList,a,curvePoints
    global a,n,ellipsePositions,spaceX,cPoints,resolution,interpolations
    size(400,400,P3D)
    noStroke()
    someShader = loadShader("shader.glsl")

    a = 0
    ############################
    
    X = 55
    Y = 55
    a = 0
    resolution = 500

    spaceX = 1.0*width/X
    spaceY = 1.0*height/Y
    
    ellipsePositions = [PVector(i*spaceX,j*spaceY) for i in range(X+1) for j in range(Y+1)]
    n = 7
    curvePoints = [PVector(1.0*i*width/n,random(height)) for i in range(n+1)]
    interpolations = [lerpVectors(curvePoints,
                                  1.0*i/(resolution-1)) for i in range(resolution)]
    
def draw():
    global a
    cPoints = [PVector(i.copy().x,
                       i.copy().y+height*sin(a+15.0*index/n)) for index,i in enumerate(curvePoints)]
    interpolations = [lerpVectors(cPoints,
                                  1.0*i/(resolution-1)) for i in range(resolution)]
    zePoints = loadPoints("points.csv")
    try:
        someShader = loadShader("shader.glsl")
    except:
        resetShader()
    someShader.set("iResolution", float(width), float(height));
    someShader.set("iMouse", float(mouseX), height-float(mouseY));
    someShader.set("iTime", millis() / 1000.0);
    #someShader.set("locations[0]",float(width)/2.0, float(height)/2.0);    # for index,p in enumerate(getPositions(ballList)):
    for index,i in enumerate(zePoints):
        someShader.set("locations[{}]".format(index),i.x,height-i.y)

    shader(someShader);
    rect(0,0,width,height);
    a+=0.1

def getPositions(ballList):
    output = []
    for i in ballList:
        output.append(PVector(i.pos.x,i.pos.y))
    return output

def cosineLerpVec(v1,v2,amt):
    x = lerp(v1.x,v2.x,amt)
    y = cosineLerp(v1.y,v2.y,amt)
    return PVector(x,y)
def cosineLerp(y1,y2,mu):
    mu2 = (1-cos(mu*PI))/2
    return y1*(1-mu2)+y2*mu2

def lerpVectors(vecs, amt):
    if(len(vecs)==1): return vecs[0]
    
    spacing = 1.0/(len(vecs)-1);
    lhs = floor(amt / spacing);
    rhs = ceil(amt / spacing);
    
    try:
        return cosineLerpVec(vecs[lhs], vecs[rhs], amt%spacing/spacing);
    except:
        return cosineLerpVec(vecs[constrain(lhs, 0, len(vecs)-2)], vecs[constrain(rhs, 1, len(vecs)-1)], amt);

def smoothstep(edge0, edge1, x):
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0); 
    return x * x * (3 - 2 * x);

def loadPoints(fname):
    with open(fname) as f:
        content = f.readlines()
    data = [i.replace('\n','')[1:][:-1].split(',') for i in content]
    data = [PVector(*map(float,i)) for i in data]
    data = [PVector(i.x,-i.y+height) for i in data]
    return data
