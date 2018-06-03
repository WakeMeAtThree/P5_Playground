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

public class Z_04_smiley extends PApplet {

PShader shader;

public void setup() {
  
  noStroke();

  shader = loadShader("shader.glsl");
  shader.set("u_resolution", PApplet.parseFloat(width), PApplet.parseFloat(height));
  shader.set("u_mouse", PApplet.parseFloat(mouseX), PApplet.parseFloat(mouseY));
  shader.set("u_time", millis() / 1000.0f);
}

public void draw() {
  background(255,0,0);
  try{   
 background(0,0,0);
    shader = loadShader("shader.glsl");
    shader.set("u_resolution", PApplet.parseFloat(width), PApplet.parseFloat(height));
    shader.set("u_mouse", PApplet.parseFloat(mouseX), PApplet.parseFloat(mouseY));
    shader.set("u_time", millis() / 1000.0f);
    shader(shader);
    rect(0,0,width,height);
  } catch(Exception e){

  }
    

}
  public void settings() {  size(640, 360, P2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Z_04_smiley" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
