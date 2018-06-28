//This is coding challenge done while following the video from 
//the YouTube channel Barney
//https://youtu.be/_w4tNafprAY


ArrayList<Particle> p = new ArrayList<Particle>();

void setup() {
  size(1080, 700);
  background(0);
  colorMode(HSB);
  //p = new Particle(width/2,height/2, 0, int(random(255)));
  noStroke();
  burst(100);
}

void draw() {
  //background(0);
  //clear();
  pushStyle();
  fill(0, 10);
  rect(0, 0, width, height);
  popStyle();
  for (int i = p.size() - 1; i >= 0; i--) {
    p.get(i).update();
    if (p.get(i).dead) {
      p.remove(i); 
      continue;
    }
    p.get(i).show();
  }
}

void burst(int num) {
  int c = int(random(255));
  for (int i = 0; i < num; i++) {
    float a = int(random(8)) * PI/4;
    p.add(new Particle(width/2, height/2, a, c));
  }
}

void keyPressed() {
  if (key == ' ') {
    burst(100);
  }
}