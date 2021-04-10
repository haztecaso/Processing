import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;
PeasyCam cam;
float x=0.01;
float y=0;
float z=0;

float a=0.1;
float b=0.1;
float c=14;

ArrayList<PVector> points = new ArrayList<PVector>();
void setup() {
  size(800, 600, P3D);
  colorMode(HSB);
  cam= new PeasyCam(this, 800);
  frameRate(300);
}
void draw() {
  background(0);
  float dt=0.05;
  float dx=(0 - y - z)*dt;
  float dy=(x + a * y)*dt;
  float dz=(b + z * (x - c))*dt;
  x+=dx;
  y+=dy;
  z+=dz;
  points.add(new PVector(x, y, z));

  scale(10);
  strokeWeight(0.1);
  stroke(255);
  noFill();
  float c=0;
  beginShape();
  for (PVector v : points) {
    stroke(255, 255, 255);
    vertex(v.x, v.y, v.z);
    c+=0.5;
    if (c>255) {
      c=0;
    }
  }
  endShape();
}