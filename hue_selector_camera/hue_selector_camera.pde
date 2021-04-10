/**
 * HSVColorTracking
 * Greg Borenstein
 * https://github.com/atduskgreg/opencv-processing-book/blob/master/code/hsv_color_tracking/HSVColorTracking/HSVColorTracking.pde
 *
 * Modified by Jordi Tost @jorditost (color selection)
 *
 * University of Applied Sciences Potsdam, 2014
 */

import gab.opencv.*;
import processing.video.*;
import java.awt.Rectangle;
import controlP5.*;

Capture video;
OpenCV opencv;
ControlP5 cp5;
PImage src, colorFilteredImage;
ArrayList<Contour> contours;

//Color to look for
int hue = 30;
int range=3;
int blurvalue=0;
boolean show = false;

// <1> Set the range of Hue values for our filter
int rangeLow = 30;
int rangeHigh = 31;

void setup() {
  background(0);
  video = new Capture(this, 640, 480);
  video.start();

  opencv = new OpenCV(this, video.width, video.height);
  contours = new ArrayList<Contour>();

  size(opencv.width+150, opencv.height, P2D);


  cp5 = new ControlP5(this);
  cp5.addSlider("hueslider")
    .setPosition(opencv.width+10, 10)
      .setSize(100, 20) 
        .setRange(0, 255)
          .setCaptionLabel("Hue")


            ;
  cp5.addSlider("rangeslider")
    .setPosition(opencv.width+10, 40)
      .setSize(100, 20) 
        .setRange(0, 20)
          .setCaptionLabel("Range")
            ;
  cp5.addToggle("blurtoggle")
    .setPosition(opencv.width+10, 70)
      .setSize(20, 20) 
        .setCaptionLabel("Blur")
          ;
  cp5.addToggle("showtoggle")
    .setPosition(opencv.width+10, 100)
      .setSize(20, 20)
        .setCaptionLabel("Video");
}

void draw() {

  // Read last captured frame
  if (video.available()) {
    video.read();
  }

  // <2> Load the new frame of our movie in to OpenCV
  opencv.loadImage(video);

  // Tell OpenCV to use color information
  opencv.useColor();
  src = opencv.getSnapshot();

  // <3> Tell OpenCV to work in HSV color space.
  opencv.useColor(HSB);

  // <4> Copy the Hue channel of our image into 
  //     the gray channel, which we process.
  opencv.setGray(opencv.getH().clone());

  // <5> Filter the image based on the range of 
  //     hue values that match the object we want to track.
  opencv.inRange(rangeLow, rangeHigh);


  // <6> Get the processed image for reference.
  colorFilteredImage = opencv.getSnapshot();
  ///////////////////////////////////////////
  // We could process our image here!
  // See ImageFiltering.pde
  ///////////////////////////////////////////

  // <7> Find contours in our range image.
  //     Passing 'true' sorts them by descending area.
  contours = opencv.findContours(true, true);

  // <8> Display background images
  if (show ==true) {
    image(src, 0, 0);
  } else {
    image(colorFilteredImage, 0, 0);
    filter(BLUR, blurvalue);
  }
  // <9> Check to make sure we've found any contours
  if (contours.size() > 0) {
    // <9> Get the first contour, which will be the largest one
    Contour biggestContour = contours.get(0);

    // <10> Find the bounding box of the largest contour,
    //      and hence our object.
    Rectangle r = biggestContour.getBoundingBox();

    // <11> Draw the bounding box of our object
    noFill(); 
    strokeWeight(2); 
    stroke(255, 0, 0);
    //    rect(r.x, r.y, r.width, r.height);

    // <12> Draw a dot in the middle of the bounding box, on the object.
    noStroke(); 
    fill(255, 0, 0);
    //    ellipse(r.x + r.width/2, r.y + r.height/2, 30, 30);
  }
}

void mousePressed() {
  if (show==true) {
    color c = get(mouseX, mouseY);
    println("r: " + red(c) + " g: " + green(c) + " b: " + blue(c));

    hue = int(map(hue(c), 0, 255, 0, 180));
    println("hue to detect: " + hue);

    rangeLow = hue - range;
    rangeHigh = hue + range;
  }
}


void hueslider(float input) {
  hue = int(input);
  println("hue to detect: " + hue);
  rangeLow = hue - range;
  rangeHigh = hue + range;
}
void rangeslider(float input) {
  range = int(input);
  println("range: " + range);
  rangeLow = hue - range;
  rangeHigh = hue + range;
}

void blurslider(boolean input) {
  if (input==false) {
    blurvalue = 0;
  } else {
    blurvalue = 2;
  }
}

void showtoggle(boolean input) {
  show=input;
}

void keyPressed() {
  switch (key) {
  case 'v': 
    if (show==true) {
      show=false;
    } else {
      show=true;
    }
    break;
  }
}

