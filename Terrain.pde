class Terrain {
  float noiseResolution = 10;
  float noiseThreshold = 0.43;
  float[][] grid;
  int resolution, nestX, nestY;
  IntList foodX, foodY;
  PImage img;
  
  Terrain(int _resolution) {
    resolution = _resolution;
    
    // initialize grid
    grid = new float[width/resolution][height/resolution];
    
    // initialize food sources
    foodX = new IntList(); 
    foodY = new IntList();
    
    img = createImage(grid.length*resolution, grid[0].length*resolution, RGB);
  }
  
  Terrain(int _resolution, String filename) {
    this(_resolution);
       
    PImage map = loadImage(filename);
    map.loadPixels();
    
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[x].length; y++) {
        if (map.pixels[y*map.width+x] == #000000) grid[x][y] = 0;
        else grid[x][y] = 1;      
        
        if (map.pixels[y*map.width+x] == #00FF00) { // nest
          nestX = x;
          nestY = y;
        }
        
        if (map.pixels[y*map.width+x] == #FF0000) { // food
          foodX.append(x);
          foodY.append(y);
        }
      }
    }
  }
  
  Terrain(int _resolution, int _nestX, int _nestY, int[] _foodX, int[] _foodY) {
    this(_resolution);

    nestX = _nestX;
    nestY = _nestY;
    
    for (int i = 0; i < _foodX.length; i++) {
      foodX.append(_foodX[i]);
      foodY.append(_foodY[i]);
    }
  
    // fill grid with solid ground
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[x].length; y++) {
        grid[x][y] = 0;
      }
    }
  
    // create landscape with Perlin noise
    // leave an edge around it all, we don't want none of them wrap-around space donuts
    for (int x = 1; x < grid.length-1; x++) {
      for (int y = 1; y < grid[x].length-1; y++) {
        float n = noise(x/noiseResolution, y/noiseResolution);
        grid[x][y] = n < noiseThreshold ? 0 : 1;
        
        // open if close to nest
        if (dist(x, y, nestX, nestY) < 10) {
          grid[x][y] = 1;
        }
        
        // open if close to food
        for (int i = 0; i < foodX.size(); i++) {
          if (dist(x, y, foodX.get(i), foodY.get(i)) < 10) {
            grid[x][y] = 1;
          }
        }
      }
    }
    
    for (int i = 0; i < 10; i++) {
      erode();
    }
  }
  
  void draw() {
    img.loadPixels();
    
    float highest = highestValue();
  
    // draw the grid
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[x].length; y++) {
        color c = grid[x][y] == 0 ? #222222 : colorScale(map(grid[x][y], 1, highest, 0, 1));
        
        for (int i = 0; i < resolution; i++) {
          for (int j = 0; j < resolution; j++) {            
            img.pixels[y*img.width*resolution + x*resolution + i + j*grid.length*resolution] = c;
          }
        }
      }
    }
    
    img.updatePixels();
    image(img, 0, 0);
    
    // draw food
    for (int i = 0; i < foodX.size(); i++) {
      fill(255, 0, 0, 50);
      ellipse(foodX.get(i)*resolution + resolution/2, foodY.get(i)*resolution + resolution/2, 10*resolution, 10*resolution);

      fill(255);
      text(i+1, foodX.get(i)*resolution + resolution/2, foodY.get(i)*resolution + resolution/2);
    }
  }
  
  void evaporate() {
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[x].length; y++) {
        // grid[x][y] *= pow(evaporationRate, speed); // evaporate as many steps as ants updated
        grid[x][y] *= evaporationRate;
        
        /*
        // limit amount of pheromones
        if (grid[x][y] > pheromoneLimit) {
          grid[x][y] = pheromoneLimit;
        }
        */

        /*
        if (grid[x][y] > highest) {
          highest = grid[x][y];
        }
        */
        
        // evaporation shouldn't happen below value of 1
        if (grid[x][y] > 0 && grid[x][y] < 1) {
          grid[x][y] = 1;
        }
      }
    }
  }
  
  // find out highest pheromone value
  float highestValue() {
    float highest = 3;
    
    for (int x = 0; x < grid.length; x++) {
      for (int y = 0; y < grid[x].length; y++) {
        
        // don't check nest
        if (x != nestX && y != nestY && grid[x][y] > highest) {
          highest = grid[x][y];
        }
      }
    }
    
    return highest;
  }
  
  // make a more smooth, workable map by removing pesky protrusions
  void erode() {
    for (int x = 1; x < grid.length-1; x++) {
      for (int y = 1; y < grid[x].length-1; y++) {
        
        // count number of open cells
        int neighborhood = 0;
        
        // surrounding cells
        int[][] neighbors = {
          {-1, -1}, {0, -1}, {1, -1},
          {-1,  0},          {1,  0},
          {-1,  1}, {0,  1}, {1,  1}
        };
        
        for (int i = 0; i < neighbors.length; i++) {
          neighborhood += grid[x + neighbors[i][0]][y + neighbors[i][1]];
        }
        
        // if terrain is solid and neighbored by more than 4 open cells...
        if (grid[x][y] == 0 && neighborhood > 4) {
          grid[x][y] = 1; // ... open it up
        }
        
        // if terrain is open and neighbored by more than 6 solid cells...
        if (grid[x][y] == 1 && neighborhood < 4) {
          grid[x][y] = 0; // ... close it up
        }
      }
    }
  }
}
