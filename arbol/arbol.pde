import controlP5.*;
ControlP5 cp5;
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

boolean animate = false;

FloatDict stateA, stateB;

void setup() {
    size(1280, 800);
    surface.setResizable(true);
    frameRate(100);
    buttons[0] = true; //Reset button
    buttons[1] = false;
    buttons[2] = false;
    gui();
    stateA = mkRefState();
    stateB = mkStateB();
    currentState = stateA;
    setState(currentState);
}

void draw() {
    if(animate){
        setState(currentState);
        /* currentState = mixStates(stateA,stateB,t); */
        currentState = mixStates(stateB,stateA,t);
    }

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

    /*
    if(nBranch != nBranchOld) {
        print("tree with ");
        print(nBranch);
        println(" branches.");
    }
    */
    if(frameCount > 2 && animate){
    /* saveFrame("arbol/######.png"); */
    println(t);
    t+= 0.01;
    }
    if (t > 1 && animate){
        noLoop();
        println(frameCount);
    }
}


FloatDict mkRefState(){
    FloatDict state = new FloatDict();
    state.set("stroke weight",1.42);
    state.set("size",1.48);
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
    FloatDict state = new FloatDict();
    state.set("stroke weight",1.42);
    state.set("size",1.48);
    state.set("position",2);
    state.set("levels",12);
    state.set("grow factor",0.67);
    state.set("grow factor randomness",0.41);
    state.set("angle",50);
    state.set("angle factor",0.45);
    state.set("angle factor randomness",0.01);
    state.set("random seed",15);
    return state;
}

float f(int frame){
    return (frame - 2) / 100;
    }

FloatDict mixStates(FloatDict a, FloatDict b, float factor){
    FloatDict mix = new FloatDict();
    for (String name : a.keyArray()){
        mix.set(name,factor*b.get(name)+(1-factor)*a.get(name));
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
    /* simpleBranching3(l, h, a); */
    /* simpleBranching4(l, h, a); */
    /* randomBranchingA(l, h, a); */
    /* randomBranchingB(l, h, a); */
}

void simpleBranching(int l, float h, float a){
    branch(l, h, a, 1);
    branch(l, h, a, -1);
}

void simpleBranching3(int l, float h, float a){
    branch(l, h, a, 1);
    branch(l, h, a, 0);
    branch(l, h, a, -1);
}

void simpleBranching4(int l, float h, float a){
    branch(l, h, a, 1);
    branch(l, h/v("grow factor"), a, 0.333);
    branch(l, h/v("grow factor"), a, -0.333);
    branch(l, h, a, -1);
}

void randomBranchingA(int l, float h, float a){
    // TO FIX
    if (random(1)>0.66)
        branch(l, h, a, 0.333);
    if (random(1)>0.66)
        branch(l, h, a, -0.333);
    if (random(1)>0.33)
        branch(l, h, a, 1);
    if (random(1)>0.33)
        branch(l, h, a, -1);
    if (random(1)>0.9)
        branch(l, h, a, -1.5);
    if (random(1)>0.9)
        branch(l, h, a, 1.5);
}

void randomBranchingB(int l, float h, float a){
    int max = int(random(1,4));
    for (int i = 0; i < max; i++)
        branch(l, h, a, random(-1,1));
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
    return cp5.getController(name).getValue();
}

void s(String name, float value){
    cp5.getController(name).setValue(value);
}

void m(String name, float delta){
    cp5.getController(name).setValue(v(name)+delta);
}

void setState(FloatDict state){
    for (String name : state.keyArray()){
        cp5.getController(name).setValue(state.get(name));
    }
}

void gui(){
    cp5 = new ControlP5(this);
    int sliderWidth = 200;
    int sliderHeight = 18;
    int sep = 10;
    int offset = 10;
    int y = sep;
    color textColor = color(0);
    cp5.addSlider("stroke weight")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,5)
        .setValue(1)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("size")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,2)
        .setValue(1)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("position")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,600)
        .setValue(0)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("levels")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(1,maxLevels)
        .setValue(7)
        /* .setNumberOfTickMarks(maxLevels) */
        .showTickMarks(false)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("grow factor")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,1.5)
        .setValue(0.66)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("grow factor randomness")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,1)
        .setValue(0)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("angle")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,120)
        .setValue(30)
        /* .setNumberOfTickMarks(121) */
        .showTickMarks(false)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("angle factor")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,1.5)
        .setValue(1)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("angle factor randomness")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,1)
        .setValue(0)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    cp5.addSlider("random seed")
        .setPosition(offset,y)
        .setSize(sliderWidth,sliderHeight)
        .setRange(0,200)
        .setValue(0)
        /* .setNumberOfTickMarks(201) */
        .showTickMarks(false)
        .getCaptionLabel().setColor(textColor)
        ;
    y += sliderHeight + sep;
    int buttonWidth = (sliderWidth+sep)/2-offset;
    cp5.addButton("save")
        .setPosition(offset,y)
        .setSize(buttonWidth,sliderHeight)
        .setValue(1)
        ;
    cp5.addButton("load")
        .setPosition(offset+buttonWidth+sep,y)
        .setSize(buttonWidth,sliderHeight)
        .setValue(1)
        ;
    y += sliderHeight + 3*sep;
    /*
    cp5.addButton("animate")
        .setPosition(offset,y)
        .setSize(buttonWidth,sliderHeight)
        .setValue(1)
        ;
    cp5.addButton("export")
        .setPosition(offset+buttonWidth+sep,y)
        .setSize(buttonWidth,sliderHeight)
        .setValue(1)
        ;
    y += sliderHeight + sep;
    */
    guiHeight = y + sep;
}

void guiBackground(){
    noStroke();
    fill(33,255*0.9);
    rect(0, 0, 340, guiHeight);
}

public void reset(int value){
    if(buttons[0]){
        setup();
    }
}

public void load(int value){
    if(buttons[1])
        cp5.loadProperties("arbol.json");
    buttons[1] = true;
}

public void save(int value){
    if(buttons[2])
        cp5.saveProperties("arbol.json");
    buttons[2] = true;
}

public void animate(int value){
    if(buttons[2])
        cp5.saveProperties("arbol.json");
    buttons[2] = true;
}
