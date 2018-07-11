class Meshes {
  ArrayList<Mesh> initials;
  ArrayList<Mesh> blends;
  ArrayList<Mesh> targets;
  Meshes(int n) {
    this.initials = new ArrayList<Mesh>();
    this.blends = new ArrayList<Mesh>();
    this.targets = new ArrayList<Mesh>();

    for (int i = 1; i <= n+1; i++) {
      this.initials.add(new Mesh(loadShape("1"+i+".svg")));
      this.blends.add(new Mesh(loadShape("1"+i+".svg")));
      this.targets.add(new Mesh(loadShape("2"+i+".svg")));
    }
  }

  void morph(float a) {
    for (int i = 0; i < this.blends.size(); i++) {
      float param = 0.0*i/this.blends.size();
      this.blends.get(i).morph(this.initials.get(i), this.targets.get(i), a+param);
    }
  }

  void display(float scl) {
    for (Mesh m : this.blends) {
      m.display(scl);
    }
  }
}
