def setup():
    global a, initial, target
    size(400,400)
    a = 0
    initial = [PVector(random(width),random(height)) for i in range(5)]
    target = [PVector(random(width),random(height)) for i in range(100)]
    noFill()
    
def draw():
    global a
    background(255)
    blended = lerpUnequal(initial,target,map(sin(a),-1,1,0,1))
    with beginShape():
        for i in blended:
            vertex(i.x,i.y)
            stroke(255,0,0)
            point(i.x,i.y)
            
        
    a += 0.01

def lerpUnequal(init,target,amt):
    maxLength = max(len(init),len(target))
    return [PVector.lerp(init[i%len(init)],
                         target[constrain(i,0,len(target)-1)],
                         amt) for i in range(maxLength)]
