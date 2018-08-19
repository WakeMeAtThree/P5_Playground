def setup():
    size(400,400)
    ellipseMode(CORNER)

    # First grid direction
    Yn = 5
    Y = [ i for i in range(1,Yn+1) ]
    Y = normalizeList(Y,height)
    Ypos = sumPrev(Y)

    # Second grid direction
    Xn = 5
    M = getMatrix(Xn,Yn,width,0.5)
    Mpos = getPositions(M)
    
    for index,i in enumerate(zip(Y,Ypos)):
        Height = i[0]
        YPosition = i[1]
        for Width,XPosition in zip(M[index],Mpos[index]):
            rect(XPosition,YPosition,
                 Width,Height)
            
# 1D Grid
def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]
def sumPrev(alist): return [0]+[sum(alist[:index+1]) for index,i in enumerate(alist)][:-1]

# 2D Grid
def getMatrix(X,Y,W=400,chance=None):
    if(chance is None):
        M = [[1 for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
        
    else:
        M = [[0 if random(1) > chance else 1 for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
    return M

def getPositions(M):
    return [sumPrev(i) for i in M]
