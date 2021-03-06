import peasy.*;

PeasyCam cam;
PVector[] base ;
ArrayList<PVector> points = new ArrayList<PVector>();
float l = 500;
float k;
int t=1;
int w=0;
void setup() {
  //size(700, 600, P3D);
  fullScreen(P3D);
  cam = new PeasyCam(this, 900);

  //baseTetrahedron();
  //baseCube();
  baseDodecahedron();
  //baseRandomCube();
  //baseRandomSphere();
  //baseMixTetrahedronCube();
  noCursor();
}
void draw() {
  background(0);
  //axis();
  //startpoints();

  if (points.size()>0) {
    for (int i =0; i<100; i++) {
      PVector lastPoint = points.get(points.size()-1);
      int j = round(random(base.length-1));

      points.add(new PVector((lastPoint.x+(k-1)*base[j].x)/k, (lastPoint.y+(k-1)*base[j].y)/k, (lastPoint.z+(k-1)*base[j].z)/k));
    }
  } else {
    points.add(new PVector(0, 0, 0));
  }
  stroke(255, 255, 255);
  strokeWeight(2);
  for (int i = 1; i<points.size(); i++) {
    PVector point = points.get(i);
    PVector ppoint = points.get(i-1);
    point(point.x, point.y, point.z);
    //line(ppoint.x, ppoint.y, ppoint.z,point.x, point.y, point.z);
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

void baseDodecahedron() {
  float phi = (1+sqrt(5))/2;
  base =new PVector[20];
  k=4;

  base[0] = new PVector(1, 1, 1 );
  base[1] = new PVector(-1, 1, 1 );
  base[2] = new PVector(-1, -1, 1 );
  base[3] = new PVector(1, -1, 1 );
  base[4] = new PVector(1, 1, -1 );
  base[5] = new PVector(-1, 1, -1 );
  base[6] = new PVector(-1, -1, -1 );
  base[7] = new PVector(1, -1, -1 );

  base[8] = new PVector(0, 1/phi, phi);
  base[9] = new PVector(0, -1/phi, phi);
  base[10] = new PVector(0, 1/phi, -phi);
  base[11] = new PVector(0, -1/phi, -phi);
  base[12] = new PVector(1/phi, phi, 0);
  base[13] = new PVector(-1/phi, phi, 0);
  base[14] = new PVector(1/phi, -phi, 0);
  base[15] = new PVector(-1/phi, -phi, 0);
  base[16] = new PVector(phi, 0, 1/phi );
  base[17] = new PVector(-phi, 0, 1/phi );
  base[18] = new PVector(phi, 0, -1/phi );
  base[19] = new PVector(-phi, 0, -1/phi );
  for (int i =0; i<base.length; i++) {
    base[i].setMag(l/sqrt(3));
  }
}

void baseCube() {
  base =new PVector[8];
  k=2.7;
  base[0] = new PVector(l/2, l/2, l/2);
  base[1] = new PVector(-l/2, l/2, l/2);
  base[2] = new PVector(-l/2, -l/2, l/2);
  base[3] = new PVector(l/2, -l/2, l/2);

  base[4] = new PVector(l/2, l/2, -l/2);
  base[5] = new PVector(-l/2, l/2, -l/2);
  base[6] = new PVector(-l/2, -l/2, -l/2);
  base[7] = new PVector(l/2, -l/2, -l/2);
}

void baseTetrahedron() {
  base =new PVector[4];
  k=2;
  base[0] = new PVector(2*l/3, 0, -sqrt(6)/9*l);
  base[1] = new PVector(-l/3, l/sqrt(3), -sqrt(6)/9*l);
  base[2] = new PVector(-l/3, -l/sqrt(3), -sqrt(6)/9*l);
  base[3] = new PVector(0, 0, 2*sqrt(6)/9*l);
}

void baseRandomCube() {
  base =new PVector[10];
  k=4;
  for (int i =0; i<10; i++) {
    base[i] = new PVector(random(-1, 1)*l, random(-1, 1)*l, random(-1, 1)*l);
  }
}

void baseRandomSphere() {
  base =new PVector[1000];
  k=10;
  for (int i =0; i<1000; i++) {
    base[i] = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    base[i].setMag(random(l/2, l));
  }
}

void baseMixTetrahedronCube() {
  base = new PVector[120];
  k=3;
  int o=0;
  for (int i =0; i<10; i++) {
    base[4*i] = new PVector(2*l/3, 0, -sqrt(6)/9*l);
    base[4*i+1] = new PVector(-l/3, l/sqrt(3), -sqrt(6)/9*l);
    base[4*i+2] = new PVector(-l/3, -l/sqrt(3), -sqrt(6)/9*l);
    base[4*i+3] = new PVector(0, 0, 2*sqrt(6)/9*l);
  }

  for (int i =0; i<10; i++) {
    base[40+8*i] = new PVector(l/2, l/2, l/2);
    base[40+8*i+1] = new PVector(-l/2, l/2, l/2);
    base[40+8*i+2] = new PVector(-l/2, -l/2, l/2);
    base[40+8*i+3] = new PVector(l/2, -l/2, l/2);
    base[40+8*i+4] = new PVector(l/2, l/2, -l/2);
    base[40+8*i+5] = new PVector(-l/2, l/2, -l/2);
    base[40+8*i+6] = new PVector(-l/2, -l/2, -l/2);
    base[40+8*i+7] = new PVector(l/2, -l/2, -l/2);
  }
  println(o);
}

void next() {
  switch(w) {
  case 0: 
    println("Zero");  // Does not execute
    break;
  case 1: 
    println("One");  // Prints "One"
    break;
  }
}