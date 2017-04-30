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
PositionState current_pos;
PositionState _POS0 = new PositionState(0);
PositionState _POS1 = new PositionState(1);
PositionState _POS2 = new PositionState(2);
PositionState _POS3 = new PositionState(3);
PositionState _POS4 = new PositionState(4);
PositionState _POS5 = new PositionState(5);
PositionState _POS6 = new PositionState(6);
PositionState _POS7 = new PositionState(7);
PositionState _POS8 = new PositionState(8);
PositionState _POS9 = new PositionState(9);
PositionState _POS10 = new PositionState(10);
PositionState _POS11 = new PositionState(11);
PositionState _POS12 = new PositionState(12);
PositionState _POS13 = new PositionState(13);
PositionState _POS14 = new PositionState(14);
PositionState _POS15 = new PositionState(15);

int readable = 0;

void setup() {
  size(1600, 900); 
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
  float OFFSET_Y = 250;
  float ELEMENT_Y = 100;
  int flag = 0;
  int id = 0;
  float val[] = new float[20];
  
  State pointer;
  
  PositionState(int x)
  {
    id = x;
    reset_val();
  }
  
  void reset_val()
  {
    for(int i=0;i<20;i++){
      val[i] = 90;
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

      flag = 1;
    }
  }
  void drawState()
  {
    background(0);
    initialise();
    textSize(20);
    text("POS"+id+" setting", width*0.2, height*0.1);
    read_val();
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
    if(readable == 0)return;
    val[0] = slider.getController("SERVO0").getValue();
    val[1] = slider.getController("SERVO1").getValue();
    val[2] = slider.getController("SERVO2").getValue();
    val[3] = slider.getController("SERVO3").getValue();
    val[4] = slider.getController("SERVO4").getValue();
    val[5] = slider.getController("SERVO5").getValue();
    val[6] = slider.getController("SERVO6").getValue();
    val[7] = slider.getController("SERVO7").getValue();
    val[8] = slider.getController("SERVO8").getValue();
    val[9] = slider.getController("SERVO9").getValue();
    val[10] = slider.getController("SERVO10").getValue();
    val[11] = slider.getController("SERVO11").getValue();
    val[12] = slider.getController("SERVO12").getValue();
    val[13] = slider.getController("SERVO13").getValue();
    val[14] = slider.getController("SERVO14").getValue();
    val[15] = slider.getController("SERVO15").getValue();
    val[16] = slider.getController("SERVO16").getValue();
    val[17] = slider.getController("SERVO17").getValue();
    val[18] = slider.getController("SERVO18").getValue();
    val[19] = slider.getController("SERVO19").getValue();
  }
  
  void setNextState(State s)
  {
    read_val();
    button_back.remove("BACK");
    slider.remove("SERVO0");
    slider.remove("SERVO1");
    slider.remove("SERVO2");
    slider.remove("SERVO3");
    slider.remove("SERVO4");
    slider.remove("SERVO5");
    slider.remove("SERVO6");
    slider.remove("SERVO7");
    slider.remove("SERVO8");
    slider.remove("SERVO9");
    slider.remove("SERVO10");
    slider.remove("SERVO11");
    slider.remove("SERVO12");
    slider.remove("SERVO13");
    slider.remove("SERVO14");
    slider.remove("SERVO15");
    slider.remove("SERVO16");
    slider.remove("SERVO17");
    slider.remove("SERVO18");
    slider.remove("SERVO19");
    pointer = s;
  }
}

void BACK()
{
  switch(current_pos.getID())
  {
    case 0:
    _POS0.setNextState(motion_state);
    break;
    case 1:
    _POS1.setNextState(motion_state);
    break;
    case 2:
    _POS2.setNextState(motion_state);
    break;
    case 3:
    _POS3.setNextState(motion_state);
    break;
    case 4:
    _POS4.setNextState(motion_state);
    break;
    case 5:
    _POS5.setNextState(motion_state);
    break;
    case 6:
    _POS6.setNextState(motion_state);
    break;
    case 7:
    _POS7.setNextState(motion_state);
    break;
    case 8:
    _POS8.setNextState(motion_state);
    break;
    case 9:
    _POS9.setNextState(motion_state);
    break;
    case 10:
    _POS10.setNextState(motion_state);
    break;
    case 11:
    _POS11.setNextState(motion_state);
    break;
    case 12:
    _POS12.setNextState(motion_state);
    break;
    case 13:
    _POS13.setNextState(motion_state);
    break;
    case 14:
    _POS14.setNextState(motion_state);
    break;
    case 15:
    _POS15.setNextState(motion_state);
    break;
  }
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