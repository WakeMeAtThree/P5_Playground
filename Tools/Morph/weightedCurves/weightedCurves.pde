class Curve {
  ArrayList<PVector> vertices;
  Curve() {
    this.vertices = new ArrayList<PVector>();
    this.vertices.add(new PVector(0, 5, 0));
    this.vertices.add(new PVector(1, 3, 0));
    this.vertices.add(new PVector(1, 4, 7));
  }

  ArrayList<PVector> getWeighted(float weight) {
    ArrayList<PVector> output = new ArrayList<PVector>(); 
    for (PVector v: vertices) {
      output.add(v.mult(weight));
    }
    return output;
  }
}

Curve crv1, crv2, crv3;
float[] weights = {0.0, 1.0, 2.0};
ArrayList<Curve> states;

void setup() {
  size(200, 200);
  states = new ArrayList<Curve>();

  crv1 = new Curve();
  crv2 = new Curve();
  crv3 = new Curve();

  states.add(crv1);
  states.add(crv2);
  states.add(crv3);

  int index = 0;
  for (Curve crv : states) {
    println(crv.getWeighted(weights[index]));
    index++;
  }
}
