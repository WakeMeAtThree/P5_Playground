import rhinoscriptsyntax as rs
import os

#I/O handling
selection = rs.GetObjects(preselect=True)
filePath = "YOUR SAVE FILEPATH GOES HERE"
os.chdir(filePath)

# Sample Header of an SVG file I had
header = """<?xml version="1.0"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
 
<svg xmlns="http://www.w3.org/2000/svg" version = "1.1"
      preserveAspectRatio = "xMinYMin meet" viewBox = "0 0 150 150">
 <path d= "M{},{} 
{}
 " stroke = "black" stroke-width = ".1" fill = "none" />
</svg>"""

# Functions to extact necessary items for header
def parse(x): return "L {},{}".format(x[0],x[1])
def maxPoint(y): return max([i[1] for i in y])
def minPoint(x): return min([i[0] for i in x])
def flipY(x): return [[i[0],-i[1]] for i in x]

# Export function
def exportToSvg(x,state='init'):
    points = flipY(rs.CurveEditPoints(x))
    parsed = [parse(i)+"\n" for i in points]
    parsed[-1] = parsed[-1][:-2]
    parsed = "".join(parsed)
    with open("{}{}.svg".format(state,rs.ObjectName(x)), "w") as f:
        f.write(header.format(minPoint(points),maxPoint(points),parsed))

#Run function. Alternate between 'init' and 'target'
output = [exportToSvg(i,'target') for i in selection]
