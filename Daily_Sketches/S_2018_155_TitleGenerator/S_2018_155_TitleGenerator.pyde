from random import choice 
def setup():
    global title,a,b,c
    size(400,400)
    a = ["Improv","Recreate","Nature","Evolution","Networks","Poetic","Movable","Locomotion","Spaces","Structures","Glitches","Chaotic"]
    b = ["on","of","in","the","from","to","and","for"]
    c = ["Code", "Past", "Type","Design"]+a
    title = "{} {} {} {}".format(choice(a),choice(b),choice(c),choice(c))
    textAlign(CENTER,CENTER)
    textSize(25)
    
def draw():
    background(255)
    fill(0)
    text(title,width/2,height/2)
def keyPressed():
    global title
    if(key == ' '):
        title = "{} {} {} {}".format(choice(a),choice(b),choice(c),choice(c))
    if(key == 's'):
        pass 
    
