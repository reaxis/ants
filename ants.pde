// the grid, containing terrain and pheromone data
float[][] grid;

// the ants
Ant[] colony;

// length of shortest route
int shortestRoute;

// highest amount of pheromone on a grid cell
float highest;

void setup() {
  size(800, 450, OPENGL);
  
  initialize();
}

void draw() {
  background(0);
  
  // !!! UPDATE FUNCTIONS (separate thread?)
  
  // update ants  
  for (int n = 0; n < speed; n++) {
    for (int i = 0; i < colony.length; i++) { 
      colony[i].move();
    }
  }
  
  // update grid and find out highest pheromone value
  
  highest = 1;
  
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {      
      grid[x][y] *= pow(evaporationRate, speed); // evaporate as many steps as ants updated
      
      /*
      // limit amount of pheromones
      if (grid[x][y] > pheromoneLimit) {
        grid[x][y] = pheromoneLimit;
      }
      */
      
      // !!! THIS SHOULD NOT BE NECESSARY IF NO PHEROMONES ARE DROPPED ON NEST
      
      // don't check nest
      if (x != nestX && y != nestY && grid[x][y] > highest) {
        highest = grid[x][y];
      }
      
      // evaporation shouldn't happen below value of 1
      if (grid[x][y] > 0 && grid[x][y] < 1) {
        grid[x][y] = 1;
      }
    }
  }
  
  // !!! DRAWING FUNCTIONS
  
  noStroke();
  
  // draw the grid  
  for (int x = 0; x < grid.length; x++) {
    for (int y = 0; y < grid[x].length; y++) {      
      // fill(grid[x][y] == 0 ? #442200 : #aa6600); // earth tones
      fill(grid[x][y] == 0 ? #333333 : #000000); // black background
      
      rect(x*px, y*px, px, px);
      
      fill(0, 255, 0, map(grid[x][y], 1, highest, 0, 255)); // green as a function of pheromones
      
      rect(x*px, y*px, px, px);
    }
  }
  
  // draw nest
  fill(#ff0000);
  rect(nestX*px, nestY*px, px, px);
  
  // draw food
  fill(0, 0, 255, 50);
  ellipse(foodX*px, foodY*px, 2*px*5, 2*px*5);
  
  pushMatrix();
    
    // to draw ants in center of grid cells 
    translate(px/2, px/2);
    
    // draw ants
    for (int i = 0; i < colony.length; i++) {
      colony[i].draw();
    }
    
  popMatrix();
  
  // draw some informative text in the upper right corner
  
  fill(255);
  textSize(12);
  textAlign(RIGHT);
  text(shortestRoute, width-10, 15);
  // text((int)(mouseX/px) + " " + (int)(mouseY/px), width-10, 30);
  text(round(frameRate) + "fps", width-10, 30);
  text(speed, width - 10, 45);
}

void keyPressed() {  
  if (keyCode == 82) { // R: reset
    initialize();
  } else if (keyCode == 66) { // B: blur terrain
    blurGrid();
  } else if (keyCode == 65) { // A: toggle ant drawing
    drawAnts = !drawAnts;
  } else if (keyCode == 83) { // S: save screenshot
    save("ants-" + random(1) + ".png");
  } else if (key == 61) { // +: increase speed
    speed++;
  } else if (key == 45) { // -: decrease speed
    speed--;
  }
}

void mousePressed() {
  if (keyPressed) {
    println(keyCode);
    
    foodX = mouseX/px;
    foodY = mouseY/px;
    
    // reset shortest route
    shortestRoute = 10000000;
  }
  
  // !!! INCORPORATE THIS INTO TEXT DRAWING ON SCREEN!!!
  
  // println((int)(mouseX/px), (int)(mouseY/px), grid[(int)(mouseX/px)][(int)(mouseY/px)], " max: ", highest, " shortest ", shortestRoute);
}
