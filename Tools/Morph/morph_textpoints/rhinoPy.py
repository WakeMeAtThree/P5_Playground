#Subdivided curves by length then used GHPython to
#output their coordinates into a csv file for use
#in processing later.

fileName = open("\Z_37_LaurelYanny\file.csv", 'w')
for pt in x:
	fileName.write("{},{},{}\n".format(pt[0],pt[1],pt[2]))
fileName.close()