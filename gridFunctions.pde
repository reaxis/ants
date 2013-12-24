void initialize() {
  // reseed Perlin noise
  noiseSeed((int)random(10000));
  
  shortestRoute = 10000000;
  
  // set food location to lower right corner
  foodX = width/px-10;
  foodY = height/px-10;
  
  // foodX = width/px/2;
  // foodY = height/px - 10;
  
  // initialize grid
  grid = new float[width/px][height/px];
  
  // fill grid with solid ground
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {
      grid[x][y] = 0;
    }
  }
  
  // create landscape with Perlin noise
  for (int x = 1; x < grid.length-1; x++) {
    for (int y = 1; y < grid[x].length-1; y++) {
      float n = noise(x/10f, y/10f);
      grid[x][y] = n < 0.43 ? 0 : 1;
      
      // grid[x][y] = 1;
      
      // open if close to nest
      if (dist(x, y, nestX, nestY) < 10) {
        grid[x][y] = 1;
      }
      
      // open if close to food
      if (dist(x, y, foodX, foodY) < 10) {
        grid[x][y] = 1;
      }
    }
  }
  noStroke();
  
  for (int i = 0; i < 10; i++) {
    blurGrid();
  }
  
  colony = new Ant[numberOfAnts];
 
  for (int i = 0; i < colony.length; i++) { 
    colony[i] = new Ant(nestX, nestY);
  }
}

void blurGrid() {
  for (int x = 1; x < grid.length-1; x++) {
    for (int y = 1; y < grid[x].length-1; y++) {
      int neighborhood = 0;
      
      neighborhood += grid[x+1][y-1];
      neighborhood += grid[x+1][y];
      neighborhood += grid[x+1][y+1];
      neighborhood += grid[x][y-1];
      neighborhood += grid[x][y+1];
      neighborhood += grid[x-1][y-1];
      neighborhood += grid[x-1][y];
      neighborhood += grid[x-1][y+1];
      
      if (grid[x][y] == 0 && neighborhood > 4) {
        grid[x][y] = 1;
      }
    }
  }
}
