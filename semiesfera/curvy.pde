class Curvything {
  float radius;

  Curvything(float r) {
    radius=r;
  }
  void display() {
    stroke(255);
    strokeWeight(2);
    for (float x=-radius; x<radius; x+=10) {
      for (float y=-radius; y<radius; y+=10) {
        float d = pow(radius, 2)-pow(x, 2)-pow(y, 2);
        if (d>0) {
          float z=sqrt(d);
          point(x, y, z);
          point(x, y, -z);
        }
      }
    }
  }
  void display_volume() {
    stroke(255);
    strokeWeight(2);
    for (float x=-radius; x<radius; x+=10) {
      for (float y=-radius; y<radius; y+=10) {
        float d = pow(radius, 2)-pow(x, 2)-pow(y, 2);
        if (d>0) {
          float z=sqrt(d);

          point(x, y, z);
          point(x, y, -z);
        }
      }
    }
  }
  public ArrayList<PVector> get_points() {
    ArrayList<PVector> result=new ArrayList<PVector>();
    for (float x=-radius; x<radius; x+=10) {
      for (float y=-radius; y<radius; y+=10) {
        float d = pow(radius, 2)-pow(x, 2)-pow(y, 2);
        if (d>0) {
          float z=sqrt(d);
          result.add(new PVector(x, y, z));
          result.add(new PVector(x, y, -z));
        }
      }
    }
    return result;
  }
  void display_parametric() {
    stroke(255);
    strokeWeight(2);
    for (float i = 0; i<TWO_PI; i+=0.1) {
      for (float j = 0; j<TWO_PI; j+=0.1) {
        float x = radius*cos(i)*sin(j);
        float y = radius*sin(i)*sin(j);
        float z = radius*cos(j);
        point(x, y, z);
      }
    }
  }

  void displays() {
    noStroke();
    fill(255, 255, 255, 255/2);
    lights();
    sphere(radius);
  }
  public boolean inside(PVector p) {
    boolean result;

    if (pow(p.x, 2)+pow(p.y, 2)+pow(p.z, 2)>pow(radius, 2)) {
      result = false;
    } else {
      result = true;
    }
    return result;
  }
  public float[] coords(float omega, float theta) {
    float[] result = new float[3];
    result[0]=radius*cos(omega)*sin(theta);
    result[1]=radius*sin(omega)*sin(theta);
    result[2]=radius*cos(theta);
    return result;
  }
}