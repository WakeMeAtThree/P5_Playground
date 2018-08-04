"""This is a sketch to show a possible way of sending Processing data
to a glsl sketch for rendering. In this case, it's the famous Inigo Quilez
raycasting shader example."""

def setup():
    global someShader,a,randomPoints
    size(640,360,P3D)
    noStroke()
    a = 0
    someShader = loadShader("shader.glsl","vertex.glsl")
    randomPoints = [PVector(random(1),random(1),random(1)) for i in range(50)]
def draw():
    global a
    someShader.set("iResolution", float(width), float(height));
    someShader.set("iMouse", float(mouseX), float(mouseY));
    someShader.set("iTime", millis() / 1000.0);
    for index,i in enumerate(randomPoints):
        someShader.set("Position[{}]".format(index),i);
    #someShader.set("Position[1]",PVector(0.5,sin(a),0.5));
    shader(someShader);
    rect(0,0,width,height);
    resetShader();
    box(10);
    a += 0.01;    
