float t   = 1    ;
float vel = random(100) ;
float y   = 0    ;
float yspeed=2;
int   n   = 600  ;
void setup() {
  println(vel);
  size(400, 600);
  background(0);
  stroke(255, 100);
  strokeWeight(1);
  fill(102);

}
void draw() {
  t+=vel;
  if (y>height||y<0) {
    yspeed*=-1;
  }
  y+=yspeed;
  int i=0;
  while (i<n) {
    i++;
    float x= map(noise(t, i), 0, 1, 0, width);
    point(x, y);
  }
  if(y<height & y%2==0){
  //saveFrame("comb-#####.png");
  }
}

