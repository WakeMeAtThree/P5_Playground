def setup():
    global n,c,colorOptions,particles
    size(600,600)
    background(255)
    noStroke()
    particles = []
    
    #Colorpicked hex values from image
    colorOptions = ['#836871',
                    '#6d1a34',
                    '#af2944',
                    '#e94442',
                    '#e8af58',
                    '#ac7ead',
                    '#888f9f',
                    '#388c8c',
                    '#836871'][::-1]
    
    #Setup initial phyllotaxis positions
    c = 4
    angle=137.5
    for n in range(1000,1500):
        a = n * radians(angle)
        r = c * sqrt(n)
    

        newPoint = PVector(r*cos(a),
                           r*sin(a))
        newColor = lerpColors((a%TWO_PI)/TWO_PI,colorOptions) 
        particles.append(particle(newPoint,newColor))

def draw():
    background(255)
    
    #Move origin to center
    translate(width/2,height/2)
    
    for p in particles:
        
        #Check for collisions (inefficent)
        for other in particles:
            if(p!=other):
                d = PVector.dist(p.pos,other.pos)
                if(d <= p.r + other.r + 4):
                    p.moveAwayFrom(other)
        
        #Display and move particles
        p.display()
        p.move()
    
def lerpColors(amt, colorOptions):
    """Lerp function that takes an amount between 0 and 1, 
    and a list of colors and returns the appropriate
    interpolation"""
    
    if (len(colorOptions)==1): return colorOptions[0]
    spacing = 1.0/(len(colorOptions)-1)
    lhs = floor(amt/spacing)
    rhs = ceil(amt/spacing)
    
    try:
        return lerpColor(colorOptions[lhs], 
                         colorOptions[rhs], 
                         amt%spacing/spacing)
    except:
        return lerpColor(colorOptions[constrain(lhs, 0, len(colorOptions)-2)], 
                         colorOptions[constrain(rhs, 1, len(colorOptions)-1)], 
                         amt);
class particle(object):
    def __init__(self,pos,someColor):
        self.pos = pos
        self.someColor = someColor
        self.r = 2.5
    def move(self):
        """Move towards origin"""
        d = PVector.dist(self.pos,PVector(0,0))
        centerRadius = 100
        if(d <= self.r + centerRadius):
            direction = PVector.sub(PVector(0,0,0),self.pos).normalize().mult(-0.5)
        else:
            direction = PVector.sub(PVector(0,0,0),self.pos).normalize().mult(0.5)
        
        
        self.pos.add(direction)
    def moveAwayFrom(self,other):
        direction = PVector.sub(other.pos,self.pos).normalize().mult(-1)
        self.pos.add(direction)
    def display(self):
        noStroke()
        fill(self.someColor)
        ellipse(self.pos.x,self.pos.y,self.r*2,self.r*2)
