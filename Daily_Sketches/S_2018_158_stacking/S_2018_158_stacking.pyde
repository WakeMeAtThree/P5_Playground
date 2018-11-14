add_library('fisica')

def setup():
    global world, circleCount,hole,topMargin,bottomMargin,sideMargin,xPos
    size(400, 400);
    smooth();
    
    Fisica.init(this);
    Fisica.setScale(4);
    world = FWorld();
    world.setGravity(0, 300);
    world.setEdges()

def draw():
    background(255);
    if (frameCount % 100 == 0):
        b = FBlob();
        s = random(30, 40);
        x = width/2;
        y = 0;
        num = 55
        for i in [lerpVectors(getPoints(x,y,width/3,15),1.0*i/(num-1)) for i in range(num)]:
            b.vertex(i.x,i.y)
        
        b.setVertexSize(4);
        b.setBullet(True);
        b.setNoStroke()
        b.setFill(random(255));
        b.setFrequency(1255)
        b.setDamping(1255)
        world.add(b);
    
    world.step();
    world.draw();
    
def getPoints(x,y,l,w):
    return [PVector(x,y),
            PVector(l+x,0+y),
            PVector(l+x,w+y),
            PVector(x,w+y)]
def lerpVectors(vecs, amt):
    if(len(vecs)==1): return vecs[0]
    
    spacing = 1.0/(len(vecs)-1);
    lhs = floor(amt / spacing);
    rhs = ceil(amt / spacing);
    
    try:
        return PVector.lerp(vecs[lhs], vecs[rhs], amt%spacing/spacing);
    except:
        return PVector.lerp(vecs[constrain(lhs, 0, len(vecs)-2)], vecs[constrain(rhs, 1, len(vecs)-1)], amt);
