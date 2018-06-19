import random
import json 


class Ball(object):
    def __init__(self):
        self.width = 400
        self.height = 400
        self.point = {'x':random.gauss(self.width/2,1),'y':random.gauss(self.height/2,1)}
        self.vel = {'x':random.random(),'y':random.random()}
        self.acc = {'x':random.random(),'y':random.random()}
    def update(self):
        self.point['x']+=self.vel['x']
        self.point['y']+=self.vel['y']

        self.vel['x']+=self.acc['x']
        self.vel['y']+=self.acc['y']
        

        
    def bounce(self):
        if(self.point['x'] > self.height or self.point['x'] < 0): self.vel['x'] *= -1
        if(self.point['y'] > self.height or self.point['y'] < 0): self.vel['y'] *= -1
    def display(self):
        pass
    def to_dict(self):
        ""
        pass


balls = [Ball() for i in range(5000)]

while(1):
    for ball in balls:
        ball.update()
        ball.bounce()

    with open(r'C:\Users\AlQu\Desktop\jsontest\data2.json', "r+") as jsonFile:
        jsonFile.seek(0)  # rewind
        json.dump({i:j.point for i,j in enumerate(balls)},jsonFile)
        jsonFile.truncate()