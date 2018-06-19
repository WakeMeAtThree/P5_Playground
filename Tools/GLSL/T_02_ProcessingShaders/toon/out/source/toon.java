import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class toon extends PApplet {

PShape object;
PShader shader;
float ry;
  
public void setup() {
  
    
  object = loadShape("sample.obj");
}

public void draw() {
  background(0);
   float dirY = (mouseY / PApplet.parseFloat(height) - 0.5f) * 2;
  float dirX = (mouseX / PApplet.parseFloat(width) - 0.5f) * 2;
  
    try{   
 background(0,0,0);
    shader = loadShader("colorfrag.glsl","colorvert.glsl");
    shader.set("u_resolution", PApplet.parseFloat(width), PApplet.parseFloat(height));
    shader.set("u_mouse", PApplet.parseFloat(mouseX), PApplet.parseFloat(mouseY));
    shader.set("u_time", millis() / 1000.0f);
    shader.set("fraction", 1.0f);
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
  
  ry += 0.02f;
}
  public void settings() {  size(640, 360, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "toon" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
