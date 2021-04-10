int N = 100;
PVector[] pt = new PVector[N];
float r = 100;
float w = 2;
void setup() {
  size(1240, 760);
  noStroke();
  fill(255);
  for(int i =0; i<N; i++){
    float radius = r*noise(i/2);
    pt[i] = new PVector(width/2+radius*cos(TWO_PI*i/N),height/2+radius*sin(TWO_PI*i/N));
  }
}

void draw() {
  background(0);
   for(int i =0; i<N; i++){
    float radius = r*noise(i/2);
    pt[i] = new PVector(width/2+radius*cos(TWO_PI*i/N),height/2+radius*sin(TWO_PI*i/N));
  }

}
void forma(){
 push();
 beginShape();
 for (int i = 0; i < pt.length; i += 1) {
    ellipse(pt[i].x, pt[i].y, w, w);
    curveVertex(pt[i].x,pt[i].y);
  }
  endShape();
}
