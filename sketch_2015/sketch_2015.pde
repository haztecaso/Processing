int i=0;
int size=0;
void setup() {
  size(600, 400);
  background(0);
  stroke(0);
  fill(255);
  frameRate(10000);
}

void draw() {
  
  if (i<=2015) {
    i++;
    size=int(random(5, 10));
    ellipse(random(size/2, width-size/2), random(size/2, height-size/2), size, size);
  }
}
