// Alphabets: A,B
// Axiom A
// Rules: (A -> AB), (B -> A)

import java.util.Map;

String axiom = "F";
String sentence = axiom;
float len = 50;
HashMap<Character, String> rules = new HashMap<Character, String>();

void setup() {
  size(400, 400);
  background(51);

  //rules.put('A', "AB");
  //rules.put('B', "A");
  
  //For troubleshooting purposes
  //rules.put('[', "[");
  //rules.put(']', "]");
  //rules.put('+', "+");
  //rules.put('-', "-");
  
  rules.put('F', "FF+[+F-F-F]-[-F+F+F]");
}

void draw() {
}

void mousePressed() {
  //ellipse(mouseX,mouseY,10,10);
  turtle();
  generate();
  println(sentence);
}

void generate() {
  len *= 0.56;
  String nextSentence = "";
  for (int i = 0; i < sentence.length(); i++) {
    Character current = sentence.charAt(i);
    if (rules.get(current) != null) {
      nextSentence += rules.get(current);
    } else {
      nextSentence += current;
    }
  }
  sentence = "";
  sentence = nextSentence;
}



void turtle() {
  stroke(255);
  resetMatrix();
  translate(width/2, height);

  for (int i = 0; i < sentence.length(); i++) {

    Character current = sentence.charAt(i);
    if (current == 'F') {
      line(0, 0, 0, -len);
      translate(0, -len);
    }  
    if (current == '+') {
      rotate(radians(25));
    } 
    if (current == '-') {
      rotate(-radians(25));
    } 
    if (current == '[') {
      pushMatrix();
    } 
    if (current == ']') {
      popMatrix();
    }
  }
}