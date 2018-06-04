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

public class color extends PApplet {

PShape object;
PShader shader;
PImage label;

float ry;
  
public void setup() {
  
  label = loadImage("lachoy.jpg");
  object= loadShape("sample.obj");
}

public void draw() {
  //background(0);
  try{   
    background(0,0,0);
    shader = loadShader("colorfrag.glsl","colorvert.glsl");
    shader.set("u_resolution", PApplet.parseFloat(width), PApplet.parseFloat(height));
    shader.set("u_mouse", PApplet.parseFloat(mouseX), PApplet.parseFloat(mouseY));
    shader.set("u_time", millis() / 1000.0f);
    shader.set("texture", label);
    shader(shader);
  } catch(Exception e){
  }
  lights();
  translate(width/2, height/2 + 100, -200);
  scale(15);
  rotateZ(PI);
  rotateY(ry);
  shape(object);
  
  ry += 0.02f;
}
  public void settings() {  size(640, 360, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "color" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
