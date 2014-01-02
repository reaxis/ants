// algorithm

// colony size
int numberOfAnts = 1000;

// amount of pheromones dropped by ant on way back
float pheromoneIncrement = 0.3;

// rate of pheromone evaporation
float evaporationRate = 0.9999;

// limit of pheromone value per grid cell
float pheromoneLimit = 30;



// UI

// pixel to grid ratio
int resolution = 5;

// ant updates per frame
int speed = 10;

// toggle drawing of ants
boolean drawAnts = true;
boolean drawTerrain = true;

public static final float SQRT2 = sqrt(2);
