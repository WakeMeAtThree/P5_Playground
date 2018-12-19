# Useful code snippets

I find myself returning to a lot of repeated code, and so I've decided to compile it here for easier accessibilty, rather than going through my sketches one by one to sift through what I need. This will range in areas from some useful functions for github maintenance to shaders, to processing, and whatever else I use on the regular.

## Drawing tools and custom shapes

### Hi Res Prints and Saving/Reusing Random Seeds

[Print](https://processing.org/tutorials/print/) + Custom code for saving/reusing seeds.

### Tranformation matrices
[Tranformation Matrix wiki articke](https://en.wikipedia.org/wiki/Transformation_matrix). Also, [3b1b video on quarternions](https://www.youtube.com/watch?v=d4EgbgTm0Bg).

```python
def myRect(X,Y,L,W,angle):
    points = [PVector(-L/2.0,W/2.0),
              PVector(L/2.0,W/2.0),
              PVector(L/2.0,-W/2.0),
              PVector(-L/2.0,-W/2.0),
              PVector(-L/2.0,W/2.0)]
    points = [rotate_Z(i,angle) for i in points]
    points = [i.add(PVector(X,Y)) for i in points]
    return points

# Make both similar syntax

def rotate_Y( v, angle):
    x = v.x*cos(angle)+v.z*sin(angle)
    y = v.y
    z = -v.x*sin(angle)+v.z*cos(angle)
    return PVector(x,y,z)

def rotate_Z(p,angle):
    rP = PVector(p.x*cos(angle)-p.y*sin(angle),
                 p.x*sin(angle)+p.y*cos(angle),
                 p.z)
    return rP
```

### Revolve

```python
def dome(X,Y,radius):
    section = circSection(radius)
    with pushMatrix():
        translate(X,Y)
        rotateX(PI/2)
        drawMesh(zip(*revolve(section)))
def revolve(section):
    res = 45
    output = [ [vec_rotateY(i,TWO_PI*j/(res-1)) for i in section]
                for j in range(res)]
    return output
```

### Catenary curve
~Useful source for drawing a catenary curve: http://mathworld.wolfram.com/Catenary.html (note to self: prep cycloid curve as well).~ Will be using a solver like fisica for this, but I need to define an `orient(geom,a,b)` function (CENTER, CORNER, CORNERS) modes:

```python
def orient(geom,a,b):
    pass
```

### Generate points between two points
This function will take two points and return a specified number of points.
```python
def drawLine(p1,p2,res):
    return [PVector.lerp(p1,
                         p2,
                         1.0*i/(res-1)) for i in range(res)]
                         
```
### Mesh strips
This function will take a list of "curves", where a single curve is essentially a list of points, and will draw a QUAD_STRIP through them all. Has some left over coloring strategies, but you can ignore it if you don't need it.

```python
def drawMesh(lines):
    strokeWeight(1)
    for i in range(len(lines)-1):
        wave = 1.0*i/(len(lines)-2)
        with beginShape(QUAD_STRIP):
            for index,j in enumerate(zip(lines[i],lines[i+1])):
                param = 1.0*index/(len(lines[i])-1)
                a = j[0]
                b = j[1]
                c1 = lerpColors(colorOptions,wave)
                fill(c1)
                vertex(a.x,a.y,a.z)
                c2 = lerpColors(colorOptions,wave+1.0/(len(lines)-2))
                fill(c2)
                vertex(b.x,b.y,b.z)
```


### Load external obj meshes in processing
I like to have a bit more control on the individual vertices in a mesh, hence why I made a class for it. There are better ways to do this, but for me this helps me achieve a certain kind of morph that I'm going for. 
```python
class Mesh(object):
    def __init__(self, obj):
        self.obj = obj
        self.vertices = []
        self.faces = []
        
        for i in range(obj.getChildCount()):
            for j in range(obj.getChild(i).getVertexCount()):
                v = obj.getChild(i).getVertex(j)
                self.vertices.append(v)
                
        
        for i in range(obj.getChildCount()):
            faceindex = []
            for j in range(obj.getChild(i).getVertexCount()):
                v = obj.getChild(i).getVertex(j)
                faceindex.append(self.vertices.index(v))
            self.faces.append(faceindex)
    def morph(self,initial,target,a):
        self.vertices = [PVector.lerp(i,j,map(cs(TWO_PI*a),-1,1,0,1)) for i,j in zip(initial.vertices,target.vertices)]
    def display(self, a,someScene):
        someScene.noStroke()
        someScene.beginShape(QUADS)
        for index,i in enumerate(self.faces):
            param = 1.0 * index/len(self.faces)
            for j in i:
                someScene.fill(lerpColor("#0EC0E1", "#DD3A7C",0.5*map(cs(TWO_PI*a), -1, 1, 0, 1)+0.5*map(cs(TWO_PI*a+1.5), -1, 1, 0, 1)))
                vec = self.vertices[j]
                someScene.vertex(vec.x,vec.y,vec.z)
        someScene.endShape() 
```

### Custom box with per-vertex coloring
```python
def boxc(L,W,H,T):
    points = [PVector(0,0),
              PVector(L,0),
              PVector(L,W),
              PVector(0,W),
              PVector(0,0)]
    with beginShape(QUAD_STRIP):
        for i in points:
            fill(lerp(255,0,T))
            vertex(i.x,i.y,0)
            fill(lerp(0,255,T))
            vertex(i.x,i.y,lerp(-H,H,T))
```

### Custom box with adjustable face colors class
Use this [color generator](https://coolors.co/) as well for inspiration.

```python
def setup():
    size(400,400,P3D)
    smooth(8)
    ortho()
    translate(width/2,height/2)
    rotateX(PI/4)
    rotateZ(PI/4)
    noStroke()
    
    Box1 = myBox("#a66b0f","#bfab93","#496676")
    Box2 = myBox("#674f24","#bd9e7f","#891902")
    Box3 = myBox("#0a88b1","#c8c6b4","#c8c6b4")
    Box4 = myBox("#c6b89c","#922317","#cdb697")
    Box5 = myBox("#aa2e22","#759999","#2f3e5d")
    Box6 = myBox("#eae4d6","#f3d74f","#b1080f")
    Box7 = myBox("#82a8cd","#687cc1","#fd67b1","#f5e5ff")
    colors1 = ["#9b6f95","#c39194","#edc39d","#f2d19e"][::]
    colors2 = ["#85b289","#a8c48a","#cfd18f","#edd88e"][::-1]
    colors3 = ["#ef9e90","#d0a499","#99a6ac","#6cc1c4"][::]
    colors4 = ["#f17479","#cb7487","#b092b6","#6da6c4"][::]
    colors5 = ["#f17479","#cb7487","#b092b6","#6da6c4"][::]
    colors6 = ["#f4f4f4","#d480aa","#0d0f0e","#f4f4f4"][::-1]
    colors7 = ["#fab500","#d23b06","#201e1a","#eae2d4"][::-1]
    colors8 = ["#d23b06","#275d95","#201e1a","#eae2d4"][::]
    colors9 = ["#d7a23c","#c9c8b9","#c9c8b9","#282828"][::]
    Box8 = myBox(*colors1)
    #stroke("#8159af")
    Box8.display(0,0,100,100,100)

    

class myBox(object):
    def __init__(self,top,front,side,bg=0):
        self.top = top
        self.bottom = front
        self.front = front
        self.side = side
        self.bg = bg
    def displayTops(self,X,Y,L,W,H):
        background(self.bg)
        points = [PVector(0,0),
                  PVector(L,0),
                  PVector(L,W),
                  PVector(0,W),
                  PVector(0,0)]
        pairs = [(points[i],points[i+1]) for i in range(len(points)-1)]
        with pushMatrix():
            translate(X,Y)
            # Bottom
            fill(self.bottom)
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,0)
            
            # Top
            fill(self.top)
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,H)
            # Sides
            fill(self.side)
            for k in [0,2]:
                with beginShape(QUAD_STRIP):
                    for i in pairs[k]:
                        vertex(i.x,i.y,0)
                        vertex(i.x,i.y,H)
            # Sides
            fill(self.front)
            for k in [1,3]:
                with beginShape(QUAD_STRIP):
                    for i in pairs[k]:
                        vertex(i.x,i.y,0)
                        vertex(i.x,i.y,H)
    def display(self,X,Y,L,W,H):
        background(self.bg)
        points = [PVector(0,0),
                  PVector(L,0),
                  PVector(L,W),
                  PVector(0,W),
                  PVector(0,0)]
        pairs = [(points[i],points[i+1]) for i in range(len(points)-1)]
        with pushMatrix():
            translate(X,Y)
            # Bottom
            fill(self.top)
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,0)
            
            # Top
            with beginShape():
                for i in points:
                    vertex(i.x,i.y,H)
            # Sides
            fill(self.side)
            for k in [0,2]:
                with beginShape(QUAD_STRIP):
                    for i in pairs[k]:
                        vertex(i.x,i.y,0)
                        vertex(i.x,i.y,H)
            # Front
            fill(self.front)
            for k in [1,3]:
                with beginShape(QUAD_STRIP):
                    for i in pairs[k]:
                        vertex(i.x,i.y,0)
                        vertex(i.x,i.y,H)
```
### Dashed lines

```python
def dashedLine(p1,p2):
    #Play with these parameters
    res = 20
    step = 2
    
    points = [PVector.lerp(p1,
                           p2,
                           1.0*i/res) for i in range(res+1)]
    for i in range(len(points))[:-1:step]:
        v1 = points[i]
        v2 = points[i+1]
        line(v1.x,v1.y,v2.x,v2.y)
```

## Terminal Commands
### FFmpeg
The following are useful `ffmpeg` commands for making animation gifs/mp4 ~~(I should look into [gifiscle](https://www.lcdf.org/gifsicle/))~~. Also [check out this blog post](https://manerosss.wordpress.com/2016/06/29/how-to-convert-a-video-to-gif-using-ffmpeg/).

Turning image sequence to a video
```
ffmpeg -framerate 30 -i animation%3d.png -pix_fmt yuv420p output.mp4
```

Concatenating two videos to create a reverse loop
```
ffmpeg -i input.mov -filter_complex "[0:v]reverse,fifo[r];[0:v][r] concat=n=2:v=1 [v]" -map "[v]" output.mp4
```

Generating palette.png and using it to create smaller gifs. [Reference 1.](https://engineering.giphy.com/how-to-make-gifs-with-ffmpeg/) [Reference 2.](https://medium.com/@colten_jackson/doing-the-gif-thing-on-debian-82b9760a8483)
```
ffmpeg -i output.mp4 -vf palettegen palette.png
ffmpeg -i output.mp4 -i palette.png -filter_complex “fps=30,scale=400:-1:flags=lanczos[x];[x][1:v]paletteuse” output.gif
ffmpeg -ss 2.6 -t 1.3 -i output.mp4 -i palette.png -filter_complex “fps=30,scale=400:-1:flags=lanczos[x];[x][1:v]paletteuse” output.gif
```

I have compiled all of this into a simple bat file that I keep reusing under the alias `animate`.

```cmd
@echo off
cmd /k "ffmpeg -start_number 1 -framerate 30 -i animation%%3d.png -pix_fmt yuv420p output.mp4 & pause & ffmpeg -i output.mp4 -vf palettegen palette.png & pause & ffmpeg -i output.mp4 -i palette.png -filter_complex ""fps=30,scale=400:-1:flags=lanczos[x];[x][1:v]paletteuse"" output.gif"
```

I've been using scale function more often nowadays. Render to 1000x1000, then scale to 400x400:
```terminal
ffmpeg -i output.mp4 -vf scale=400:-1 out.mp4
```

### Processing
Running a processing sketch in terminal [Check this out](https://github.com/processing/processing/wiki/Command-Line):

```
processing-java --sketch=%cd% --run
```
### Git
Reseting changes in a local clone

```git
# Revert changes to modified files.
git reset --hard

# Remove all untracked files and directories. (`-f` is `force`, `-d` is `remove directories`)
git clean -fd
```

Renaming sequence of files

```python
import os

for filename in os.listdir("."):
    if(filename.startswith("Z_")):
        newName = "2018_0"+filename[2:]
        os.rename(f"{filename}",f"{newName}")
```

Table generators in markdown

- [Markdown table generator](https://www.tablesgenerator.com/markdown_tables#)
- [Another table generator](https://donatstudios.com/CsvToMarkdownTable)

Renaming my animation sequences (need to manually delete frames sometimes):

```python
import os

old = [i.split("animation")[1].split(".tga")[0] for i in os.listdir(".") if i.endswith("tga")]
new = [str(i).zfill(3) for i in range(len(old))]

oldnames = ["animation{}.tga".format(i) for i in old]
newnames = ["animation{}.tga".format(i) for i in new]

for i,j in zip(oldnames,newnames):
    os.rename(i,j)
```

## Utility

### Arabic Reshaper
Good reference [here](http://mpcabd.xyz/python-arabic-text-reshaper/). It's still an issue in Processing and other programs unfortunately and I am still resorting to manually typing unicode in some cases and using this [table for reference](https://en.wikipedia.org/wiki/Arabic_script_in_Unicode). 
### Storing trails
I first did this by appending to a list intialized with max item length and deleting the first item of the list simulataneously. Another approach is to use a `deque`:

```python
from collections import deque
trail = deque([1,2,3,4,5],maxlen=5)
```

### Accessing operator functions
Friendly reminder to use operators in classes for better code-readability (see custom Fisica class and see this [operator reference](https://docs.python.org/2/library/operator.html))

```python
class vec3(PVector):
    def __init__(self,x,y,z):
        PVector.__init__(self,x,y,z)
    def __add__(self,other):
        return PVector(self.x+other.x,
                       self.y+other.y,
                       self.z+other.z)
    def __mul__(self,other):
        if(isinstance(other,PVector)):
            return PVector(self.x*other.x,
                           self.y*other.y,
                           self.z*other.z)
        else:
            return PVector(self.x*other,
                           self.y*other,
                           self.z*other)
    def __neg__(self,other):
        other = other * -1
        return self + other
    def __div__(self,other):
        return PVector(self.x/other.x,
                       self.y/other.y,
                       self.z/other.z)
    def __pow__(self,other):
        return PVector(self.x**other,
                       self.y**other,
                       self.z**other)
```

Example: 
```python
def setup():
    size(400,400)
    a = vec3(1,2,3)
    b = vec3(4,5,6)
    print("Addition ", a + b)
    print("Multiplication ", a * b)
    print("Negation ", a * -1)
    print("Division ", a / b )
    print("Power ", a ** 2)
```

### Nodes using inheritance from a library type

```python
class node(FCircle):
    def __init__(self,r):
        FCircle.__init__(self,r)
        self.switch = False
```

I found myself doing the following as a way not having to add new objects in fisica to world at every single time.

```python
class Join(FDistanceJoint):
    def __init__(self,a,b):
        FDistanceJoint.__init__(self,a,b)
        world.add(self) 
```

### Using decorators to style drawing functions
Here's a simple example of this workflow:
```python
def style(func):
    def wrapper(*args,**kwargs):
        with pushStyle():
            strokeWeight(5)
            stroke(255,0,0)
            func(*args,**kwargs)
    return wrapper

@style
def drawLine(x1,y1,x2,y2):
    line(x1,y1,x2,y2)

def setup():
    size(400,400)
    drawLine(0,0,width,height)
```

### Flatten a list
```python
flatten = lambda l: [item for sublist in l for item in sublist]
```

### Normalizing the sum of elements in a list

```python
def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]
def sumPrev(alist): return [0]+[sum(alist[:index+1]) for index,i in enumerate(alist)][:-1]
```

Mini example:
```python
def setup():
    size(400,400)
    ellipseMode(CORNER)
    sizes = [ i for i in range(10) ]
    sizes = normalizeList(sizes,width)
    positions = sumPrev(sizes)
    for i,j in zip(positions,sizes):
        rect(i,0,j,50)
```

### Loading csv points from Grasshopper

I usually work in Rhino and find myself exporting point clouds from a Grasshopper stream to a csv file, and from there I use it in processing. Here's a snippet I wrote that I keep returning to for these things:
```python
def loadPoints(fname):
    with open(fname) as f:
        content = f.readlines()
    data = [i.replace('\n','')[1:][:-1].split(',') for i in content]
    data = [PVector(*map(float,i)) for i in data]
    return data
```

## Interpolations
### Cosine interpolation 
Note that if you're using something other than linear interpolation, make sure at one of your axes use the normal lerp, while the last axis uses your non-linear lerp.

```python
def cosineLerpVec(v1,v2,amt):
    x = lerp(v1.x,v2.x,amt)
    y = cosineLerp(v1.y,v2.y,amt)
    return PVector(x,y)
def cosineLerp(y1,y2,mu):
    mu2 = (1-cos(mu*PI))/2
    return y1*(1-mu2)+y2*mu2

def lerpVectors(vecs, amt):
    if(len(vecs)==1): return vecs[0]
    
    spacing = 1.0/(len(vecs)-1);
    lhs = floor(amt / spacing);
    rhs = ceil(amt / spacing);
    
    try:
        return cosineLerpVec(vecs[lhs], vecs[rhs], amt%spacing/spacing);
    except:
        return cosineLerpVec(vecs[constrain(lhs, 0, len(vecs)-2)], vecs[constrain(rhs, 1, len(vecs)-1)], amt);
```

### Lerping across different colors
```python
def lerpColors(colorOptions,amt):
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

```
I use the following lerp function to lerp through multiple pointsets, not just the default of two pointsets commonly used in lerps. It helps to add more layers to your work.

### Lerping through different point clouds
```python
def lerpLists(lists,amt):
    if(len(lists)==1):
        return lists[0]
    spacing = 1.0/(len(lists)-1)
    lhs = floor(amt/spacing)
    rhs = ceil(amt/spacing)
    try:
        return lerpList(lists[lhs], lists[rhs], amt%spacing/spacing)
    except:
        return lerpList(lists[constrain(lhs, 0, len(lists)-2)],
                        lists[constrain(rhs, 1, len(lists)-1)],
                        amt)
def lerpList(list1,list2,amt):
    return [PVector.lerp(i,j,amt) for i,j in zip(list1,list2)]
```

## Display tricks
### ShearZ
I like to use this so I can have a nice axonometric. This should become a processing function in addition to shearX and shearY. [Check this out](https://en.wikipedia.org/wiki/Transformation_matrix).

```python
    with pushMatrix():
        applyMatrix(  
        1.0, 0.0, 1.0,  0.0,
        0.0, 1.0, 0.0,  0.0,
        0.0, 0.0, 1.0,  0.0,
        0.0, 0.0, 0.0,  1.0);
```
Actually, scratch the previous technique out. Today I realized that I could just represent this matrix using the native transformations available, which is faster and gets me the result I originally wanted:
```
    with pushMatrix():
        rotateY(PI/2)
        shearY(-PI/4)
        rotateY(-PI/2)
```

### Eases
I like using smoothsteps a lot, and if I need it to be periodic, I'll just smoothstep a sin function. If there was a need to create multiple steps, I scale down the results of one smoothstep, and add another smoothsteps to take have more than two steps.

```python
def smoothstep(edge0, edge1, x):
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    return x * x * (3 - 2 * x)
```

```python
def sn(q): return smoothstep(0.0,0.8,sin(q))
```

## Grids
### Subdivision

```python
class Quadrant(object):
    def __init__(self,x,y,w,h):
        global globalCount 
        self.x = x
        self.y = y
        self.w = w
        self.h = h
        self.bool = True if (globalCount==0) else (random(1.0)>0.5)
        globalCount += 1
    def subdivide(self,nx=10,ny=5):
        if(self.bool):
            output = []
            #nx,ny = 3,3
            W = self.w/float(nx) 
            H = self.h/float(ny)
            for i in range(nx):
                for j in range(ny):
                    output.append(Quadrant(self.x+i*W,self.y+j*H,W,H))
            return output
        return [self]
    def display(self):
        noStroke()
        #noFill
        colors = [[random(0.5,0.9),1.0,1.0] for i in range(4)]
        with beginShape(QUADS):
            fill(*colors[0])
            vertex(self.x,self.y)
            fill(*colors[1])
            vertex(self.x+self.w,self.y)
            fill(*colors[2])
            vertex(self.x+self.w,self.y+self.h)
            fill(*colors[3])
            vertex(self.x,self.y+self.h)
        #rect(self.x,self.y,self.w,self.h)
```

### Normalized Dynamic Grid 
I gotta simplify this, but for now:
```python
# 1D Grid
def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]
def sumPrev(alist): return [0]+[sum(alist[:index+1]) for index,i in enumerate(alist)][:-1]

# 2D Grid
def getMatrix(X,Y,W=400,chance=None):
    if(chance is None):
        M = [[1 for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
        
    else:
        M = [[0 if random(1) > chance else 1 for j in range(X)] for i in range(Y)]
        M = [normalizeList(i,W) for i in M]
    return M
def getPositions(M):
    return [sumPrev(i) for i in M]
```

I also use this to create a dynamic expression/offset:
```python
def expression(time,i,j):
    amplitude = 5.0
    frequency = 0.1
    delay = 1.0*(i+j)/(X+Y-2)
    
    transformation = sin(TWO_PI*time+delay*frequency)
    transformation += cos(TWO_PI*time+frequency+delay)
    transformation += sin(TWO_PI*time+frequency*2.1+delay)
    transformation += sin(TWO_PI*time+frequency*1.72+delay)
    transformation += cos(TWO_PI*time+frequency*2.221+delay)
    transformation += sin(TWO_PI*time+frequency*3.1122+delay)
    transformation *= amplitude
    return map(transformation,-amplitude,amplitude,0,1)
```

## GLSL stuff
### What I should have in my python sketch

```python
    try:
        someShader = loadShader("shader.glsl")
    except:
        resetShader()
    
    someShader.set("iResolution", float(width), float(height));
    someShader.set("iMouse", float(mouseX), height-float(mouseY));
    someShader.set("iTime", millis() / 1000.0);
    
    blended = lerpLists(phrase,map(0.5*cs(TWO_PI*a)+0.5*cs(TWO_PI*a+1.5),-1,1,0,1))
    blended = [PVector(i.x,i.y,i.z) for i in blended]
    index = 0
    for pos,colors in zip(blended,blendedColors):
        someShader.set("locations[{}]".format(index),pos.x,height-pos.y)
        someShader.set("radii[{}]".format(index),lerp(1.5,2.0,cs(TWO_PI*a)))
        someShader.set("colors[{}]".format(index),float(colors.x),
                                                  float(colors.y),
                                                  float(colors.z))
```


### Necessary funcs ported to GLSL
```glsl

float norm(float t, float a, float b){
    return (t-a)/(b-a);
}
float remap(float t, float a, float b, float c, float d){
    return norm(t, a, b) * (d-c) + c;
}

float getMax(float list[number]) {
  int limit = number;
  float maxN = 0.0;
  int maxPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list[i];
    if (value > maxN) {
      maxN = value;
      maxPos = i;
    }
  }
  return maxN;
}
int getMaxP(float list[number]) {
  int limit = number;
  float maxN = 0.0;
  int maxPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list[i];
    if (value > maxN) {
      maxN = value;
      maxPos = i;
    }
  }
  return maxPos;
}


float getMin(float list[number]) {
  int limit = number;
  float minN = 100000000.0;
  int minPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list[i];
    if (value < minN) {
      minN = value;
      minPos = i;
    }
  }
  return minN;
}
int getMinP(float list[number]) {
  int limit = number;
  float minN = 100000000.0;
  int minPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list[i];
    if (value < minN) {
      minN = value;
      minPos = i;
    }
  }
  return minPos;
}
```

# Rhino

Matrix of intersections (where x and y are two different sets of extrusions that intersect):
```python
import rhinoscriptsyntax as rs
a = []
for i in x:
    for j in y:
        a.append(rs.BooleanIntersection(i,j,delete_input=False))

a= [j for i in a for j in i]
```
