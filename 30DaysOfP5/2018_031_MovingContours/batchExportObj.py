import rhinoscriptsyntax as rs
import scriptcontext as sc
import os

def objBatchExport():
    selection = rs.GetObjects(preselect=True)
    folder = rs.BrowseForFolder(rs.WorkingFolder())

    rs.EnableRedraw(False)
    for i, obj in enumerate(selection):
        e_file_name = "{}-{}.obj".format("habibi",i)
        rs.UnselectAllObjects()
        rs.SelectObject(obj)
        rs.Command('-_Export "{}" _Enter'.format(e_file_name), True)
    rs.EnableRedraw(True)

objBatchExport()