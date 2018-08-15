def setup():
    size(400,400)
    background(255)
    noFill()
    rectMode(CENTER)
    
    X = 25
    Y = 25
    
    spaceX = 1.0*width/X
    spaceY = 1.0*height/Y
    
    ellipsePositions = [PVector(i*spaceX,j*spaceY) for i in range(X+1) for j in range(Y+1)]
    n = 4
    curvePoints = [PVector(1.0*i*width/n,random(height)) for i in range(n+1)]
    resolution = 50
    interpolations = [lerpVectors(curvePoints,
                                  1.0*i/(resolution-1)) for i in range(resolution)]
    # Get distances
    distances = []
    for i in ellipsePositions:
        d = []
        
        # Get all distances to curve points
        for j in interpolations:
            d.append(PVector.dist(i,j))
        
        # Get minimum distance (closest point to curve)
        distances.append(min(d))
    
    # Normalize distances for later scaling
    distNormed = [ map(i,min(distances),max(distances),0.0,1.0)
                   for i in distances ]
    # Display curve
    with beginShape():
        for i in interpolations:
            vertex(i.x,i.y)
    
    # Display ellipses
    for i,j in zip(distNormed,ellipsePositions):
        diameter = i*spaceX
        with pushStyle():
            fill(0)
            ellipse(j.x,j.y,diameter,diameter)
        rect(j.x,j.y,spaceX,spaceX)
    
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
