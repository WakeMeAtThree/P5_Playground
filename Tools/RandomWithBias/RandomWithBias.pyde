def setup():
    size(400,400)
    global newList, counts, modules
    modules = ["A","B","C","D","E","F","G"]
    counts = {i:0 for i in modules}
    
    newList = []
    biases = [1,1,5,2,1,2,1]
    
    for i,j in zip(modules,biases):
        newList+=[i]*j
    
    newList = shuffle(newList)
    print(newList)


def draw():
    background(0)
    for i,letter in enumerate(modules): 
        rect(width/len(modules)*i,0,width/len(modules),counts[letter])
    counts[newList[floor(random(len(newList)))]]+=1

def shuffle(alist):
    jumble = alist
    for i,letter in enumerate(jumble):
        r = int(random(i))
        jumble[i],jumble[r] = jumble[r],jumble[i]
    return jumble