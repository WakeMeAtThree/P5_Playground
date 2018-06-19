PShape object;
PShader shader;
float ry;
  
void setup() {
  size(640, 360, P3D);
    
  object = loadShape("sample.obj");
}

void draw() {
  background(0);
    try{   
 background(0,0,0);
    shader = loadShader("colorfrag.glsl","colorvert.glsl");
    shader.set("u_resolution", float(width), float(height));
    shader.set("u_mouse", float(mouseX), float(mouseY));
    shader.set("u_time", millis() / 1000.0);
    shader(shader);

  } catch(Exception e){
  }
  lights();
  translate(width/2, height/2 + 100, -200);
  scale(15);
  rotateZ(PI);
  rotateY(ry);
  shape(object);
  
  ry += 0.02;
}
