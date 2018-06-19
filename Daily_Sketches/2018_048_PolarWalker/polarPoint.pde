class Polar{
  float x,y,angle,radius;
  Polar(float radius, float angle){
    this.radius = radius;
    this.angle = angle;
    this.x = radius*cos(angle);
    y = radius*sin(angle);
  }
}
