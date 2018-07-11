class Curve(object):
    def __init__(self, someCurve):
        self.vertices = [someCurve.getChild(0).getVertex(i) for i in range(someCurve.getChild(0).getVertexCount())]
        #self.vertices = [PVector(0,5,0),PVector(1,3,0),PVector(1,4,7)]
        # self.vertices = some

a = 0
def setup():
    size(400,400)
    global states,vertices
    
    crv1 = Curve(loadShape("11.svg"))
    crv2 = Curve(loadShape("21.svg"))
    crv3 = Curve(loadShape("31.svg"))
    
    states = [crv1,crv2,crv3]
    vertices = [i.vertices for i in states]
    noStroke()

def draw():
    background(255)
    global a
    
    #Dynamic Weights
    weights = [smoothperiodic(a),
               map(sin(5*a),-1,1,0,1),
               smoothperiodic(a+PI/2)]
    
    #Static Weights
    # weights = [0,
    #            1,
    #            0]
    
    #Normalize weights
    #weights = [map(i,min(weights),max(weights),0,1) for i in weights]
    
    #Normalize sum
    weights = [i/sum(weights) for i in weights]
    fill(255,0,0)
    translate(width/2,height/2)
    scale(6)
    beginShape()
    for i in averageCurve(vertices,weights,a):
        vertex(i.x,i.y)
    endShape(CLOSE)
    a += 0.1

def averageCurve(vertices, weights,a):
    """Takes a list of vertices and corresponding weights
    and returns the list of vertices resulting from the 
    weighted average"""
    
    weightedCurve = [[PVector.mult(j,i[0]) for j in i[1]] 
                                  for i in zip(weights,vertices)]
    
    average = [averageVertices(i,weights,a) for i in zip(*weightedCurve)]
    
    return average

def averageVertices(pointsList,weights,a):
    output = PVector(0.0,0.0,0.0)
    count = 1
    for i in pointsList:
        param = 5.0 * count/len(pointsList)
        output = PVector.add(output,i)
        count+=1
    return PVector.mult(output,sum(weights))

def smoothstep(edge0, edge1, x):
    # Scale, bias and saturate x to 0..1 range
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    # Evaluate polynomial
    return x * x * (3 - 2 * x)

def smoothperiodic(time):
    return smoothstep(0.2,0.8,map(sin(time),-1,1,0,1));