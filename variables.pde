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
int px = 5;

// ant updates per frame
int speed = 10;

// location of the nest
int nestX = 10;
int nestY = 10;

// initial location of the food
int foodX = 20;
int foodY = 20;

// toggle drawing of ants
boolean drawAnts = true;
