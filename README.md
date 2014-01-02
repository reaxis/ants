# Ants

![](https://raw.github.com/reaxis/ants/master/screenshots/ants_20131231_123709.png)

A [Processing](http://processing.org) sketch to visualize Ant Colony Optimization.

Ants walk around randomly until they find a food source, then retrace their steps and drop pheromones on the way back. Pheromones are visualized by colored trails.

Tested in Processing 2.1.

### Keys

- **R** reset
- **A** toggle ant drawing
- **T** toggle terrain drawing
- **S** save screenshot
- **+** increase speed
- **-** decrease speed

## To do

- optimize number of ants vs. pheromone evaporation vs. pheromone drop
- comments!
- optimize stuff like sqrt(2)
- remove println()'s in favor of drawing text on screen
- draw shortest route as function of time (see the convergence emerge!)
- get it to p5js
- UI library to tweak algorithm variables during runtime
  - <http://www.sojamo.de/libraries/controlP5/>
  - be able to draw (add/erase) terrain during runtime
  - be able to erase pheromones?
  - sliders/buttons for changing evaporation rate, number of ants, etc.
- remove ant movement loops due to diagonal crossing
- do something interesting with drawing of ant trails/memory


## Ideas

- limit amount of pheromones per cell (this should be smarter)
- pheromone increment based on route length (1/length)
- make ants able to move ground (look into termites)
- blur pheromones for smoother paths? (instead of evaporation?)
- limit amount of pheromones per cell based on highest value somehow (or fastest increase)
- ant movement in separate thread?
- multiple food sources
  - numberOfAnts/foodSources ants assigned to each food source, to look for collective routes, but not preference for a food source
  - maybe even optimize number of ants going for a specific food source based on distance?