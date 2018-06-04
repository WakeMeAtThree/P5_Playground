PShape object;
PShader shader;
float ry;
  
void setup() {
  size(640, 360, P3D);
    
  object = loadShape("sample.obj");
}

void draw() {
  background(0);
   float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  
    try{   
 background(0,0,0);
    shader = loadShader("colorfrag.glsl","colorvert.glsl");
    shader.set("u_resolution", float(width), float(height));
    shader.set("u_mouse", float(mouseX), float(mouseY));
    shader.set("u_time", millis() / 1000.0);
    shader.set("fraction", 1.0);
    shader(shader);

  } catch(Exception e){
    println("shader error");
  }
  //lights();
  
  translate(width/2, height/2 + 100, -200);
  scale(15);
  directionalLight(204, 204, 204, dirX, dirY, -1);
  rotateZ(PI);
  rotateY(ry);
  object.disableStyle();
  fill(255,0,128);
  shape(object);
  
  ry += 0.02;
}
