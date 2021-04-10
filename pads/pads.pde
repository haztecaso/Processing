


int[] pads= new int[12];
char[] keys= new char[12];
int padx=150;
int pady=100;
int margin=15;

int a, b, c, d, e, f, g;
void setup() {
  size(1020, 475);
  noStroke();
  fill(150);




  //Keys of pads
  //Line 1
  keys[0]='1';
  keys[1]='2';
  keys[2]='3';
  //Line 2
  keys[3]='q';
  keys[4]='w';
  keys[5]='e';
  //Line 3
  keys[6]='a';
  keys[7]='s';
  keys[8]='d';
  //Line 4
  keys[9]='z';
  keys[10]='x';
  keys[11]='c';
}
void draw() {
  background(10);
  fill(100);
  rect(0, 0, 510, 475);

  fill(50);

  //Line 1
  rect(margin, margin, padx, pady);
  rect(margin*2+padx, margin, padx, pady);
  rect(margin*3+padx*2, margin, padx, pady);

  //Line 2
  rect(margin, margin*2+pady, padx, pady);
  rect(margin*2+padx, margin*2+pady, padx, pady);
  rect(margin*3+padx*2, margin*2+pady, padx, pady);

  //Line 3
  rect(margin, margin*3+pady*2, padx, pady);
  rect(margin*2+padx, margin*3+pady*2, padx, pady);
  rect(margin*3+padx*2, margin*3+pady*2, padx, pady);

  //Line 4
  rect(margin, margin*4+pady*3, padx, pady);
  rect(margin*2+padx, margin*4+pady*3, padx, pady);
  rect(margin*3+padx*2, margin*4+pady*3, padx, pady);

  fill(150);

  //Line 1
  if (pads[0]==1) {
    rect(margin, margin, padx, pady);
    fill(255, 0, 0);
    rect(510, 0, 510, 490);
    fill(150);
  }
  if (pads[1]==1) {
    rect(margin*2+padx, margin, padx, pady);
    fill(0, 255, 0);
    rect(510, 0, 510, 490/2);
    fill(150);
  }
  if (pads[2]==1) {
    rect(margin*3+padx*2, margin, padx, pady);
  }

  //Line 2
  if (pads[3]==1) {
    rect(margin, margin*2+pady, padx, pady);
  }
  if (pads[4]==1) {
    rect(margin*2+padx, margin*2+pady, padx, pady);
  }
  if (pads[5]==1) {
    rect(margin*3+padx*2, margin*2+pady, padx, pady);
  }

  //Line 3
  if (pads[6]==1) {
    rect(margin, margin*3+pady*2, padx, pady);
  }
  if (pads[7]==1) {
    rect(margin*2+padx, margin*3+pady*2, padx, pady);
  }
  if (pads[8]==1) {
    rect(margin*3+padx*2, margin*3+pady*2, padx, pady);
  }

  //Line 4
  if (pads[9]==1) {
    rect(margin, margin*4+pady*3, padx, pady);
  }
  if (pads[10]==1) {
    rect(margin*2+padx, margin*4+pady*3, padx, pady);
  }
  if (pads[11]==1) {
    rect(margin*3+padx*2, margin*4+pady*3, padx, pady);
  }
}



















void keyPressed() {
  //Line 1
  println(key);
  if (key == keys[0]) {
    pads[0]=1;
  }
  if (key == keys[1]) {
    pads[1]=1;
  }
  if (key == keys[2]) {
    pads[2]=1;
  }

  //Line 2
  if (key == keys[3]) {
    pads[3]=1;
  }
  if (key == keys[4]) {
    pads[4]=1;
  }
  if (key == keys[5]) {
    pads[5]=1;
  }

  //Line 3
  if (key == keys[6]) {
    pads[6]=1;
  }
  if (key == keys[7]) {
    pads[7]=1;
  }
  if (key == keys[8]) {
    pads[8]=1;
  }

  //Line 4
  if (key == keys[9]) {
    pads[9]=1;
  }
  if (key == keys[10]) {
    pads[10]=1;
  }
  if (key == keys[11]) {
    pads[11]=1;
  }
}

void keyReleased() {
  //Line 1
  if (key == keys[0]) {
    pads[0]=0;
  }
  if (key == keys[1]) {
    pads[1]=0;
  }
  if (key == keys[2]) {
    pads[2]=0;
  }

  //Line 2
  if (key == keys[3]) {
    pads[3]=0;
  }
  if (key == keys[4]) {
    pads[4]=0;
  }
  if (key == keys[5]) {
    pads[5]=0;
  }

  //Line 3
  if (key == keys[6]) {
    pads[6]=0;
  }
  if (key == keys[7]) {
    pads[7]=0;
  }
  if (key == keys[8]) {
    pads[8]=0;
  }

  //Line 4
  if (key == keys[9]) {
    pads[9]=0;
  }
  if (key == keys[10]) {
    pads[10]=0;
  }
  if (key == keys[11]) {
    pads[11]=0;
  }
}

