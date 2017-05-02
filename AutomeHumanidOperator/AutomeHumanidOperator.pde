import controlP5.*;

ControlFont cf;
PrintWriter output;

ControlP5 slider;
ControlP5 button_pos[] = new ControlP5[16];

ControlP5 button_back;
ControlP5 play_pos;
ControlP5 reset_pos;
ControlP5 play_motion;
ControlP5 exit_button;
ControlP5 enable_button;
int POS_NUM = 16;
int SERVO_NUM = 20;

State state;
MotionState motion_state = new MotionState();
PositionState current_pos;
PositionState _POS[] = new PositionState[POS_NUM];

int readable = 0;

void setup() {
  output = createWriter("log.csv");
  size(1600, 900); 
  cf = new ControlFont(createFont("Arial", 20));
  slider = new ControlP5(this);
  for(int i=0;i<POS_NUM;i++)
  {
    button_pos[i] = new ControlP5(this);
    _POS[i] = new PositionState(i);
  }
  button_back = new ControlP5(this);
  play_pos = new ControlP5(this);
  reset_pos = new ControlP5(this);
  play_motion = new ControlP5(this);
  exit_button = new ControlP5(this);
  enable_button = new ControlP5(this);
  state = new StartState(motion_state);
}

void draw() {
   readable = 0;
   state = state.doState();
   readable = 1;
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
    text("AutomeHumanoidOperator", width*0.15, height*0.5);
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
  float OFFSET_X = 400;
  float ELEMENT_X = 200;
  float OFFSET_Y = 250;
  float ELEMENT_Y = 100;
  int UNABLE_COLOR = 0xFF0000FF;
  int ENABLE_COLOR = 0xFFFF00FF;
  void initialise(){
    if(flag == 0){
      pointer = this;
      play_motion.addButton("PLAY_MOTION").setLabel("PLAY").setPosition(OFFSET_X+ELEMENT_X*4, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40);
      exit_button.addButton("EXIT_BUTTON").setLabel("EXIT").setPosition(OFFSET_X+ELEMENT_X*4.75, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40);
      button_pos[0].addButton("POS0").setLabel("POS0").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*0).setSize(100, 40);
      if(_POS[0].enabled == 1){
        button_pos[0].getController("POS0").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[0].getController("POS0").setColorBackground(UNABLE_COLOR);
      }
      button_pos[1].addButton("POS1").setLabel("POS1").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*0).setSize(100, 40);
      if(_POS[1].enabled == 1){
        button_pos[1].getController("POS1").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[1].getController("POS1").setColorBackground(UNABLE_COLOR);
      }
      button_pos[2].addButton("POS2").setLabel("POS2").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*0).setSize(100, 40);
      if(_POS[2].enabled == 1){
        button_pos[2].getController("POS2").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[2].getController("POS2").setColorBackground(UNABLE_COLOR);
      }
      button_pos[3].addButton("POS3").setLabel("POS3").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*0).setSize(100, 40);
      if(_POS[3].enabled == 1){
        button_pos[3].getController("POS3").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[3].getController("POS3").setColorBackground(UNABLE_COLOR);
      }
      button_pos[4].addButton("POS4").setLabel("POS4").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*1).setSize(100, 40);
      if(_POS[4].enabled == 1){
        button_pos[4].getController("POS4").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[4].getController("POS4").setColorBackground(UNABLE_COLOR);
      }
      button_pos[5].addButton("POS5").setLabel("POS5").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*1).setSize(100, 40);
      if(_POS[5].enabled == 1){
        button_pos[5].getController("POS5").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[5].getController("POS5").setColorBackground(UNABLE_COLOR);
      }
      button_pos[6].addButton("POS6").setLabel("POS6").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*1).setSize(100, 40);
      if(_POS[6].enabled == 1){
        button_pos[6].getController("POS6").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[6].getController("POS6").setColorBackground(UNABLE_COLOR);
      }
      button_pos[7].addButton("POS7").setLabel("POS7").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*1).setSize(100, 40);
      if(_POS[7].enabled == 1){
        button_pos[7].getController("POS7").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[7].getController("POS7").setColorBackground(UNABLE_COLOR);
      }
      button_pos[8].addButton("POS8").setLabel("POS8").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*2).setSize(100, 40);
      if(_POS[8].enabled == 1){
        button_pos[8].getController("POS8").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[8].getController("POS8").setColorBackground(UNABLE_COLOR);
      }
      button_pos[9].addButton("POS9").setLabel("POS9").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*2).setSize(100, 40);
      if(_POS[9].enabled == 1){
        button_pos[9].getController("POS9").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[9].getController("POS9").setColorBackground(UNABLE_COLOR);
      }
      button_pos[10].addButton("POS10").setLabel("POS10").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*2).setSize(100, 40);
      if(_POS[10].enabled == 1){
        button_pos[10].getController("POS10").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[10].getController("POS10").setColorBackground(UNABLE_COLOR);
      }
      button_pos[11].addButton("POS11").setLabel("POS11").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*2).setSize(100, 40);
      if(_POS[11].enabled == 1){
        button_pos[11].getController("POS11").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[11].getController("POS11").setColorBackground(UNABLE_COLOR);
      }
      button_pos[12].addButton("POS12").setLabel("POS12").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*3).setSize(100, 40);
      if(_POS[12].enabled == 1){
        button_pos[12].getController("POS12").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[12].getController("POS12").setColorBackground(UNABLE_COLOR);
      }
      button_pos[13].addButton("POS13").setLabel("POS13").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*3).setSize(100, 40);
      if(_POS[13].enabled == 1){
        button_pos[13].getController("POS13").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[13].getController("POS13").setColorBackground(UNABLE_COLOR);
      }
      button_pos[14].addButton("POS14").setLabel("POS14").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*3).setSize(100, 40);
      if(_POS[14].enabled == 1){
        button_pos[14].getController("POS14").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[14].getController("POS14").setColorBackground(UNABLE_COLOR);
      }
      button_pos[15].addButton("POS15").setLabel("POS15").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*3).setSize(100, 40);
      if(_POS[15].enabled == 1){
        button_pos[15].getController("POS15").setColorBackground(ENABLE_COLOR);
      }else{
        button_pos[15].getController("POS15").setColorBackground(UNABLE_COLOR);
      }
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
    for(int i=0;i<POS_NUM;i++){
      String name = "POS" + i;
      button_pos[i].remove(name);
    }
    play_motion.remove("PLAY_MOTION");
    exit_button.remove("EXIT_BUTTON");
    pointer = s;
  }
}

class PositionState extends State
{
  float OFFSET_X = 100;
  float ELEMENT_X =350;
  float OFFSET_Y = 250;
  float ELEMENT_Y = 100;
  float CENTER_ANGLE = 90;
  int flag = 0;
  int id = 0;
  float val[] = new float[SERVO_NUM];
  int enabled = 0;
  
  State pointer;
  
  PositionState(int x)
  {
    id = x;
    resetVal();
  }
  
  void resetVal()
  {
    for(int i=0;i<SERVO_NUM;i++){
      val[i] = CENTER_ANGLE;
    }
    if(flag==0)return;
    for(int i=0;i<SERVO_NUM;i++){
      slider.getController("SERVO"+i).setValue(val[i]);
    }
    
  }
  int getID()
  {
    return id;
  }
  
  void initialise(){
    if(flag == 0){
      pointer = current_pos = this;
      button_back.addButton("BACK").setLabel("BACK").setPosition(50, 40).setSize(100, 40);
      reset_pos.addButton("RESET_POS").setLabel("RESET").setPosition(OFFSET_X+ELEMENT_X*3.5, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40);
      enable_button.addButton("ENABLE").setLabel("ENABLE").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*5.5).setSize(100, 40);
      play_pos.addButton("PLAY_POS").setLabel("PLAY").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40);
      slider.addSlider("SERVO0").setRange(0, 180).setValue(val[0]).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*0).setSize(300, 30);
      slider.getController("SERVO0").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO1").setRange(0, 180).setValue(val[1]).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*0).setSize(300, 30);
      slider.getController("SERVO1").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO2").setRange(0, 180).setValue(val[2]).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*0).setSize(300, 30);
      slider.getController("SERVO2").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO3").setRange(0, 180).setValue(val[3]).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*0).setSize(300, 30);
      slider.getController("SERVO3").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO4").setRange(0, 180).setValue(val[4]).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*1).setSize(300, 30);
      slider.getController("SERVO4").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO5").setRange(0, 180).setValue(val[5]).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*1).setSize(300, 30);
      slider.getController("SERVO5").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO6").setRange(0, 180).setValue(val[6]).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*1).setSize(300, 30);
      slider.getController("SERVO6").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO7").setRange(0, 180).setValue(val[7]).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*1).setSize(300, 30);
      slider.getController("SERVO7").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO8").setRange(0, 180).setValue(val[8]).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*2).setSize(300, 30);
      slider.getController("SERVO8").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO9").setRange(0, 180).setValue(val[9]).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*2).setSize(300, 30);
      slider.getController("SERVO9").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO10").setRange(0, 180).setValue(val[10]).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*2).setSize(300, 30);
      slider.getController("SERVO10").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO11").setRange(0, 180).setValue(val[11]).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*2).setSize(300, 30);
      slider.getController("SERVO11").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO12").setRange(0, 180).setValue(val[12]).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*3).setSize(300, 30);
      slider.getController("SERVO12").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO13").setRange(0, 180).setValue(val[13]).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*3).setSize(300, 30);
      slider.getController("SERVO13").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO14").setRange(0, 180).setValue(val[14]).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*3).setSize(300, 30);
      slider.getController("SERVO14").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO15").setRange(0, 180).setValue(val[15]).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*3).setSize(300, 30);
      slider.getController("SERVO15").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO16").setRange(0, 180).setValue(val[16]).setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*4).setSize(300, 30);
      slider.getController("SERVO16").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO17").setRange(0, 180).setValue(val[17]).setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*4).setSize(300, 30);
      slider.getController("SERVO17").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO18").setRange(0, 180).setValue(val[18]).setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*4).setSize(300, 30);
      slider.getController("SERVO18").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      slider.addSlider("SERVO19").setRange(0, 180).setValue(val[19]).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*4).setSize(300, 30);
      slider.getController("SERVO19").getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
      if(current_pos.enabled == 1){
          enable_button.getController("ENABLE").setColorBackground(0xFFFF0000);
        }else if(current_pos.enabled == 0){
          enable_button.getController("ENABLE").setColorBackground(0xFF0000FF);
      }
      flag = 1;
    }
  }
  void drawState()
  {
    background(0);
    initialise();
    textSize(20);
    text("POS"+id+" setting", width*0.2, height*0.1);
    //read_val();
  }
  
  State decideState()
  {
    if(pointer != this){
      flag = 0;
    }
    return pointer;
  }
  
  void read_val()
  {
    if(readable == 0){
      return;
    }
    for(int i=0;i<SERVO_NUM;i++){
      val[i] = slider.getController("SERVO"+i).getValue();
    }
  }
  
  void setNextState(State s)
  {
    read_val();
    button_back.remove("BACK");
    play_pos.remove("PLAY_POS");
    reset_pos.remove("RESET_POS");
    enable_button.remove("ENABLE");
    for(int i=0;i<SERVO_NUM;i++){
      slider.remove("SERVO"+i);
    }
    pointer = s;
  }
}

void BACK()
{
  for(int i=0;i<POS_NUM;i++){
    if(current_pos.getID() == i)
    {
      _POS[i].setNextState(motion_state);
    }
  }
}

void POS0()
{
    motion_state.setNextState(_POS[0]);
}

void POS1()
{
    motion_state.setNextState(_POS[1]);
}
  
void POS2()
{
    motion_state.setNextState(_POS[2]);
}

void POS3()
{
    motion_state.setNextState(_POS[3]);
}

void POS4()
{
    motion_state.setNextState(_POS[4]);
}
  
void POS5()
{
    motion_state.setNextState(_POS[5]);
}
void POS6()
{
    motion_state.setNextState(_POS[6]);
}

void POS7()
{
    motion_state.setNextState(_POS[7]);
}
  
void POS8()
{
    motion_state.setNextState(_POS[8]);
}
void POS9()
{
    motion_state.setNextState(_POS[9]);
}

void POS10()
{
    motion_state.setNextState(_POS[10]);
}
  
void POS11()
{
    motion_state.setNextState(_POS[11]);
}

void POS12()
{
    motion_state.setNextState(_POS[12]);
}

void POS13()
{
    motion_state.setNextState(_POS[13]);
}
  
void POS14()
{
    motion_state.setNextState(_POS[14]);
}

void POS15()
{
    motion_state.setNextState(_POS[15]);
}

void PLAY_MOTION()
{
  
}

void PLAY_POS()
{
  current_pos.read_val();
}

void RESET_POS()
{
  current_pos.resetVal();
}

void EXIT_BUTTON()
{
  output.close();
  exit();
}

void ENABLE()
{
  if(current_pos.enabled == 0){
    current_pos.enabled = 1;
    enable_button.getController("ENABLE").setColorBackground(0xFFFF0000);
  }else if(current_pos.enabled == 1){
    current_pos.enabled = 0;
    enable_button.getController("ENABLE").setColorBackground(0xFF0000FF);
  }else{
    current_pos.enabled = 0;
  }
}