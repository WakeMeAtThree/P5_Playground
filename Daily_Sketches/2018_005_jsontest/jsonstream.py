import json 

class Ball(object):
    def __init__(self):
        self.width = 400
        self.height = 400
        self.point = {'x':0.0,'y':0.0}
        self.vel = {'x':0.5,'y':0.1}
        self.acc = {'x':0.1,'y':0.4}
    def update(self):
        self.point['x']+=self.vel['x']
        self.point['y']+=self.vel['y']

        
    def bounce(self):
        if(self.point['x'] > self.height or self.point['x'] < 0): self.vel['x'] *= -1
        if(self.point['y'] > self.height or self.point['y'] < 0): self.vel['y'] *= -1
    def display(self):
        pass
    def to_dict(self):
        ""
        pass

ball = Ball()

while(1):
    ball.update()
    ball.bounce()

    with open(r'C:\Users\AlQu\Desktop\jsontest\data2.json', "r+") as jsonFile:
        jsonFile.seek(0)  # rewind
        json.dump(ball.point,jsonFile)
        jsonFile.truncate()