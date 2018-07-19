a = 0
scl = 500
X = 5
Y = 5

def setup():
    global M
    size(400,400,P3D)
    blendMode(EXCLUSION)
    ellipseMode(CORNER)
    ortho()
    M = Matrix(X,Y)

def draw():
    global a,M
    background(0)
    
    M.displayH()
    #M.displayV()
    #M.displayU()
    #M.display()
    a += 0.01

class Matrix(object):
    def __init__(self, X, Y):
        pass
    def module(self,X,Y,W,H):
        """This function is where you'll keep your module. Keep in mind that this is
        considering the display in CORNER mode.
        """
        ellipse(X,Y,W,H)
    def getMatrix(self):
        return [[noise(scl*i,scl*j,a) for j in range(X)] for i in range(Y)]
    def displayH(self):
        """Equal spaced Y, dynamic X"""
        Matrix = self.getMatrix()
        Matrix = [normalizeList(i,width) for i in Matrix]
        shiftY = 0
        spaceY = 1.0*height/Y
        for row in Matrix:
            shiftX = 0
            for i in row:
                self.module(shiftX,shiftY,i,spaceY)
                shiftX += i
            shiftY += spaceY
    def displayV(self):
        """Equal spaced X, dynamic Y"""
        Matrix = self.getMatrix()
        Matrix = [normalizeList(i,height) for i in Matrix]
        shiftX = 0
        spaceX = 1.0*width/X
        for row in Matrix:
            shiftY = 0
            for i in row:
                self.module(shiftX,shiftY,spaceX,i)
                shiftY += i
            shiftX += spaceX
    def displayU(self):
        """Unequal spaced Y, dynamic X"""
        Matrix = self.getMatrix()
        Matrix = [normalizeList(i,width) for i in Matrix]
        shiftY = 0
        spaceY = [noise(scl*i+a+25334) for i in range(Y)]
        spaceY = normalizeList(spaceY,height)
        for row in Matrix:
            shiftX = 0
            val = spaceY.pop(0)
            for i in row:
                self.module(shiftX,shiftY,i,val)
                shiftX += i
            shiftY += val
    def display(self):
        """Dynamic Y, dynamic X"""
        Matrix = self.getMatrix()
        Matrix = [normalizeList(i,width) for i in Matrix]
        shiftY = 0
        spaceY = [[noise(scl*i+a+25334,scl*j+a+25334) for j in range(X)] for i in range(Y)]
        spaceY = [normalizeList(row,height) for row in spaceY]
        shiftY = [0 for i in range(X)]
        for row in Matrix:
            shiftX = 0
            someValues = spaceY.pop(0)
            
            count = 0
            for j,i in zip(shiftY,row):
                val = someValues.pop(0)
                self.module(shiftX,j,i,i)
                shiftX += i
                shiftY[count] += val
                count+=1
            
def normalizeList(alist,multiply): return [1.0*multiply*i/(sum(alist)+0.0001) for i in alist]