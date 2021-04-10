PImage photo;


void setup() {
  size(1, 1);
  photo = loadImage("photo.jpg");
  photo.loadPixels();
  for (int t = 5; t < 7; t+=1) {
    
    for (int i = int(photo.width/t); i < (t-1)*photo.width/t; i+=1) {
      for (int j = int(photo.height/t); j < (t-1)*photo.height/t; j+=1) {
        float r, g, b;
        int loc=i + j * photo.width;

        r = 255-red(photo.pixels[shift(photo, i, j, 0, 0)]);
        g = 255-green(photo.pixels[shift(photo, i, j, 5, 0)]);
        b = 255-blue(photo.pixels[shift(photo, i, j, 0, 5)]);

        color col=color(r, g, b);

        photo.pixels[loc] = col;
      }
    }
  }
  photo.updatePixels();

  surface.setSize(photo.width, photo.height);
  frameRate(1000);
}

void draw() {

  photo.loadPixels();

  int delta =5;

  for (int i = 0; i < photo.width; i+=1) {
    for (int j = 0; j < photo.height; j+=1) {
      float r, g, b;
      int loc=i + j * photo.width;

      r = red(photo.pixels[shift(photo, i, j, 0, 0)]);
      g = green(photo.pixels[shift(photo, i, j, 0, 0)]);
      b = blue(photo.pixels[shift(photo, i, j, 0, 0)]);

      color col=color(r, g, b);

      photo.pixels[loc] = col;
    }
  }
  photo.updatePixels();
  image(photo, 0, 0);
  noLoop();
}


public int shift(PImage img, int x, int y, int shiftx, int shifty) {
  int loc=x+shiftx + (y+shifty) * photo.width;
  img.loadPixels();
  return constrain(loc, 0, img.pixels.length-1);
}