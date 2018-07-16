ArrayList<Float> applyFunc(ArrayList<Float> input) {
  /* Template for applying a set of functions to an
   ArrayList<Float> */

  ArrayList<Float> output = new ArrayList<Float>();
  for (int i = 0; i < input.size(); i++) {
    //Option 1
    output.add((input).get(i));
  }
  return output;
}

float smoothstep(float edge0, float edge1, float x) {
  // Scale, bias and saturate x to 0..1 range
  x = constrain((x - edge0) / (edge1 - edge0), 0.0, 1.0); 
  // Evaluate polynomial
  return x * x * (3 - 2 * x);
}

ArrayList<Float> getNormalized(ArrayList<Float> input) {
  ArrayList<Float> output = new ArrayList<Float>();
  float min = getMin(input);
  float max = getMax(input);
  for (int i = 0; i < input.size(); i++) {
    output.add(map(input.get(i), min, max, 0.0, 1.0));
  }
  return output;
}

ArrayList<Float> getNormalizedSum(ArrayList<Float> input) {
  ArrayList<Float> output = new ArrayList<Float>();
  float min = getMin(input);
  float max = getMax(input);
  float sum = 0;
  for (int i = 0; i < input.size(); i++) {
    sum += input.get(i);
  }
  for (int i = 0; i < input.size(); i++) {
    output.add(input.get(i)/sum);
  }
  return output;
}

float getMax(ArrayList<Float> list) {
  float limit = list.size();
  float max = Float.MIN_VALUE;
  int maxPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list.get(i);
    if (value > max) {
      max = value;
      maxPos = i;
    }
  }
  return max;
}

float getMin(ArrayList<Float> list) {
  float limit = list.size();
  float min = Float.MAX_VALUE;
  int minPos = -1;
  for (int i = 0; i < limit; i++) {
    float value = list.get(i);
    if (value < min) {
      min = value;
      minPos = i;
    }
  }
  return min;
}
