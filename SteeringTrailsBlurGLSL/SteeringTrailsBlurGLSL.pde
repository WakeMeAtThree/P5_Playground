// Modified a processing blur example to one of these convolution
// kernels: https://en.wikipedia.org/wiki/Kernel_(image_processing)

PShader blur;
ArrayList<Ball> balls;
Ball ball;

void setup() {
  size(640, 360, P2D);
  blur = loadShader("blur.glsl");
  balls = new ArrayList();
  for (int i = 0; i < 100; i++) {
    ball = new Ball();
    balls.add(ball);
  }
}

void draw() {

  fill(0,1);
  rect(0,0,width,height);

  filter(blur);  
  fill(255);
  for (Ball ball : balls) {

    ball.update(mouseX, mouseY);
    ball.display();
  }
}