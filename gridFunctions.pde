void initialize() {
  // reseed Perlin noise
  noiseSeed((int)random(10000));
  
  shortestRoute = 10000000;
  
  // set initial food location to lower right corner
  foodX = width/resolution-10;
  foodY = height/resolution-10;

  terrain = new Terrain(resolution, foodX, foodY);
  
  colony = new Colony(numberOfAnts, terrain, resolution, nestX, nestY);
}
