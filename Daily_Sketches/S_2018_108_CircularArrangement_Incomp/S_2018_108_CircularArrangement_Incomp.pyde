def setup():
    global n,c
    size(1000,1000)
    noStroke()
    #n = 800
    c = 4
        
    translate(width/2,height/2)
    for n in range(800,3000):
        a = n * radians(137.5)
        r = c * sqrt(n)
    

        newPoint = PVector(r*cos(a),
                           r*sin(a))
        fill(lerpColor("#FF0000","#1100FF",(a%TWO_PI)/TWO_PI))
        ellipse(newPoint.x,newPoint.y,5,5)


def draw():
    global n
    pass
    #n+=1
    
    