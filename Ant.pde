class Ant {
  IntList x = new IntList();
  IntList y = new IntList();
  
  int age = 0;
  
  boolean foundFood = false;
  
  int foodTarget = -1;
  
  Ant(int nx, int ny) {
    x.append(nx);
    y.append(ny);
  }
  
  Ant(int nx, int ny, int ntarget) {
    this(nx, ny);
    
    foodTarget = ntarget;
  }
  
  void move(Terrain terrain) {    
    /*
    if (age > 10000) {
      age = 0;
      
      x.clear();
      y.clear();
      
      x.append(terrain.nestX);
      y.append(terrain.nestY);
    }
    */
    
    if (foundFood) {
      age = 0;
      
      if (x.size() > 1) {
        terrain.grid[x.get(x.size()-1)][y.get(y.size()-1)] += pheromoneIncrement;
        
        x.remove(x.size()-1);
        y.remove(y.size()-1);
      } else {
        foundFood = false;
      }      
    } else {
      age++;
      
      int lastX = x.get(x.size()-1);
      int lastY = y.get(y.size()-1);
      
      // surrounding cells
      int[][] neighbors = {
        {-1, -1}, {0, -1}, {1, -1},
        {-1,  0},          {1,  0},
        {-1,  1}, {0,  1}, {1,  1}
      };
      
      // probabilities for all directions
      float[] probabilities = new float[neighbors.length];
      
      // probabilities are based on pheromones on grid
      for (int i = 0; i < neighbors.length; i++) {        
        
        // penalty for diagonal movement
        float penalty = (neighbors[i][0]*neighbors[i][1] == 0) ? 1 : SQRT2;
        
        probabilities[i] = terrain.grid[lastX + neighbors[i][0]][lastY + neighbors[i][1]] / penalty;
        
        // don't go back to where you came from
        if (x.size() > 1) {
          if (x.get(x.size() - 2) == lastX + neighbors[i][0] && y.get(y.size() - 2) == lastY + neighbors[i][1]) {
            probabilities[i] = 0;
          }
        }
      }
      
      float total = 0;
      for (int i = 0; i < probabilities.length; i++) {
        total += probabilities[i];
      }
      
      if (total == 0) { // if nowhere to go, go back
        x.append(x.get(x.size()-2));
        y.append(y.get(y.size()-2));
      } else {
        removeLoops();
        
        float rand = random(total);
        float shot = 0;
        int choice = 0;
        
        for (int i = 0; i < probabilities.length; i++) {
          shot += probabilities[i];
          
          if (shot > rand) {
            choice = i;
            break;
          }
        }
        
        x.append(lastX + neighbors[choice][0]);
        y.append(lastY + neighbors[choice][1]);
      }      
      
      if (foodTarget < 0) {
        for (int i = 0; i < terrain.foodX.size(); i++) {
          if (sq(terrain.foodX.get(i) - x.get(x.size()-1)) + sq(terrain.foodY.get(i) - y.get(y.size()-1)) < 25) {  
            foundFood = true;
            
            if (x.size() < shortestRoute) {
              shortestRoute = x.size();
            }
          }
        }
      } else {
        if (sq(terrain.foodX.get(foodTarget) - x.get(x.size()-1)) + sq(terrain.foodY.get(foodTarget) - y.get(y.size()-1)) < 25) {  
          foundFood = true;
          foodTarget += 1;
          foodTarget %= terrain.foodX.size();
          
          if (x.size() < shortestRoute) {
            shortestRoute = x.size();
          }
        }
      }
    }
  }
  
  // remove points in memory up until last point that is the same
  void removeLoops() {
    int lastX = x.get(x.size()-1);
    int lastY = y.get(y.size()-1);
    
    for (int i = 0; i < x.size()-1; i++) {
      if (x.get(i) == lastX && y.get(i) == lastY) {
        while (x.size() > i+1) {
          x.remove(i+1);
          y.remove(i+1);
        }
        
        break;
      }
    }
  }
  
  void draw(Terrain terrain) {
    
    // draw trail
    stroke(255, 50);
    noFill();
    
    beginShape();
    for (int i = x.size()-1; i > 0 && i > x.size()-4; i--) {      
      vertex(x.get(i)*terrain.resolution + (terrain.resolution-1)/2, y.get(i)*terrain.resolution + (terrain.resolution-1)/2);
    }
    endShape();
    // */
    
    noStroke();
    
    int xPos = x.get(x.size()-1)*terrain.resolution;
    int yPos = y.get(y.size()-1)*terrain.resolution;
    
    if (foundFood) {
      fill(0);
      rect(xPos + (terrain.resolution-5)/2, yPos + (terrain.resolution-5)/2, 5, 5);
      
      fill(255);
      rect(xPos + (terrain.resolution-3)/2, yPos + (terrain.resolution-3)/2, 3, 3);
    } else {
      fill(0);
      rect(xPos + (terrain.resolution-3)/2, yPos + (terrain.resolution-3)/2, 3, 3);
      
      fill(255);
      rect(xPos + (terrain.resolution-1)/2, yPos + (terrain.resolution-1)/2, 1, 1);
    }
  }
}
