import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;
float x=0.01;
float y=0;
float z=0;

float a=9;
float b=28;
float c=8.0/3.0;

ArrayList<PVector> points = new ArrayList<PVector>();
float t=0;
void setup() {
  size(800, 600, P3D);
  //fullScreen(P3D);
  colorMode(HSB);
  cam= new PeasyCam(this, 500);
  cam.setWheelScale(0.1);
  frameRate(300);
}
void draw() {
  background(0);
  float dt=0.007;
  //t+=0.01;
  float dx=(a * (y - x))*dt;
  float dy=(x * (b - z) - y)*dt;
  float dz=(x * y - c * z)*dt;
  x+=dx;
  y+=dy;
  z+=dz;
  points.add(new PVector(x, y, z));

  scale(5);
  rotateX(1.45);
  stroke(255);
  noFill();
  float c=0;
  float i=0;
  beginShape();
  for (PVector v : points) {
    stroke(c, 255, 255);
    vertex(v.x+cos(i), -v.z*((sin(t)+1)), v.y*sin(i));
    c+=0.5;
    i+=0.01;
    if (c>255) {
      c=0;
    }
  }
  endShape();
  println(cam.getDistance());
}