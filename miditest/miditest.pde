import themidibus.*;
MidiBus myBus;

float fader=1;

PVector[] base ;
ArrayList<PVector> points = new ArrayList<PVector>();
float l = 500;
float k;
int t=1;
int w=0;
float time =0;
float zoom =0;
int note = -1;
float weight = 2;
color col;
boolean grow=false;
void setup() {
  //size(700, 600, P3D);
  fullScreen(P3D);
  myBus = new MidiBus(this, "Akai MPD18", -1);
  //baseTetrahedron();
  //baseCube();
  baseDodecahedron();
  //baseRandomCube();
  //baseRandomSphere();
  //baseMixTetrahedronCube();
  noCursor();
  points.add(new PVector(0, 0, 0));

  for (int i =0; i<10000; i++) {
    PVector lastPoint = points.get(points.size()-1);
    int j = round(random(base.length-1));
    points.add(new PVector((lastPoint.x+(k-1)*base[j].x)/k, (lastPoint.y+(k-1)*base[j].y)/k, (lastPoint.z+(k-1)*base[j].z)/k));
  }
  col=color(0,0);
}
void draw() {
  time+=0.001;
  translate(width/2, height/2);
  if (weight!=2) {
    rotateZ(TWO_PI*noise(time-1000));
    rotateY(TWO_PI*noise(time+1000));
    rotateX(TWO_PI*noise(time));
  }
  scale(1+zoom);
  background(0);
  //axis();
  //startpoints();

  stroke(col);
  strokeWeight(weight);
  for (int i = 1; i<points.size(); i++) {
    PVector point = points.get(i);
    point(point.x, point.y, point.z);
  }
  clap(note);
  note =-1;
  if (zoom>-0.1 && grow==false) {
    zoom-=0.001;
  }
  if (grow) {
    zoom+=0.04;
    col=color(0,100,230,fader);
  }
  if(weight==6.1){
    col=color(0,255,0,fader);
  }
}

void axis() {
  stroke(255);
  strokeWeight(1);
  line(-1000, 0, 0, 1000, 0, 0);
  line(0, -1000, 0, 0, 1000, 0);
  line(0, 0, -1000, 0, 0, 1000);
}
void startpoints() {
  stroke(255, 0, 0);
  strokeWeight(3);
  for (int i =0; i<base.length; i++) {
    point(base[i].x, base[i].y, base[i].z);
  }
}
void clap(int note) {
  switch(note) {

  case 6: 
    zoom += 1;
    weight = 3;
    col=color(220);
    grow=false;
    break;
  case 1: 
    zoom = 0.1;
    weight=4;
    col=color(220, 170);
    grow=false;
    break;
  case 4:
    weight = 6;
    col=color(220, 0, 0);
    grow=false;
    break;
  case 5:
    weight =6.1;
    col=color(0, 255, 0, 255/2);
    grow=false;
    zoom=2;
    break;
  case 0:
    zoom=0;
    grow=true;
    weight+= 10;
    col=color(0, 100, 230,fader);
    break;
  }
}
void noteOn(int channel, int pitch, int velocity) {
  pitch -= 36;
  println(pitch);
  note = pitch;
}

void noteOff(int channel, int pitch, int velocity) {
}

void controllerChange(int channel, int number, int value) {
  fader=map(value, 0, 127, 0, 255);
}