import peasy.*;

PeasyCam cam;
PVector i, j, k, v;
float zoom = 100;
float t=0;
void setup() {
  size(700, 600, P3D);
  cam = new PeasyCam(this, 300);
  i = new PVector(1, 0, 0);
  j = new PVector(0, 1, 0);
  k = new PVector(0, 0, 1);
  v = new PVector(random(1), random(1), random(1));
  i.setMag(zoom);
  j.setMag(zoom);
  k.setMag(zoom);
  v.setMag(zoom);
}
void draw() {
  t+=0.01;
  background(255);
  stroke(0);
  line(0, 0, 0, i.x, i.y, i.z);
  line(0, 0, 0, j.x, j.y, j.z);
  line(0, 0, 0, k.x, k.y, k.z);
  stroke(200, 200, 0);
  line(0, 0, 0, v.x, v.y, v.z);
  v.x=100*noise(t)-50;
  v.y=100*noise(t+1000)-50;
  v.z=100*noise(t-1000)-50;
}