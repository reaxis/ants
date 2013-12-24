class Colony {
  Ant[] ants;
  Terrain terrain;
  int nestX, nestY;
  
  Colony(int number, Terrain _terrain, int _nestX, int _nestY) {
    terrain = _terrain;
    nestX = _nestX;
    nestY = _nestY;
    
    ants = new Ant[number];
 
    for (int i = 0; i < ants.length; i++) {
      ants[i] = new Ant(nestX, nestY);
    }
  }
  
  void update() {
    for (int i = 0; i < ants.length; i++) {
      // ants[i].move(terrain);
    }
  }
  
  void draw() {
    for (int i = 0; i < ants.length; i++) {
      ants[i].draw();
    }
  }
}
