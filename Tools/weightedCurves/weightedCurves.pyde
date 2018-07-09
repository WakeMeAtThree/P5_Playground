class Curve(object):
    def __init__(self):
        self.vertices = [PVector(0,5,0),PVector(1,3,0),PVector(1,4,7)]

crv1 = Curve()
crv2 = Curve()
crv3 = Curve()
weights = [0,1,2]
states = [crv1,crv2,crv3]

def setup():
    size(400,400)
    vertices = [i.vertices for i in states]

    print(averageCurve(vertices,weights))
    #print(zip(*[i.vertices for i in states]))

def draw():
    background(255)

def averageCurve(vertices, weights):
    """Takes a list of vertices and corresponding weights
    and returns the list of vertices resulting from the 
    weighted average"""
    
    weightedCurve = [[PVector.mult(j,i[0]) for j in i[1]] 
                                  for i in zip(weights,vertices)]
    
    average = [averageVertices(i) for i in zip(*weightedCurve)]
    
    return average

def averageVertices(pointsList):
    output = PVector(0.0,0.0,0.0)
    for i in pointsList:
        output = PVector.add(output,i)
    return PVector.mult(output,1.0/len(pointsList))
