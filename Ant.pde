class Ant {
  // float froIncrement = 0.3;
  
  IntList x = new IntList();
  IntList y = new IntList();
  
  int age = 0;
  
  boolean foundFood = false;
  
  Ant(int nx, int ny) {
    x.append(nx);
    y.append(ny);
  }
  
  void move(Terrain terrain) {    
    /*
    if (age > 10000) {
      age = 0;
      
      x.clear();
      y.clear();
      
      x.append(nestX);
      y.append(nestY);
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
      
      // probabilities for all directions
      float[] probabilities = new float[8];
      
      // !!! REFACTOR
      
      // probabilities are based on pheromones on grid
      probabilities[0] = terrain.grid[lastX][lastY-1]; // up
      probabilities[1] = terrain.grid[lastX+1][lastY]; // right
      probabilities[2] = terrain.grid[lastX][lastY+1]; // down
      probabilities[3] = terrain.grid[lastX-1][lastY]; // left
      
      // penalty for diagonal movement
      float sqrt2 = sqrt(2);
      
      probabilities[4] = terrain.grid[lastX-1][lastY-1] / sqrt2; // left up
      probabilities[5] = terrain.grid[lastX+1][lastY-1] / sqrt2; // right up
      probabilities[6] = terrain.grid[lastX+1][lastY+1] / sqrt2; // right down
      probabilities[7] = terrain.grid[lastX-1][lastY+1] / sqrt2; // left down
      
      // !!! REFACTOR
      
      // don't go back to where you came from
      if (x.size() > 1) {
        if (x.get(x.size() - 2) == lastX && y.get(y.size() - 2) == lastY-1) probabilities[0] = 0;
        if (x.get(x.size() - 2) == lastX+1 && y.get(y.size() - 2) == lastY) probabilities[1] = 0;
        if (x.get(x.size() - 2) == lastX && y.get(y.size() - 2) == lastY+1) probabilities[2] = 0;
        if (x.get(x.size() - 2) == lastX-1 && y.get(y.size() - 2) == lastY) probabilities[3] = 0;
        
        if (x.get(x.size() - 2) == lastX-1 && y.get(y.size() - 2) == lastY-1) probabilities[4] = 0;
        if (x.get(x.size() - 2) == lastX+1 && y.get(y.size() - 2) == lastY-1) probabilities[5] = 0;
        if (x.get(x.size() - 2) == lastX+1 && y.get(y.size() - 2) == lastY+1) probabilities[6] = 0;
        if (x.get(x.size() - 2) == lastX-1 && y.get(y.size() - 2) == lastY+1) probabilities[7] = 0;
      }
      
      float total = 0;
      for (int i = 0; i < probabilities.length; i++) {
        total += probabilities[i];
      }
      
      if (total == 0) {
        x.append(x.get(x.size()-2));
        y.append(y.get(y.size()-2));
      } else {
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
        
        if (choice == 0 || choice == 2) {
          x.append(lastX);
        } else if (choice == 1 || choice == 5 || choice == 6) {
          x.append(lastX+1);
        } else if (choice == 3 || choice == 4 || choice == 7) {
          x.append(lastX-1);
        }
        
        if (choice == 1 || choice == 3) {
          y.append(lastY);
        } else if (choice == 0 || choice == 4 || choice == 5) {
          y.append(lastY-1);
        } else if (choice == 2 || choice == 6 || choice == 7) {
          y.append(lastY+1);
        }
      }
      
      // grid[x.get(x.size()-1)][y.get(y.size()-1)] += increment;
      // grid[x.get(x.size()-1)][y.get(y.size()-1)] += toIncrement;
      
      removeLoops();
      
      if (dist(x.get(x.size()-1), y.get(y.size()-1), terrain.foodX, terrain.foodY) < 5) {
        foundFood = true;
        
        if (x.size() < shortestRoute) {
          shortestRoute = x.size();
        }
      }
    }
  }
  
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
  
  void draw() {
    
    // draw trail
    /* stroke(255, 100);
    for (int i = 1; i < x.size(); i++) {
      line(x.get(i-1)*px, y.get(i-1)*px, x.get(i)*px, y.get(i)*px);
    }
    noStroke(); */
    
    fill(255);
    noStroke();
    
    if (drawAnts) {
      if (foundFood) {
        rect(x.get(x.size()-1)*resolution + (resolution-3)/2, y.get(y.size()-1)*resolution + (resolution-3)/2, 3, 3);
      } else {
        rect(x.get(x.size()-1)*resolution + (resolution-1)/2, y.get(y.size()-1)*resolution + (resolution-1)/2, 1, 1);
      }
    }
  }
}
