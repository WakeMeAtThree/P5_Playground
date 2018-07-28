def setup():
    global pointSet,a
    size(400,400)
    a = 0
    pointSet = [PVector(random(width),random(height)) for i in range(15)]
    
def draw():
    global a
    background(255)
    strokeWeight(5)
    stroke(255,0,0)
    for i in pointSet:
        point(i.x,i.y)
    blendpoint = lerpVectors(sin(a),pointSet)
    strokeWeight(10)
    stroke(0)
    point(blendpoint.x,blendpoint.y)
    a += 0.01
    
def lerpVectors(amt, vecs):
    if(len(vecs) == 1):
        return vecs[0]
    spacing = 1.0/(len(vecs)-1)
    lhs = floor(amt/spacing);
    rhs = ceil(amt/spacing);
    
    try:
        return PVector.lerp(vecs[lhs], vecs[rhs], amt%spacing/spacing)
    except:
        return PVector.lerp(vecs[constrain(lhs, 0, vecs.length-2)], vecs[constrain(rhs, 1, vecs.length-1)], amt)
    