import controlP5.*;

ControlP5 slider;
ControlP5 button_pos0;
ControlP5 button_pos1;
ControlP5 button_pos2;
ControlP5 button_pos3;
ControlP5 button_pos4;
ControlP5 button_pos5;
ControlP5 button_pos6;
ControlP5 button_pos7;
ControlP5 button_pos8;
ControlP5 button_pos9;
ControlP5 button_pos10;
ControlP5 button_pos11;
ControlP5 button_pos12;
ControlP5 button_pos13;
ControlP5 button_pos14;
ControlP5 button_pos15;

ControlP5 button_back;

State state;
MotionState motion_state = new MotionState();
PositionState _POS0 = new PositionState();
PositionState _POS1 = new PositionState();
PositionState _POS2 = new PositionState();
PositionState _POS3 = new PositionState();
PositionState _POS4 = new PositionState();
PositionState _POS5 = new PositionState();
PositionState _POS6 = new PositionState();
PositionState _POS7 = new PositionState();
PositionState _POS8 = new PositionState();
PositionState _POS9 = new PositionState();
PositionState _POS10 = new PositionState();
PositionState _POS11 = new PositionState();
PositionState _POS12 = new PositionState();
PositionState _POS13 = new PositionState();
PositionState _POS14 = new PositionState();
PositionState _POS15 = new PositionState();

void setup() {
  size(1980, 1200); 
  slider = new ControlP5(this);
  button_pos0 = new ControlP5(this);
  button_pos1 = new ControlP5(this);
  button_pos2 = new ControlP5(this);
  button_pos3 = new ControlP5(this);
  button_pos4 = new ControlP5(this);
  button_pos5 = new ControlP5(this);
  button_pos6 = new ControlP5(this);
  button_pos7 = new ControlP5(this);
  button_pos8 = new ControlP5(this);
  button_pos9 = new ControlP5(this);
  button_pos10 = new ControlP5(this);
  button_pos11 = new ControlP5(this);
  button_pos12 = new ControlP5(this);
  button_pos13 = new ControlP5(this);
  button_pos14 = new ControlP5(this);
  button_pos15 = new ControlP5(this);
  button_back = new ControlP5(this);
  state = new StartState(motion_state);
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
  State pointer;
  StartState(State s)
  {
    pointer = s;
  }
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
      return pointer;
    }else{
      return this;
    }
  }
}

class MotionState extends State
{
  State pointer;
  int flag = 0;
  float OFFSET_X = 300;
  float ELEMENT_X = 150;
  float OFFSET_Y = 150;
  float ELEMENT_Y = 100;
  void initialise(){
    if(flag == 0){
      pointer = this;
      button_pos0.addButton("POS0").setLabel("POS0").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*0).setSize(100, 40);
      button_pos1.addButton("POS1").setLabel("POS1").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*0).setSize(100, 40);
      button_pos2.addButton("POS2").setLabel("POS2").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*0).setSize(100, 40);
      button_pos3.addButton("POS3").setLabel("POS3").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*0).setSize(100, 40);
      button_pos4.addButton("POS4").setLabel("POS4").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*1).setSize(100, 40);
      button_pos5.addButton("POS5").setLabel("POS5").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*1).setSize(100, 40);
      button_pos6.addButton("POS6").setLabel("POS6").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*1).setSize(100, 40);
      button_pos7.addButton("POS7").setLabel("POS7").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*1).setSize(100, 40);
      button_pos8.addButton("POS8").setLabel("POS8").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*2).setSize(100, 40);
      button_pos9.addButton("POS9").setLabel("POS9").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*2).setSize(100, 40);
      button_pos10.addButton("POS10").setLabel("POS10").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*2).setSize(100, 40);
      button_pos11.addButton("POS11").setLabel("POS11").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*2).setSize(100, 40);
      button_pos12.addButton("POS12").setLabel("POS12").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*3).setSize(100, 40);
      button_pos13.addButton("POS13").setLabel("POS13").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*3).setSize(100, 40);
      button_pos14.addButton("POS14").setLabel("POS14").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*3).setSize(100, 40);
      button_pos15.addButton("POS15").setLabel("POS15").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*3).setSize(100, 40);
      flag = 1;
    }
  }
  
  void drawState()
  {
    background(0);
    initialise();
    textSize(20);
    text("MotionEditor", 50, 50);
  }
  
  State decideState()
  {
    if(pointer != this){
      flag = 0;
    }
    return pointer;
  }  
  
  void setNextState(State s)
  {
    button_pos0.remove("POS0");
    button_pos1.remove("POS1");
    button_pos2.remove("POS2");
    button_pos3.remove("POS3");
    button_pos4.remove("POS4");
    button_pos5.remove("POS5");
    button_pos6.remove("POS6");
    button_pos7.remove("POS7");
    button_pos8.remove("POS8");
    button_pos9.remove("POS9");
    button_pos10.remove("POS10");
    button_pos11.remove("POS11");
    button_pos12.remove("POS12");
    button_pos13.remove("POS13");
    button_pos14.remove("POS14");
    button_pos15.remove("POS15");
    pointer = s;
  }
}

class PositionState extends State
{
  float OFFSET_X = 100;
  float ELEMENT_X =350;
  float OFFSET_Y = 150;
  float ELEMENT_Y = 100;
  int flag = 0;
  State pointer;
  void initialise(){
    if(flag == 0){
      pointer = this;
      button_back.addButton("BACK").setLabel("BACK").setPosition(50, 40).setSize(100, 40);
      slider.addSlider("SERVO0").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*0).setSize(300, 30);
      slider.getController("SERVO0").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO1").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*0).setSize(300, 30);
      slider.getController("SERVO1").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO2").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*0).setSize(300, 30);
      slider.getController("SERVO2").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO3").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*0).setSize(300, 30);
      slider.getController("SERVO3").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO4").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*1).setSize(300, 30);
      slider.getController("SERVO4").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO5").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*1).setSize(300, 30);
      slider.getController("SERVO5").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO6").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*1).setSize(300, 30);
      slider.getController("SERVO6").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO7").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*1).setSize(300, 30);
      slider.getController("SERVO7").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO8").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*2).setSize(300, 30);
      slider.getController("SERVO8").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO9").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*2).setSize(300, 30);
      slider.getController("SERVO9").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO10").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*2).setSize(300, 30);
      slider.getController("SERVO10").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO11").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*2).setSize(300, 30);
      slider.getController("SERVO11").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO12").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*3).setSize(300, 30);
      slider.getController("SERVO12").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO13").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*3).setSize(300, 30);
      slider.getController("SERVO13").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO14").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*3).setSize(300, 30);
      slider.getController("SERVO14").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO15").setRange(0, 180).setValue(90).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*3).setSize(300, 30);
      slider.getController("SERVO15").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      flag = 1;
    }
  }
  void drawState()
  {
    background(0);
    initialise();
    textSize(20);
    text("position menu", width*0.5, height*0.5);
  }
  
  State decideState()
  {
    if(pointer != this){
      flag = 0;
    }
    return pointer;
  }
  void setNextState(State s)
  {
    button_back.remove("BACK");
    slider.remove("SERVO0");
    slider.remove("SERVO1");
    pointer = s;
  }
}

void BACK()
{
  _POS0.setNextState(motion_state);
  _POS1.setNextState(motion_state);
  _POS2.setNextState(motion_state);
  _POS3.setNextState(motion_state);
  _POS4.setNextState(motion_state);
  _POS5.setNextState(motion_state);
  _POS6.setNextState(motion_state);
  _POS7.setNextState(motion_state);
  _POS8.setNextState(motion_state);
  _POS9.setNextState(motion_state);
  _POS10.setNextState(motion_state);
  _POS11.setNextState(motion_state);
  _POS12.setNextState(motion_state);
  _POS13.setNextState(motion_state);
  _POS14.setNextState(motion_state);
  _POS15.setNextState(motion_state);
}

void POS0()
{
    motion_state.setNextState(_POS0);
}

void POS1()
{
    motion_state.setNextState(_POS1);
}
  
void POS2()
{
    motion_state.setNextState(_POS2);
}

void POS3()
{
    motion_state.setNextState(_POS3);
}

void POS4()
{
    motion_state.setNextState(_POS4);
}
  
void POS5()
{
    motion_state.setNextState(_POS5);
}
void POS6()
{
    motion_state.setNextState(_POS6);
}

void POS7()
{
    motion_state.setNextState(_POS7);
}
  
void POS8()
{
    motion_state.setNextState(_POS8);
}
void POS9()
{
    motion_state.setNextState(_POS9);
}

void POS10()
{
    motion_state.setNextState(_POS10);
}
  
void POS11()
{
    motion_state.setNextState(_POS11);
}

void POS12()
{
    motion_state.setNextState(_POS12);
}

void POS13()
{
    motion_state.setNextState(_POS13);
}
  
void POS14()
{
    motion_state.setNextState(_POS14);
}

void POS15()
{
    motion_state.setNextState(_POS15);
}