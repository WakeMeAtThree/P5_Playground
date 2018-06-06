import rhinoscriptsyntax as rs
import os

selection = rs.GetObjects(preselect=True)
filePath = ""
os.chdir(filePath)

header = """<?xml version="1.0"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
 "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
 
<svg xmlns="http://www.w3.org/2000/svg" version = "1.1"
      preserveAspectRatio = "xMinYMin meet" viewBox = "0 0 150 150">
 <path d= "M{},{} 
{}
 
 " stroke = "black" stroke-width = ".1" fill = "none" />
</svg>"""

def parse(x): return "L {},{}".format(x[0],x[1])
def maxPoint(y): return max([i[1] for i in y])
def minPoint(x): return min([i[0] for i in x])
def exportToSvg(x,state='initial'):
    points = rs.CurveEditPoints(x)
    parsed = "".join([parse(i)+"\n" for i in points])
    with open("{}{}.svg".format(state,rs.ObjectName(x)), "w") as f:
        f.write(header.format(minPoint(points),maxPoint(points),parsed))

output = [exportToSvg(i) for i in selection]