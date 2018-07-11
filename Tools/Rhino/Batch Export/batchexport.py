import rhinoscriptsyntax as rs
import os

# Changing working Directory
filepath = 'C:\Users\AQ\Desktop\Generate'
os.chdir(filepath)

# Print working directory
print(os.getcwd())

# Export Function
def objBatchExport():
    selection = rs.GetObjects(preselect=True)
    rs.EnableRedraw(False)
    for i, obj in enumerate(selection):
        e_file_name = "{}\{}.obj".format(filepath,'target'+rs.ObjectName(obj))
        rs.UnselectAllObjects()
        rs.SelectObject(obj)
        rs.Command('-_Export "{}" _Enter _Enter'.format(e_file_name), True)
    rs.EnableRedraw(True)

# Run
objBatchExport()