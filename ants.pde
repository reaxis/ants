Colony colony;
Terrain terrain;

// length of current shortest route
int shortestRoute;

void setup() {
  size(800, 450, OPENGL); // 16:9
  
  // set up terrain and ants
  initialize();
}

void draw() {
  background(0);
    
  // move ants  
  for (int n = 0; n < speed; n++) {
    colony.update();
  }
  
  // evaporate pheromones
  for (int n = 0; n < speed; n++) {
    terrain.evaporate();
  }
  
  // draw terrain and ants
  if (drawTerrain) terrain.draw();
  if (drawAnts) colony.draw();
 
  // draw some informative text in the upper right corner
  noStroke();
  fill(255);
  textSize(12);
  textAlign(RIGHT);
  
  text(((shortestRoute < 10000000) ? shortestRoute+"" : ""), width-10, 15);
  text(round(frameRate) + "fps", width-10, 30);
  text(speed, width - 10, 45);
}

void keyPressed() {
  if (keyCode == 82) { // R: reset
    initialize();
  } else if (keyCode == 66) { // B: erode terrain
    terrain.erode();
  } else if (keyCode == 65) { // A: toggle ant drawing
    drawAnts = !drawAnts;
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
}

void mousePressed() {
  if (keyPressed) {    
    terrain.foodX = mouseX/terrain.resolution;
    terrain.foodY = mouseY/terrain.resolution;
    
    // reset shortest route
    shortestRoute = 10000000;
  }
  
  // !!! INCORPORATE THIS INTO TEXT DRAWING ON SCREEN!!!
  
  // println((int)(mouseX/px), (int)(mouseY/px), grid[(int)(mouseX/px)][(int)(mouseY/px)], " max: ", highest, " shortest ", shortestRoute);
}
