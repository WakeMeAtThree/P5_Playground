def setup():
    global P1,P2,radius,radius2,a,b,res
    size(400,400,P3D)
    background(255)
    smooth(8)
    a = 0
    b = 0
    noStroke()
    radius = 25
    radius2 = 50
    res = 555
    P1 = PVector(-width/4,0,0)
    P2 = PVector(0,0,0)
    
def draw():
    global a,b,radius,P1
    lights()
    background(255)
    translate(width/2,height/2)
    rotateX(PI/4)
    #Update vals
    radius = lerp(5,55,map(sin(TWO_PI*a),-1,1,0,1))
    P1 = PVector(55*sin(TWO_PI*a)*cos(TWO_PI*a),
                 0*55*sin(TWO_PI*a)*sin(TWO_PI*a),
                 55*cos(TWO_PI*a))
    #Display spheres
    #stroke(0,10)
    #noFill()
    fill(255,50)
    with pushMatrix():
        translate(P1.x,P1.y,P1.z)
        sphere(radius)
    with pushMatrix():
        translate(P2.x,P2.y,P2.z)
        sphere(radius2)
    
    #Move points
    t = a
    mP1 = movePoint(P2,radius2,a,a+1.25)
    mP2 = movePoint(P2,radius2,a,a+1.25)
    
    with pushStyle():
        stroke(0)
        strokeWeight(10)
        point(mP1.x,mP1.y,mP1.z)
        point(mP2.x,mP2.y,mP2.z)
    
    #Create Line
    multiplier = 2.0
    linePoints = [PVector.lerp(movePoint(P1,radius2, a+multiplier*i/res, a+multiplier*i/res+1.25),
                               movePoint(P2,radius2, a+multiplier*i/res, a+multiplier*i/res+1.25),
                               1.0*i/(res-1)) for i in range(res)]
    
    with pushStyle():
        noFill()
        stroke(0)
        with beginShape():
            for i in linePoints:
                vertex(i.x,i.y,i.z)
    
    #Disturb Line
    print(rad(1,2,3))
    print(theta(1,2,3))
    print(phi(1,2,3))
    
    a += 0.01

def movePoint1(vec,t):
    return vec.copy().add(PVector(radius*cos(TWO_PI*t+0.5),radius*sin(TWO_PI*t+0.5)))

def movePoint2(vec,t):
    return vec.copy().add(PVector(radius2*cos(TWO_PI*t),0,radius2*sin(TWO_PI*t)))

def movePoint(vec,radius,a,b):
    return vec.copy().add(PVector(radius*sin(TWO_PI*a)*cos(TWO_PI*b),
                                  radius*sin(TWO_PI*a)*sin(TWO_PI*b),
                                  radius*cos(TWO_PI*a)))

def rad(x, y, z): return sqrt(x**2+y**2+z**2)
def theta(x, y, z): return acos(z/rad(x,y,z))
def phi(x, y, z): return atan2(y,x);

def Plerp(v1, v2, a):
    radius1 = rad(v1.x,v1.y,v1.z)
    theta1 = theta(v1.x,v1.y,v1.z)
    phi1 = phi(v1.x,v1.y,v1.z)
    
    radius2 = rad(v2.x,v2.y,v2.z)
    theta2 = theta(v2.x,v2.y,v2.z)
    phi2 = phi(v2.x,v2.y,v2.z)
    
    r = lerp(radius1,radius2,a)
    thetaf = lerp(theta1,theta2,a)
    phif = lerp(phi1,phi2,a)
    
    blended = PVector(r*sin(thetaf)*cos(phif),
                    r*sin(thetaf)*sin(phif),
                    r*cos(thetaf));
    return blended

class PointR(object):
    def __init__(self,pos,radius):
        self.pos = pos
        self.radius = radius
    def movePoint(self,a,b):
        theta = lerp(0,PI,a%1.0)
        phi = lerp(0,TWO_PI,b%1.0)
        return self.pos.copy().add(PVector(self.radius*sin(TWO_PI*theta)*cos(TWO_PI*phi),
                                           self.radius*sin(TWO_PI*theta)*sin(TWO_PI*phi),
                                           self.radius*cos(TWO_PI*theta)))
    def display(self,a,b):
        vec = self.movePoint(a,b) 
        with pushStyle():
            stroke(0)
            with pushMatrix():
                translate(vec.x,
                         vec.y,
                         vec.z)
                sphere(5)
    def displaySphere(self):
        with pushStyle():
            #noStroke()
            #fill(255,50)
            noFill()
            stroke(0,50)
            with pushMatrix():
                translate(self.pos.x,
                          self.pos.y,
                          self.pos.z)
                sphere(self.radius)
