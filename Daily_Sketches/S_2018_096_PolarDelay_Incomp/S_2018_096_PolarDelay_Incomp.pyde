def setup():
    global res,P1,P2
    size(400,400,P3D)
    background(255)
    

    
    strokeWeight(3)
    #point(P1.x,P1.y)
    #point(P2.x,P2.y)
    res = 55
    
def draw():
    background(255)
    P1 = PVector(0.1,0.1)
    P2 = PVector(mouseX+0.1,mouseY+0.1)
    path = [Plerp(P1,P2,1.0*i/(res-1)) for i in range(res)]
    
    with beginShape():
        for i in path:
            point(i.x,i.y)
def radius(x, y, z): return sqrt(x**2+y**2+z**2)
def theta(x, y, z): return acos(z/radius(x,y,z))
def phi(x, y, z): return atan2(y,x);

def Plerp(v1, v2, a):
    radius1 = radius(v1.x,v1.y,v1.z)
    theta1 = theta(v1.x,v1.y,v1.z)
    phi1 = phi(v1.x,v1.y,v1.z)
    
    radius2 = radius(v2.x,v2.y,v2.z)
    theta2 = theta(v2.x,v2.y,v2.z)
    phi2 = phi(v2.x,v2.y,v2.z)
    
    r = lerp(radius1,radius2,a)
    thetaf = lerp(theta1,theta2,a)
    phif = lerp(phi1,phi2,a)
    
    blend = PVector(r*sin(thetaf)*cos(phif),
                    r*sin(thetaf)*sin(phif),
                    r*cos(thetaf));
    return blend
    
