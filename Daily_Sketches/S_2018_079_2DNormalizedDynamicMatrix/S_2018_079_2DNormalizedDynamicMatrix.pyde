a = 0
randomX = [random(1) for i in range(15)]
randomY = [random(1) for i in range(15)]

def setup():
    size(400,400)
    noStroke()    
    ellipseMode(CORNER)
    rectMode(CORNER)
    
    row = normalizeList([i for i in range(5)],width)
    col = normalizeList([j for j in range(5)],height)
    
    
    

def draw():
    global a,toggle
    background(0)
    Y = [sin(a+randomY[i]) for i in range(5)]
    Y = [map(i,-1,1,0.1,1) for i in Y]
    Y = normalizeList(Y,height)
    shiftY = 0
    
    for j in Y:
        param = [0,0]
        X = [sin(a++randomX[i]) for i in range(5)]
        X = [map(i,-1,1,0,1) for i in X]
        X = normalizeList(X,width)
        shiftX = 0
        
        for i in X:
            ellipse(shiftX,shiftY,i-5,j-5)
            shiftX += i
            param[0] += 1
        
        
        shiftY += j
        param[1] += 1
    a += 0.01

def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]