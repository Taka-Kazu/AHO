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
  int POS_GYOU = 4;
  int POS_RETU = 4;
  void initialise(){
    if(flag == 0){
      pointer = this;
      play_motion.addButton("PLAY_MOTION").setLabel("PLAY").setPosition(OFFSET_X+ELEMENT_X*4, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40);
      exit_button.addButton("EXIT_BUTTON").setLabel("EXIT").setPosition(OFFSET_X+ELEMENT_X*4.75, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40);
      for(int i=0;i<POS_GYOU;i++){
        for(int j=0;j<POS_RETU;j++){
          int pos_id = i*POS_RETU+j;
          button_pos[pos_id].addButton("POS"+pos_id).setLabel("POS"+pos_id).setPosition(OFFSET_X+ELEMENT_X*j, OFFSET_Y+ELEMENT_Y*i).setSize(100, 40);
          if(_POS[pos_id].enabled == 1){
            button_pos[pos_id].getController("POS"+pos_id).setColorBackground(ENABLE_COLOR);
          }else{
            button_pos[pos_id].getController("POS"+pos_id).setColorBackground(UNABLE_COLOR);
          }
        }
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
  int SERVO_GYOU = 5;
  int SERVO_RETU = 4;
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
      for(int i=0;i<SERVO_GYOU;i++){
        for(int j=0;j<SERVO_RETU;j++){
          int servo_id = i*SERVO_RETU+j;
          slider.addSlider("SERVO"+servo_id).setRange(0, 180).setValue(val[servo_id]).setPosition(OFFSET_X+ELEMENT_X*j, OFFSET_Y+ELEMENT_Y*i).setSize(300, 30);
          slider.getController("SERVO"+servo_id).getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
        }
      }
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