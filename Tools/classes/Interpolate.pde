ArrayList<PVector> lerpVerts(ArrayList<PVector> initial, ArrayList<PVector> target, float a) {
  ArrayList<PVector> output = new ArrayList<PVector>();
  for (int i = 0; i < initial.size(); i++) {
  }
  return output;
}

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float cs(float q) {
  return lerp(-1, 1, ease(map(cos(q), -1, 1, 0, 1), 5));
}
