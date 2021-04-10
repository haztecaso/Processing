import peasy.*;
PeasyCam cam;

Curvything c;

//ArrayList<Plane> planes = new ArrayList<Plane>();

ArrayList<PVector> normals = new ArrayList<PVector>();

ArrayList<Ball> balls = new ArrayList<Ball>();
float s = 7;

color blue, red;

boolean showp = false;
boolean showc = true;
float t =0;

void setup() {
  //size(600, 600, P3D);
  //surface.setResizable(true);
  fullScreen(P3D);
  cam = new PeasyCam(this, 900);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(1000);

  noCursor();

  c = new Curvything(300);
  /*while (planes.size()<1) {
   PVector pos = new PVector(0, 0, 0);
   PVector v1 = new PVector(d(), d(), d());
   PVector v2 = new PVector(0, 0, 0);
   Plane p = new Plane(pos, v1.normalize(), new PVector(0, 1, 0), 1000);
   planes.add(p);
   } */

  while (normals.size()<1) {
    PVector n = new PVector();
    n = PVector.random3D();
    normals.add(n);
  }
  int i = 0;
  while (balls.size()<c.get_points().size()) {
    PVector pos = c.get_points().get(i);
    balls.add(new Ball(pos, s));
    i++;
  }
  stroke(255);
  background(0);
  sphereDetail(45);
  blue = color(0, 0, 255);
  red = color(255, 0, 0);
}

void draw() {
  t+=0.02;
  //rotateX(10*noise(t/10, 0));
  //rotateY(10*noise(0, t/10));
  //rotateZ(10*noise(t/10, t/10));
  background(0);
  for (int k = 0; k<normals.size(); k++) {
    PVector normal = normals.get(k);
    for (int n= 0; n<balls.size(); n++) {
      Ball ball = balls.get(n);
      float a = PVector.angleBetween(ball.p, normal);
      ball.show_point(color(a));
    }
    normal.setMag(c.radius);
    showVector(normal, color(255, 0, 255));
  }
  textSize(40);
  fill(255);
  //text(map(cos(t), -1, 1, 0, PI),0,0);
  if (showc) {
    c.display();
  }
  /*  if (showp) {
   for (int n = 0; n<planes.size(); n++) {
   Plane p = planes.get(n);
   pushMatrix();
   translate(p.pos.x, p.pos.y, p.pos.z);
   showVector(p.normal().setMag(1000), color(255, 255, 0));
   popMatrix();
   p.display();
   }
   }*/
}

int d() {
  if (random(-1, 1)>0) {
    return 1;
  } else {
    return -1;
  }
}
void showVector(PVector v, color c) {
  stroke(c);
  strokeWeight(2);
  line(0, 0, 0, v.x, v.y, v.z);
}


void keyPressed() {
  if (key == ' ') {
    showp = !showp;
  }
  if (key == 'c') {
    showc = !showc;
  }
}