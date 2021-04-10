class Plane {
  PVector a;
  PVector b;
  PVector pos;
  float o;

  Plane(PVector p, PVector v1, PVector v2, float offset) {
    a=v1;
    b=v2;
    pos=p;
    o = offset;
  }
  void display() {
    noStroke();
    fill(0, 70, 0);
    PVector pt;
    beginShape();
    pt = ptonplane(-o, -o);
    vertex(pt.x, pt.y, pt.z);
    pt = ptonplane(o, -o);
    vertex(pt.x, pt.y, pt.z);
    pt = ptonplane(o, o);
    vertex(pt.x, pt.y, pt.z);
    pt = ptonplane(-o, o);
    vertex(pt.x, pt.y, pt.z);
    endShape(CLOSE);
  }
  public boolean side(PVector v) {
    boolean result;
    PVector n = this.normal();
    v.dot(n);
    if (v.mag()>0) {
      result=true;
    } else {
      result=false;
    }
    return result;
  }

  public PVector ptonplane(float i, float j) {
    float x = pos.x + i * a.x + j * b.x;
    float y = pos.y + i * a.y + j * b.y;
    float z = pos.z + i * a.z + j * b.z;
    PVector pt = new PVector(x, y, z);
    return pt;
  }

  public PVector normal() {
    PVector n;
    float i = a.y*b.z-b.y*a.z;
    float j = b.x*a.z-a.x*b.z;
    float k = a.x*b.y-b.x*a.y;
    n = new PVector(i, j, k);
    n.setMag(1);
    return n;
  }
}