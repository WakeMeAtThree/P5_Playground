def setup():
    size(400,400)
    #translate(width/2,height/2)
    ellipseMode(CORNER)

def draw():
    background(0)
    randomValuesY = [i for i in range(int(random(100)))]
    randomValuesY = sorted([1.0*height*i/sum(randomValuesY) for i in randomValuesY])
    shiftY = 0
    for j in randomValuesY:
        randomValues = sorted([i for i in range(10)])
        randomValues = [1.0*width*i/sum(randomValues) for i in randomValues]
        shiftX = 0
        for i in randomValues:
            ellipse(shiftX,shiftY,i,j)
            shiftX += i
        shiftY += j
    noLoop()
    