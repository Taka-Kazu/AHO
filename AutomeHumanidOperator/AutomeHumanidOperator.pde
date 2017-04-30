import controlP5.*;

ControlP5 slider;
int sliderValue;

State state;
StartState start_state;

void setup() {
  int myColor = color(255, 0, 0);

  size(1200, 700); 
  slider = new ControlP5(this);
  
  state = new StartState();
}

void draw() {
   state = state.doState();
}

abstract class State
{
  State(){
    
  }
  State doState(){
    drawState();
    return decideState();
  }
  abstract void drawState();
  abstract State decideState();
}

class StartState extends State
{
  void drawState()
  {
    background(0);
    textSize(80);
    text("AutomeHumanoidOperator", width*0.05, height*0.5);
    textSize(30);
    text("click to start", width*0.4, height*0.8);
  }
  
  State decideState()
  {
    if(mousePressed){
      return new MainState();
    }else{
      return this;
    }
  }
}

class MainState extends State
{
  int flag = 0;
  void initialise(){
    if(flag == 0){
      textSize(20);
      slider.addSlider("SERVO0").setRange(0, 180).setValue(90).setPosition(50, 100).setSize(300, 30);
      slider.getController("SERVO0").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO1").setRange(0, 180).setValue(90).setPosition(50, 150).setSize(300, 30);
      slider.getController("SERVO1").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      flag = 1;
    }
  }
  void drawState()
  {
    background(0);
    initialise();
    textSize(20);
    text("main menu", width*0.5, height*0.5);
  }
  
  State decideState()
  {
    return this;
  }
}