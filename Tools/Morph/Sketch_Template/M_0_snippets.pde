//Placing commonly used values here 
//(colors, delayMultipliers, etc.)
//#0EC0E1, #DD3A7C
//{#13daff, #f73b87};
float gridDelay(int i, int j, int totalCount){
  return globalMult*(i+j)/totalCount;
}

float radialDelay(int i, int j, int totalCount){
  return (pow(i,2)+pow(j,2))/(sqrt(2)*totalCount);
}
