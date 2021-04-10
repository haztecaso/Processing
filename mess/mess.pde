void setup() {
  size(700, 700);
  noStroke();
  frameRate(1);
  background(0);
}
void draw() {
  translate(width/2, height/2);

  for (int a=0; a<10; a++) {
    fill(random(255), random(255), random(255),random(255));
    float s = random(100, 200);
    ellipse(random(-width/3, width/3), random(-height/3, height/3), s, s);
  }
  //filter(BLUR, 1); 
  filter(POSTERIZE, 2);
}