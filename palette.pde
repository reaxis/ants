color[] palette = {#000000, #550077, #ee0000, #ffff00, #ffffff};
float[] paletteValues = {0, 0.25, 0.5, 0.75, 1};

color colorScale(float a) {
  if (a == 0) return palette[0];
  if (a == 1) return palette[palette.length-1];
  
  for (int i = 0; i < palette.length-1; i++) {
    if (a >= paletteValues[i] && a < paletteValues[i+1]) {
      float normalized = map(a, paletteValues[i], paletteValues[i+1], 0, 1);

      return lerpColor(palette[i], palette[i+1], normalized);
    }
  }
  
  return palette[palette.length-1];
}
