float angle;


void setup() {
  size(500, 500);
  background(200);
  noStroke();
  // noLoop();
  frameRate(1);
  font = loadFont("arial.ttf"); 
  textFont(font, 20);
}

void draw() {
  background(200);


  for (int i=0;i<4;i++) {
    if (int(random(3))>1) {
      fill(random(100), random(100), 200/4*i+55, 230);
    }
    else if (int(random(2))>0) {
      fill(random(100), 200/4*i+55, random(100), 230);
    }
    else {
      fill(200/4*i+55, random(100), random(100), 230);
    }

    //fill(0, 0, 200/5*i+55, 200/5*i+55);
    angle=radians(random(-2, 2));
    rotate(angle);
    rect(20, height/5*i+10, width-40, height/4);
    rotate(-angle);
  }
  fill(0);

  text("combinatoriaaleatoria.tumblr.com", 20, height-20);
  filter(OPAQUE);
}

