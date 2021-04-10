import themidibus.*; //Import the library
int x, y;
int mx=3;
int my=3;
MidiBus myBus; // The MidiBus

void setup() {
  size(1280, 800);
  background(0);
  colorMode(RGB, 255);
  MidiBus.list(); 

  myBus = new MidiBus(this, "Akai MPD18", 0);
}

void draw() {
}

void noteOn(int channel, int pitch, int velocity) {
  pitch-=36;
  if (pitch>15) {
    pitch-=16;
    if (pitch>15) {
      pitch-=16;
    }
  }
  colorMode(HSB, 127);
  fill(map(pitch, 0, 15, 0, 127), 127, velocity);
  y=3-int(pitch/4);
  x=pitch%4;
  println("x "+x+" y "+y);
  rect(width/(mx+1)*x,height/(my+1)*y,width/(mx+1),height/(my+1));
}

void noteOff(int channel, int pitch, int velocity) {
  pitch-=36;
  if (pitch>15) {
    pitch-=16;
    if (pitch>15) {
      pitch-=16;
    }
  }
  colorMode(HSB, 127);
  fill(0);
  y=3-int(pitch/4);
  x=pitch%4;
  println("x "+x+" y "+y);
  delay(50);
  rect(width/4*x,height/4*y,width/4,height/4);
  
 }
 
 
void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
 
