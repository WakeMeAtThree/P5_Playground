PShader shader;

void setup() {
  size(640, 360, P2D);
  noStroke();

  shader = loadShader("shader.glsl");
}

void draw() {
    try{
        shader = loadShader("shader.glsl");
          shader.set("u_resolution", float(width), float(height));
  shader.set("u_mouse", float(mouseX), float(mouseY));
  shader.set("u_time", millis() / 1000.0);
  shader(shader);
    } catch(Exception e){
    }

  rect(0,0,width,height);
}