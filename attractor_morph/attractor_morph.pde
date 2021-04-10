import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
import peasy.test.*;
PeasyCam cam;

float xL=0.01;
float yL=0;
float zL=0;

float aL=9;
float bL=28;
float cL=8.0/3.0;

float xR=0.01;
float yR=0;
float zR=0;

float aR=0.1;
float bR=0.1;
float cR=14;

ArrayList<PVector> pointsL = new ArrayList<PVector>();
ArrayList<PVector> pointsR = new ArrayList<PVector>();

float a=1;
float d=0.01;
void setup() {
  size(800, 600, P3D);
  //fullScreen(P3D);
  colorMode(HSB);
  cam= new PeasyCam(this, 500);
  cam.setWheelScale(0.01);
  frameRate(300);
}
void draw() {
  background(0);
  a+=d;
  println(a);
  float dt=0.007;
  float dxL=(aL * (yL - xL))*dt;
  float dyL=(xL * (bL - zL) - yL)*dt;
  float dzL=(xL * yL - cL * zL)*dt;
  xL+=dxL;
  yL+=dyL;
  zL+=dzL;
  pointsL.add(new PVector(xL, yL, zL));

  dt=0.04;
  float dxR=(0 - yR - zR)*dt;
  float dyR=(xR + aR * yR)*dt;
  float dzR=(bR + zR * (xR - cR))*dt;
  xR+=dxR;
  yR+=dyR;
  zR+=dzR;
  pointsR.add(new PVector(xR, yR, zR));
  scale(5);
  stroke(255);
  strokeWeight(0.3);
  noFill();
  float c=0;
  beginShape();
  for (int i  =0; i<pointsL.size(); i++) {
    stroke(c, 255, 255);
    float w = (cos(a/6*PI)+1)/2;
    //float w = a;
    PVector v =new PVector(
      (pointsL.get(i).x-pointsR.get(i).x), 
      (pointsL.get(i).y-pointsR.get(i).y), 
      (pointsL.get(i).z-pointsR.get(i).z)
      );

    vertex(
      pointsR.get(i).x+w*v.x, 
      pointsR.get(i).y+w*v.y, 
      pointsR.get(i).z+w*v.z
      );
    c+=0.5;
    if (c>255) {
      c=0;
    }
  }
  endShape();
}
void mouseClicked() {
  d*=-1;
}