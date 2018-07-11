PVector averageVertices(ArrayList<PVector> input) {
  PVector output = new PVector(0,0,0);
  
  for(PVector v: input){
    output.add(v);
  }
  
  output.mult(1.0/input.size());
  
  return output;
}
