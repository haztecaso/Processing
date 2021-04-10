int rect=2;
float x=-rect;
float y;
void setup() {
  size(600, 600);
  background(0);
  fill(255);
  noStroke();
  frameRate(1000000);
}
void draw(){
if(x>width){
  x=0;
  y+=rect;
}
if(y>height){
  y-=height;
}
if(random(10)<1){
  rect(x, y, rect,rect);
}
  x+=rect;
}
