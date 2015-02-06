Colony colony;
Terrain terrain;

// length of current shortest route
int shortestRoute;

// last key pressed
int currentKey = 0;

void setup() {
  size(800, 450, OPENGL); // 16:9
  
  // set up terrain and ants
  initialize();
}

void initialize() {
  // reseed Perlin noise
  noiseSeed((int)random(10000));
  
  shortestRoute = 10000000;

  // terrain = new Terrain(resolution, 10, 10, new int[]{width/resolution-10, width/resolution-10}, new int[]{height/resolution-10, 10});
  
  // terrain = new Terrain(resolution, "extended_double_bridge.png");
  // terrain = new Terrain(resolution, "split.png");
  // terrain = new Terrain(resolution, "extra_narrow_path.png");
  // terrain = new Terrain(resolution, "narrow_extended_double_bridge.png");
  // terrain = new Terrain(resolution, "random_paths.png");
  // terrain = new Terrain(resolution, "grid.png");
  // terrain = new Terrain(resolution, "open.png");
  terrain = new Terrain(resolution, "open2.png");
  
  colony = new Colony(numberOfAnts, terrain);
}

void update() {
  // move ants  
  for (int n = 0; n < speed; n++) {
    colony.update();
  }
  
  // evaporate pheromones
  for (int n = 0; n < speed; n++) {
    terrain.evaporate();
  }
}

void draw() {
  background(0);
    
  update();
  
  // draw terrain and ants
  if (drawTerrain) terrain.draw();
  if (drawAnts) colony.draw();
 
  // draw some informative text in the upper right corner
  noStroke();
  fill(255);
  textSize(12);
  textAlign(RIGHT);
  
  text(shortestRoute < 10000000 ? shortestRoute+"" : "", width-10, 15);
  text(round(frameRate) + "fps", width-10, 30);
  text(speed, width - 10, 45);
}

void keyPressed() {
  if (keyCode == 65) { // A: toggle ant drawing
    drawAnts = !drawAnts;
  } else if (keyCode == 78) { // N: start new
    initialize();
  } else if (keyCode == 84) { // T: toggle terrain drawing
    drawTerrain = !drawTerrain;
  } else if (keyCode == 83) { // S: save screenshot
    String filename = "ants_" + nf(year(), 4) + nf(month(), 2) + nf(day(), 2) + "_" + nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2) + ".png";
    save(filename);
    println("screenshot saved: " + filename);
  } else if (key == 61) { // +: increase speed
    speed++;
  } else if (key == 45) { // -: decrease speed
    speed--;
  }
  
  currentKey = keyCode;
}

void keyReleased() {
  currentKey = -1; 
}

void mousePressed() {
  if (keyPressed) {
    for (int i = 0; i < terrain.foodX.size(); i++) {
      if (currentKey-49 == i) {
        terrain.foodX.set(i, mouseX/terrain.resolution);
        terrain.foodY.set(i, mouseY/terrain.resolution);
      }
    }
    
    // reset shortest route
    shortestRoute = 10000000;
  }
}
