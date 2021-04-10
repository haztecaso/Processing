FloatDict currentState;
boolean[] buttons = new boolean[3];
int maxLevels = 14;
int maxBranches = 33000;
int nBranch;
int nBranchOld;
int guiHeight;
int oldSeed=-1;
float[] rands = new float[maxBranches];

float t = 0;

boolean save = true;
int frames = 600;

FloatDict stateA, stateB;

void setup() {
    size(5120, 2880);
    /* surface.setResizable(true); */
    frameRate(100);
    buttons[0] = true; //Reset button
    buttons[1] = false;
    buttons[2] = false;
    // Parte I
    stateA = mkStateB();
    stateB = mkRefState();
    // Parte II
    /* stateA = mkRefState(); */
    /* stateB = mkStateBEnd(); */
    currentState = stateA;
}

void draw() {
    currentState = mixStates(stateA,stateB,t);
    setCurrentState();

    int seed = int(v("random seed"));
    randomSeed(seed);
    oldSeed = seed;

    background(255);
    stroke(0);
    strokeWeight(v("stroke weight"));

    pushMatrix();
    translate(0,-v("position"));
    tree(radians(v("angle")));
    popMatrix();

    if(frameCount > 2){
        if(save)
            saveFrame("arbol/######.png");
        println(100*float(frameCount-2)/frames);
        t+= 1.0/frames;
    }
    if (t > 1){
        if (save)
            exit();
        else
            t = 0;
    }
}


FloatDict mkRefState(){
    FloatDict state = new FloatDict();
    state.set("stroke weight",2);
    state.set("size",2.96);
    state.set("position",2);
    state.set("levels",12);

    state.set("grow factor",0.67);
    state.set("grow factor randomness",0.41);
    state.set("angle",50);
    state.set("angle factor",0.98);
    state.set("angle factor randomness",0.01);

    state.set("random seed",15);
    return state;
}

FloatDict mkStateB(){
    FloatDict state = mkRefState();
    state.set("grow factor",0.67);
    state.set("grow factor randomness",0.02);
    state.set("angle",0);
    state.set("angle factor",0.89);
    state.set("angle factor randomness",0.01);
    return state;
}

FloatDict mkStateBEnd(){
    FloatDict state = mkRefState();
    state.set("grow factor",0.92);
    state.set("grow factor randomness",0.64);
    state.set("angle",33);
    state.set("angle factor",1.035);
    state.set("angle factor randomness",0.57);
    return state;
}


float f(int frame){
    return (frame - 2) / 100;
}

FloatDict mixStates(FloatDict a, FloatDict b, float factor){
    FloatDict mix = new FloatDict();
    for (String name : a.keyArray()){
        if (b.get(name)!=a.get(name)){
            mix.set(name,factor*b.get(name)+(1-factor)*a.get(name));
        }
        else{
            mix.set(name, a.get(name));
        }
    }
    return mix;
}

void tree(float a){
    float size = v("size")*200;
    nBranchOld = nBranch;
    nBranch = 0;
    translate(width/2,height);
    line(0,0,0,-size);
    translate(0,-size);
    grow(int(v("levels")),size, a);
}


void grow(int l, float h, float a) {
    if (l <= 0 || nBranch >= maxBranches)
        return;
    simpleBranching(l, h, a);
}

void simpleBranching(int l, float h, float a){
    branch(l, h, a, 1);
    branch(l, h, a, -1);
}

void branch(int l, float s, float a, float k){
    if (nBranch >= maxBranches)
        return;
    pushMatrix();
    a = nextAngle(a);
    rotate(k*a);
    s = nextSize(s);
    line(0, 0, 0, -s);
    translate(0, -s);
    grow(l - 1, s, a);
    popMatrix();
    nBranch++;
}

float nextSize(float s){
    float r = v("grow factor randomness");
    r *= r;
    return s*(v("grow factor")+random(-r,r));
}

float nextAngle(float a){
    float r = v("angle factor randomness");
    r*=r;
    return a*(v("angle factor")+random(-r,r));
}

float v(String name){
    return currentState.get(name);
}

void setCurrentState(){
    for (String name : currentState.keyArray()){
        currentState.set(name,currentState.get(name));
    }
}
