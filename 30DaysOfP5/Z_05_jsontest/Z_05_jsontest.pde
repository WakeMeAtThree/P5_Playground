JSONObject json;

void setup() {
  size(400, 400);
}  

void draw() {
  background(0);
  try {
    json = loadJSONObject("data2.json");
    for (int i = 0; i < json.size(); i++) {
      JSONObject points = json.getJSONObject(""+i);
      ellipse(points.getFloat("x"), points.getFloat("y"), 20, 20);
    }
  } 
  catch(Exception e) {
  }
}