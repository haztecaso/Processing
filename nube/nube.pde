float x, y, a, b;

void setup() {
  size(1280, 800);
  background(0);
  stroke(255);
  strokeWeight(2);
  x=width/2;
  y=height/2;
  frameRate(60);
}
void draw() {
  x=width/2;
  y=height/2;
  if (frameCount%3==0){
  saveFrame("video-#.jpg");
  }
  background(0);
  for (int i=0; i<10000; i++) {
    stroke(255, random(150));
    //strokeWeight(int(random(4)));
    x+=a;
    y+=b;
    point(x, y);
    a=random(-1, 1)*5;
    b=random(-1, 1)*5;

    if (x>width) {
      x=width-10;
      x=width/2;
    }
    if (x<0) {
      x=10;
      x=width/2;
    }
    if (y>height) {
      y=height-10;
      y=height/2;
    }
    if (y<0) {
      y=10;
      y=height/2;
    }
  }
}
void keyPressed() {
}
