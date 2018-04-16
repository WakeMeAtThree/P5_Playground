PShader blur;
TenPrint uno;
TenPrint due;

void setup() {
  size(1000, 500, P2D);
  background(0);
  smooth(8);
  colorMode(HSB, 1, 1, 1, 1);
  blur = loadShader("blur.glsl");
  
  //Instantiate TenPrinters
  uno = new TenPrint(0, 0, 50);
  due = new TenPrint(0, 0, 50);
}

void draw() {
  //Filter shader and run the TenPrint objects
  filter(blur);  
  uno.run();
  due.run();
}