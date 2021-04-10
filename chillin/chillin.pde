import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;


ArrayList<Contour> contours;
PImage fondo;
float size=4;
int offset=5;
int vel=2;
void setup() {
  fondo = loadImage("fondo.jpg");
  size(640, 480);
  String[] devices = Capture.list();
  video = new Capture(this, 640/2, 480/2, devices[10]);
  opencv = new OpenCV(this, 640/2, 480/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  

  video.start();
  noStroke();
}

void draw() {
  offset+=vel;
  if (offset>=30 || offset<0){
    vel*=-1;
  }
 
  scale(2);
 image(fondo, 0, 0 );
 opencv.loadImage(video);
  Rectangle[] faces = opencv.detect();
  opencv.gray();
  opencv.threshold(70);
  contours = opencv.findContours();
  strokeWeight(1);
  for (Contour contour : contours) {
    //stroke(0, 255, 0);
    //contour.draw();
    noFill();
    stroke(255, 0, 0, 0);
    beginShape();
    contour.setPolygonApproximationFactor(20);
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
  noStroke();
  for (int i = 0; i < faces.length; i++) {
    for (int a = round(offset); a<faces[i].width-round(offset); a+=size) {
      for (int b = round(offset); b<faces[i].height-round(offset); b+=size) {
        color c = video.get(faces[i].x+a, faces[i].y+b);
        int rc = (c >> 16) & 0xFF;  // Faster way of getting red(argb)
        int gc = (c >> 8) & 0xFF;   // Faster way of getting green(argb)
        int bc = c & 0xFF;          // Faster way of getting blue(argb)
        if (frameCount%2==0) {
          fill(rc, gc, bc);
        } else { 
          fill((gc+bc+rc)/3);
        }
        rect(faces[i].x+a, faces[i].y+b, size, size);
      }
    }
    color c = video.get(faces[i].x+faces[i].width/2, faces[i].y+faces[i].height/2);
    int rc = (c >> 16) & 0xFF;  // Faster way of getting red(argb)
    int gc = (c >> 8) & 0xFF;   // Faster way of getting green(argb)
    int bc = c & 0xFF;          // Faster way of getting blue(argb)
  }
}

void captureEvent(Capture c) {
  c.read();
}