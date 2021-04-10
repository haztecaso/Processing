import mpe.client.*;
TCPClient client;

void setup() {
  size(640, 360);
  client = new TCPClient(this, "mpe.xml");
  surface.setResizable(true);
  surface.setSize(client.getLWidth(), client.getLHeight());

  randomSeed(1);
  // Starting the client
  client.start();
}
// Reset it called when the sketch needs to start over
void resetEvent(TCPClient c) {
  // the random seed must be identical for all clients
  randomSeed(1);
}

//--------------------------------------
// Keep the motor running... draw() needs to be added in auto mode, even if
// it is empty to keep things rolling.
void draw() {
}

//--------------------------------------
// Triggered by the client whenever a new frame should be rendered.
// All synchronized drawing should be done here when in auto mode.
void frameEvent(TCPClient c) {
  // clear the screen     
  fill(random(255),random(255),random(255));
  ellipse(random(400),random(400),20,20);

}