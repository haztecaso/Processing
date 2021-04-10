float t;
float i, j;
float bi, bj;

float r=1;
void setup() {
  fullScreen();
  background(0);
  stroke(255);
  strokeWeight(2);
  frameRate(1000);
}

void draw() {
  t+=.02;
  r+=.01;
  translate(width/2, height/2);
  i=r*cos(t*cos(r))+t*cos(r+2*cos(t));
  j=r*sin(t+2*sin(r))+t*sin(r+2*sin(t));
  stroke(255);
  line(i, j, bi, bj);
  //point(i,j);
  bi=i;
  bj=j;
}