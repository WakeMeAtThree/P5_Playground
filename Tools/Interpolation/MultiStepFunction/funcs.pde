float frac(float x) {
  return x - floor(x);
}

float smoothstep(float edge0, float edge1, float x) {
  // Scale, bias and saturate x to 0..1 range
  x = constrain((x - edge0) / (edge1 - edge0), 0.0f, 1.0f); 
  // Evaluate polynomial
  return x * x * (3 - 2 * x);
}

float step(float x, float threshold) {
  // Step will return 0.0 unless the value is over 0.5,
  // in that case it will return 1.0
  if (x>threshold) {
    return 1.0f;
  } else {
    return 0.0f;
  }
}

float exponentialEasing (float x, float a){
  
  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  a = max(min_param_a, min(max_param_a, a));
  
  if (a < 0.5){
    // emphasis
    a = 2.0*(a);
    float y = pow(x, a);
    return y;
  } else {
    // de-emphasis
    a = 2.0*(a-0.5);
    float y = pow(x, 1.0/(1-a));
    return y;
  }
}

float sinc( float x, float k )
{
    float a = PI * (k*x-1.0);
    return sin(a)/a;
}

// Set of functions taken from Dave Whyte's sketches

float ease(float p) {
  return 3*p*p - 2*p*p*p;
}

float ease(float p, float g) {
  if (p < 0.5) 
    return 0.5 * pow(2*p, g);
  else
    return 1 - 0.5 * pow(2*(1 - p), g);
}

float cs(float q){
  return lerp(-1,1,ease(map(cos(q),-1,1,0,1),5));
}
