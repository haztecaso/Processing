void setup() {
  size(400, 400, P3D); 
  
}

void draw() {
  background(5);
  lights();
  stroke(52, 389);
  translate(width/2, height/2, 0);
  rotateX(mouseY * 0.05);
  rotateY(mouseX * 0.05);

  sphereDetail(mouseX / 20);
  sphere(120);
}