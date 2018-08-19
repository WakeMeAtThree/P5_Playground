# Useful code snippets

I find myself returning to a lot of repeated code, and so I've decided to compile the most frequent code I keep returning to. This will range in areas from some useful functions for github maintenance to shaders, to processing, and whatever else I use on the regular.

## Terminal Commands

### FFmpeg
The following are useful `ffmpeg` commands for making animation gifs/mp4 (I should look into [gifiscle](https://www.lcdf.org/gifsicle/)). 

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


## Utility

### Loading csv points from Grasshopper

```python
def loadPoints(fname):
    with open(fname) as f:
        content = f.readlines()
    data = [i.replace('\n','')[1:][:-1].split(',') for i in content]
    data = [PVector(*map(float,i)) for i in data]
    return data

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

### Eases

```python
def smoothstep(edge0, edge1, x):
    # Scale, bias and saturate x to 0..1 range
    x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0)
    # Evaluate polynomial
    return x * x * (3 - 2 * x)
```

```python
def sn(q): return smoothstep(0.0,0.8,sin(q))#lerp(-1, 1, ease(map(sin(q), -1, 1, 0, 1), 5))
```
### Misc

```python
def normalizeList(alist,multiply): return [1.0*multiply*i/sum(alist) for i in alist]
```

## Custom shapes

### Loaded meshes in processing
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
    #noStroke()
    #
    #
    with beginShape(QUAD_STRIP):
        for i in points:
            fill(lerp(255,0,T))
            vertex(i.x,i.y,0)
            fill(lerp(0,255,T))
            vertex(i.x,i.y,lerp(-H,H,T))
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
        self.bool = True if (globalCount==0) else (random(1.0)>0.4)
        globalCount += 1
    def subdivide(self):
        if(self.bool):
            cell1 = Quadrant(self.x,self.y,self.w/2.0,self.h/2.0)
            cell2 = Quadrant(self.x+self.w/2,self.y,self.w/2.0,self.h/2.0)
            cell3 = Quadrant(self.x,self.y+self.h/2,self.w/2.0,self.h/2.0)
            cell4 = Quadrant(self.x+self.w/2,self.y+self.h/2,self.w/2.0,self.h/2.0)
            return [cell1,cell2,cell3,cell4]
        return [self]
    def display(self,param):
        #YOUR MODULE GOES HERE
        rect(self.x,self.y,self.w,self.h)
```



# GLSL stuff

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

# Interpolations

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

```

