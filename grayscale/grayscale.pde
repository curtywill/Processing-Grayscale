// Curtiss Williams
// Changes a random 300x300 flower picture into grayscale using three different algorithms in Processing 4.
// Grayscale algorithms from https://www.johndcook.com/blog/2009/08/24/algorithms-convert-color-grayscale/

PImage flower;
PImage[] grayFlowers;
void setup() {
  size(600, 600);
  flower = loadImage("images/flower" + floor(random(1, 7)) + ".png");
  if (flower.width > 300 || flower.height > 300) {
    println("image too big");
    exit();
  }
  flower.loadPixels();
  grayFlowers = new PImage[3];
  for (int i = 0; i < 3; i++) {
    grayFlowers[i] = createImage(300, 300, RGB);
    grayFlowers[i].loadPixels();
  }

  for (int x = 0; x < flower.width; x++) {
    for (int y = 0; y < flower.height; y++) {
      int i = x+y*flower.width;
      float r = red(flower.pixels[i]);
      float g = green(flower.pixels[i]);
      float b = blue(flower.pixels[i]);
      grayFlowers[0].pixels[i] = average(r, g, b);
      grayFlowers[1].pixels[i] = lightness(r, g, b);
      grayFlowers[2].pixels[i] = luminosity(r, g, b);
    }
  }

  for (int i = 0; i < 3; i++) {
    grayFlowers[i].updatePixels();
  }

  image(flower, 0, 0);
  image(grayFlowers[0], 300, 0);
  image(grayFlowers[1], 0, 300);
  image(grayFlowers[2], 300, 300);
  // label each image
  textSize(16);
  fill(0);
  text("original", 20, 20);
  text("average", 320, 20);
  text("lightness", 20, 320);
  text("luminosity", 320, 320);
}

color average(float r, float g, float b) {
  return color((r+g+b)/3);
}

color lightness(float r, float g, float b) {
  return color((max(r, g, b)+min(r, g, b))/2);
}

color luminosity(float r, float g, float b) {
  return color(0.21 * r + 0.72 * g + 0.07 * b);
}
