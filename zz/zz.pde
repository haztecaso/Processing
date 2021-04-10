int n = 10;
float v;
float s;
float t = 0;
PImage img;
void setup() {
  size(700, 700);
  noStroke();
  v = width/n/3;
  s = (width+height)/2-(n+1)*v;
  background(0);
  t+=0.001;
  n*=2;
  v = width/n/3;
  s = (width+height)/2-(n+1)*v;

  for (int i =1; i<=n; i++) {
    for (int j =1; j<=n; j++) {
      fill(map(i, 0, n, 130, 0), map(i, 0, n, 0, 255), 255, 15);
      rect(i*v, height-i*v, s, -s);
    }
  }
  n/=2;
  v = width/n/3;
  s = (width+height)/2-(n+1)*v;

  for (int i =1; i<=n; i++) {
    for (int j =1; j<=n; j++) {
      fill(map(i, 0, n, 255, 0), map(i, 0, n, 100, 0), 0, 10);
      rect(i*v, height-i*v, s, -s);
    }
  }
  frameRate(10000);
}
void draw() {
  filter(BLUR, 5); 
  filter(POSTERIZE, 2);
  for (int i =1; i<=n; i++) {
    for (int j =1; j<=n; j++) {
      fill(random(255),random(255),  random(255), 15);
      rect(i*v, height-i*v,random(s), -random(s));
    }
  }
}