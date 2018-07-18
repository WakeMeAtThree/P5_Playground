def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]

a

def setup():
    size(400,400)
    #translate(width/2,height/2)
    ellipseMode(CORNER)
    row = normalizeList([i for i in range(5)],width)
    col = normalizeList([j for j in range(5)],height)
    #Matrix = [(i,j) for i in row for j in col]
    Matrix = [normalizeList([j+i for j in range(5)],width) for i in range(5)]
    print(Matrix)

def draw():
    background(0)
    Y = [sin(a),sin(a+3.4),sin(a)+sin(4*a+0.24),sin(0.5*a)]
    Y = normalizeList(Y,height)
    # shiftY = 0
    # for j in Y:
    #     X = [i for i in range(5)]
    #     X = normalizeList(X,width)
    #     shiftX = 0
    #     for i in X:
    #         ellipse(shiftX,shiftY,i,j)
    #         shiftX += i
    #     shiftY += j
    shiftX = 0
    for i in Y:
        ellipse(shiftX,0,i,50)
    a+=0.1
    noLoop()

    