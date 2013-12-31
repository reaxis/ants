class Colony {
  Ant[] ants;
  Terrain terrain;
  int resolution, nestX, nestY;
  
  Colony(int number, Terrain _terrain, int _resolution, int _nestX, int _nestY) {
    terrain = _terrain;
    resolution = _resolution;
    nestX = _nestX;
    nestY = _nestY;
    
    ants = new Ant[number];
 
    for (int i = 0; i < ants.length; i++) {
      ants[i] = new Ant(nestX, nestY);
    }
  }
  
  void update() {
    for (int i = 0; i < ants.length; i++) {
      ants[i].move(terrain);
    }
  }
  
  void draw() {
    //pushMatrix();
    
    // to draw ants in center of grid cells 
    //translate((resolution-1)/2, (resolution-1)/2);
    
    // draw ants
    for (int i = 0; i < ants.length; i++) {
      ants[i].draw();
    }
    
    //popMatrix();
    
    // draw nest
    noStroke();
    fill(0, 255, 0);
    rect(nestX*resolution, nestY*resolution, resolution, resolution);  
  }
}
