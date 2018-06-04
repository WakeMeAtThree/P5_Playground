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

public class texture extends PApplet {

PShader shader;
PImage label;
public void setup() {
  
  noStroke();

  shader = loadShader("shader.glsl");
  label = loadImage("lachoy.jpg");
}

public void draw() {
    try{
        shader = loadShader("shader.glsl","vert.glsl");
          shader.set("u_resolution", PApplet.parseFloat(width), PApplet.parseFloat(height));
  shader.set("u_mouse", PApplet.parseFloat(mouseX), PApplet.parseFloat(mouseY));
  shader.set("u_time", millis() / 1000.0f);
  shader.set("texture",label);
  shader(shader);
    } catch(Exception e){
    }

  rect(0,0,width,height);
}
  public void settings() {  size(640, 360, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "texture" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
