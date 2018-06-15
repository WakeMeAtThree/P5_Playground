Torus a;
ArrayList<String> test,insertion;
void setup() {
  size(400, 400);
  background(255);
  translate(width/2, height/2);
  test = new ArrayList<String>();
  insertion = new ArrayList<String>();
  test.add("habibi");
  test.add("hayati");
  test.add("3mri");
  test.add("galbi");
  //
  insertion.add("1");
  insertion.add("2");

  float[] res = {5,5,5,5,5,5,15,25,13,25,12,24,51,5,15,5,5,5};
  a = new Torus(65, 15, res);
  a.interpolate();
  a.display();

  test.addAll(1,insertion);
  test.addAll(4,insertion);
  println(test);
}

float CosineInterpolate(float y1, float y2, float mu) {
  float mu2 = (1-cos(mu*PI))/2;
  return y1*(1-mu2)+y2*mu2;
}
