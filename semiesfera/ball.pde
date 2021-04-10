class Ball {
  PVector p;
  float radius;

  Ball(PVector pv, float r) {
    p=pv;
    radius=r;
  }
  void show_point(color c) {
    stroke(c);
    strokeWeight(radius);
    point(p.x, p.y, p.z);
  }
  void show_ball(color c) {
    fill(c);
    pushMatrix();
    translate(p.x, p.y, p.z);
    noStroke();
    sphere(radius);
    popMatrix();
  }
}