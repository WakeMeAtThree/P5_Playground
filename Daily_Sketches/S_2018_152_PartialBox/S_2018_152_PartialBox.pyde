def setup():
    size(400,400,P3D)
    smooth(8)
    ortho()
def draw():
    background(0)
    
    translate(width/2,height/2)
    rotateX(PI/4)
    rotateZ(PI/4)
    #boxc(100,100,100,0)
    noStroke()
    
    index1 = floor(map(sin(0.5*millis()/1000.0),-1,1,0,len(myBox(100,100))))
    index2 = floor(map(sin(1.0*millis()/1000.0 - 12.2342),-1,1,0,len(myBox(100,100))))
    ordered = sort([index1,index2])
    with beginShape(QUAD_STRIP):
        for i in myBox(100,100)[ordered[0]:ordered[1]]:
            fill(0)
            vertex(i.x,i.y,0)
            fill(255)
            vertex(i.x,i.y,100)
flatten = lambda l: [item for sublist in l for item in sublist]

def myBox(L,W):
    points = [PVector(0,0),
              PVector(L,0),
              PVector(L,W),
              PVector(0,W),
              PVector(0,0)]
    output = [divideLine(points[index],points[index+1],14)
              for index in range(len(points)-1)]
    output = list(flatten(output))
    return output
        
def divideLine(P1,P2,n):
    output = []
    for i in range(n):
        ratio = 1.0*i/(n-1)
        output.append(PVector.lerp(P1,P2,ratio))
    return output
def boxc(L,W,H,T):
    points = [PVector(0,0),
              PVector(L,0),
              PVector(L,W),
              PVector(0,W),
              PVector(0,0)]
    with beginShape(QUAD_STRIP):
        for i in points:
            fill(lerp(255,0,T))
            vertex(i.x,i.y,0)
            fill(lerp(0,255,T))
            vertex(i.x,i.y,lerp(-H,H,T))
