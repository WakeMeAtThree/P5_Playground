class Meshes {
  ArrayList<Mesh> initials;
  ArrayList<Mesh> blends;
  ArrayList<Mesh> targets;
  Meshes(int n) {
    this.initials = new ArrayList<Mesh>();
    this.blends = new ArrayList<Mesh>();
    this.targets = new ArrayList<Mesh>();
    
    for (int i = 1; i <= n; i++) {
      this.initials.add(new Mesh(loadShape("init"+i+".svg")));
      this.blends.add(new Mesh(loadShape("init"+i+".svg")));
      this.targets.add(new Mesh(loadShape("target"+i+".svg")));
    }
    
  }
  
  void morph(float a){
    for(int i = 0; i < this.blends.size(); i++){
      float param = 1.0*i/this.blends.size();
      this.blends.get(i).morph(a+param,this.initials.get(i), this.targets.get(i));
    }
  }
  
  void display(float scl){
    for(Mesh m: this.blends){
      m.display(scl);
    }
  }
}
