class Colony {
  Ant[] ants;
  Terrain terrain;
  // int resolution, nestX, nestY;
  
  Colony(int number, Terrain _terrain) {
    terrain = _terrain;
    
    // resolution = terrain.resolution;
    // nestX = terrain.nestX;
    // nestY = terrain.nestY;
    
    ants = new Ant[number];
 
    for (int i = 0; i < ants.length; i++) {
      // ants[i] = new Ant(terrain.nestX, terrain.nestY);
      ants[i] = new Ant(terrain.nestX, terrain.nestY, i % 2);
    }
  }
  
  void update() {
    for (int i = 0; i < ants.length; i++) {
      ants[i].move(terrain);
    }
  }
  
  void draw() {    
    // draw ants
    for (int i = 0; i < ants.length; i++) {
      ants[i].draw(terrain);
    }

    // draw nest
    noStroke();
    fill(0, 255, 0);
    rect(terrain.nestX*terrain.resolution, terrain.nestY*terrain.resolution, terrain.resolution, terrain.resolution);  
  }
}
