void initialize() {
  // reseed Perlin noise
  noiseSeed((int)random(10000));
  
  shortestRoute = 10000000;

//  terrain = new Terrain(resolution); //, 10, 10, width/resolution-10, height/resolution-10);
  
//  terrain = new Terrain(resolution, "extended_double_bridge.png");
//  terrain = new Terrain(resolution, "split.png");
//  terrain = new Terrain(resolution, "extra_narrow_path.png");
//  terrain = new Terrain(resolution, "narrow_extended_double_bridge.png");
//  terrain = new Terrain(resolution, "random_paths.png");
  terrain = new Terrain(resolution, "grid.png");
  
  colony = new Colony(numberOfAnts, terrain);
}
