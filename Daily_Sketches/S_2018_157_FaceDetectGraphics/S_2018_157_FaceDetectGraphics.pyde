add_library('video')
add_library('opencv_processing')

video = None
opencv = None
show_fps = False

def setup():
    global opencv,video,a,lastpos
    lastpos = PVector(width/2,height/2)
    size(480, 480)
    video = Capture(this, 640 / 2, 480 / 2)
    opencv = OpenCV(this, 640 / 2, 480 / 2)
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE)
    video.start()
    frameRate(12)
    a = 0

def draw():
    global a,lastpos
    
    scale(2)
    opencv.loadImage(video)
    image(video, 0, 0)
    noFill()
    stroke(0, 255, 0)
    strokeWeight(3)
    faces = opencv.detect()
    a = constrain(a,0,1)
    
    if len(faces)>0:
        translate(faces[0].x,faces[0].y)
        scale(lerp(1,2,a**2))
        translate(-faces[0].x,-faces[0].y)
        lastpos = PVector(faces[0].x,faces[0].y)
        #image(video, 0, 0)
        a += 0.2
    else:
        translate(lastpos.x,lastpos.y)
        scale(lerp(1,2,a**12))
        translate(-lastpos.x,-lastpos.y)
        a -= 0.1
    image(video, 0, 0)
    for face in faces:
        #rect(face.x, face.y, face.width, face.height)
        p1,p2,p3,p4 = [PVector(face.x+20,face.y+25),
                       PVector(face.x+face.width-20,face.y+25),
                       PVector(face.x+face.width/2.0,face.y+face.height/2.0),
                       PVector(face.x+face.width/2.0,face.y+face.height/2.0)]
        line(p1.x,p1.y,p3.x,p3.y)
        line(p2.x,p2.y,p3.x,p3.y)
        ellipse(p1.x,p1.y,15,15)
        ellipse(p2.x,p2.y,15,15)
        ellipse(p3.x,p3.y,20,20)
        ellipse(p4.x,p4.y,20,20)
    
    if show_fps:
        text("%d fps" % frameRate, 20, 20)
    if len(faces)>0:
        print("hhahaha")
    else:
        print("noooooo")


def captureEvent(c):
    c.read()

def mousePressed():
    global show_fps
    show_fps = not show_fps
