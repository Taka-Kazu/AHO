import controlP5.*;
import processing.serial.*;

ControlFont button_font;
PrintWriter output;
Serial serial_port;
String[] ports = Serial.list();
//String[] ports = {"kuroda", "miyagi", "imokenpi"};
String selected_port = null;
boolean connected = false;
String file_name = "motion.csv";
String data_line = "";

ControlP5 slider;
ControlP5 textbox;
ControlP5 button_back;
ControlP5 play_pos;
ControlP5 reset_pos;
ControlP5 play_motion;
ControlP5 exit_button;
ControlP5 enable_button;
ControlP5 data_button;
ControlP5 save_button;
ControlP5 port;
ControlP5 connect_button;
ListBox port_list;
ControlP5 load_button;

int POS_NUM = 50;
int SERVO_NUM = 20;
int BAUDRATE = 115200;

State state;
MotionState motion_state = new MotionState();
PositionState current_pos;
PositionState buffer_pos;
PositionState _POS[] = new PositionState[POS_NUM];
ControlP5 button_pos[] = new ControlP5[POS_NUM];

int readable = 0;

void setup() {
  size(1600, 900); 
  button_font = new ControlFont(createFont("Arial", 15));
  buffer_pos = new PositionState(100);
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
  data_button = new ControlP5(this);
  save_button = new ControlP5(this);
  state = new StartState(motion_state);
  textbox = new ControlP5(this);
  port = new ControlP5(this);
  connect_button = new ControlP5(this);
  load_button = new ControlP5(this);
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
  float OFFSET_X = 75;
  float ELEMENT_X = 150;
  float OFFSET_Y = 250;
  float ELEMENT_Y = 100;
  int UNABLE_COLOR = 0xFF0000FF;
  int ENABLE_COLOR = 0xFFFF0000;
  int POS_GYOU = 5;
  int POS_RETU = 10;
  void initialise(){
    if(flag == 0){
      pointer = this;
      port_list = port.addListBox("LIST");
      if(selected_port == null){
        port_list.setLabel("COM PORT").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*(-1)).setSize(200, 100).setFont(button_font).setBarHeight(30).setItemHeight(30);
      }else{
        port_list.setLabel(selected_port).setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*(-1)).setSize(200, 100).setFont(button_font).setBarHeight(30).setItemHeight(30);
      }
      for(int i=0;i<ports.length;i++){
        port_list.addItem(ports[i], i);
      }
      port_list.close();
      connect_button.addButton("CONNECT").setLabel("CONNECT").setPosition(OFFSET_X+ELEMENT_X*5, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40).setFont(button_font);
      if(connected){
        connect_button.getController("CONNECT").setColorBackground(ENABLE_COLOR);
      }
      play_motion.addButton("PLAY_MOTION").setLabel("PLAY").setPosition(OFFSET_X+ELEMENT_X*8, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40).setFont(button_font);
      exit_button.addButton("EXIT_BUTTON").setLabel("EXIT").setPosition(OFFSET_X+ELEMENT_X*9, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40).setFont(button_font);
      save_button.addButton("SAVE").setLabel("SAVE").setPosition(OFFSET_X+ELEMENT_X*1, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40).setFont(button_font);
      load_button.addButton("LOAD").setLabel("LOAD").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40).setFont(button_font);
      textbox.addTextfield("FILENAME").setLabel("FILENAME").setPosition(OFFSET_X+ELEMENT_X*2, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40).setFont(button_font).setAutoClear(false).setValue(file_name);
      for(int i=0;i<POS_GYOU;i++){
        for(int j=0;j<POS_RETU;j++){
          int pos_id = i*POS_RETU+j;
          button_pos[pos_id].addButton("POS"+pos_id).setLabel("POS"+pos_id).setPosition(OFFSET_X+ELEMENT_X*j, OFFSET_Y+ELEMENT_Y*i).setSize(100, 40).setFont(button_font);
          if(_POS[pos_id].enabled == true){
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
    save_button.remove("SAVE");
    port.remove("LIST");
    connect_button.remove("CONNECT");
    textbox.remove("FILENAME");
    load_button.remove("LOAD");
    pointer = s;
  }
}

class PositionState extends State
{
  float OFFSET_X = 100;
  float ELEMENT_X =350;
  float OFFSET_Y = 250;
  float ELEMENT_Y = 100;
  float CENTER_ANGLE = 135;
  int SERVO_GYOU = 5;
  int SERVO_RETU = 4;
  int flag = 0;
  int id = 0;
  float val[] = new float[SERVO_NUM];
  boolean enabled = false;
  Integer time_ms = 1000;
  
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
    time_ms = 100;
    textbox.get(Textfield.class, "TEXTBOX").setText(time_ms.toString());
  }
  
  int getID()
  {
    return id;
  }
  
  void initialise(){
    if(flag == 0){
      pointer = current_pos = this;
      textbox.addTextfield("TEXTBOX").setLabel("TIME[ms]").setPosition(OFFSET_X+ELEMENT_X*(1.5), OFFSET_Y+ELEMENT_Y*5).setSize(100, 40).setFont(button_font).setAutoClear(false).setValue(time_ms.toString());
      button_back.addButton("BACK").setLabel("BACK").setPosition(50, 40).setSize(100, 40).setFont(button_font);
      reset_pos.addButton("RESET_POS").setLabel("RESET").setPosition(OFFSET_X+ELEMENT_X*3.5, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40).setFont(button_font);
      enable_button.addButton("ENABLE").setLabel("ENABLE").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*5).setSize(100, 40).setFont(button_font);
      play_pos.addButton("PLAY_POS").setLabel("PLAY").setPosition(OFFSET_X+ELEMENT_X*3, OFFSET_Y+ELEMENT_Y*(-1)).setSize(100, 40).setFont(button_font);
      data_button.addButton("COPY").setLabel("COPY").setPosition(OFFSET_X+ELEMENT_X*0, OFFSET_Y+ELEMENT_Y*5).setSize(100, 40).setFont(button_font);
      data_button.addButton("PASTE").setLabel("PASTE").setPosition(OFFSET_X+ELEMENT_X*0.5, OFFSET_Y+ELEMENT_Y*5).setSize(100, 40).setFont(button_font);
      for(int i=0;i<SERVO_GYOU;i++){
        for(int j=0;j<SERVO_RETU;j++){
          int servo_id = i*SERVO_RETU+j;
          slider.addSlider("SERVO"+servo_id).setRange(0, 270).setValue(val[servo_id]).setPosition(OFFSET_X+ELEMENT_X*j, OFFSET_Y+ELEMENT_Y*i).setSize(275, 30).setNumberOfTickMarks(271).setFont(button_font);
          slider.getController("SERVO"+servo_id).getValueLabel().align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(-20);
        }
      }
      if(current_pos.enabled == true){
          enable_button.getController("ENABLE").setColorBackground(0xFFFF0000);
        }else if(current_pos.enabled == false){
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
    time_ms = parseInt(textbox.get(Textfield.class, "TEXTBOX").getText());
  }
  
  void setNextState(State s)
  {
    read_val();
    button_back.remove("BACK");
    play_pos.remove("PLAY_POS");
    reset_pos.remove("RESET_POS");
    enable_button.remove("ENABLE");
    textbox.remove("TEXTBOX");
    data_button.remove("COPY");
    data_button.remove("PASTE");
    for(int i=0;i<SERVO_NUM;i++){
      slider.remove("SERVO"+i);
    }
    pointer = s;
  }
  
  void reloadValue()
  {
    for(int i=0;i<SERVO_NUM;i++){
      slider.getController("SERVO"+i).setValue(val[i]);
    }
    textbox.get(Textfield.class, "TEXTBOX").setText(time_ms.toString());
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

void SAVE()
{
  try{
    file_name = textbox.get(Textfield.class, "FILENAME").getText();
    if(!file_name.endsWith(".csv")){
      file_name += ".csv";
    }
    int values[][];
    values = new int[50][22];
    output = createWriter(file_name);
    data_line = "";
    for(int i=0;i<POS_NUM;i++){
        if(_POS[i].enabled==true){
          values[i][0] = 0xFF;
          //data_line += _POS[i].time_ms+",";
          values[i][1] = _POS[i].time_ms;
          for(int j=0;j<SERVO_NUM;j++){
            //data_line += _POS[i].val[j]+",";
            values[i][j+2] = (int)_POS[i].val[j];
          }
          //data_line += "\n";
        }
    }
    for(int i=0;i<POS_NUM;i++){
      if(values[i][0] != 0xFF){
        continue;
      }
      for(int j=0;j<SERVO_NUM+2;j++){
        //print(values[i][j] + ",");
        data_line += values[i][j] + ",";
      }
      //print("\n");
      data_line += "\n";
    }
    print(data_line);
    output.print(data_line);
    output.close();
  }catch(Exception ex){
    println("ERROR:FILE CANNOT OPEN");
  }
}

void PLAY_MOTION()
{
  try{
    data_line = "";
    for(int i=0;i<POS_NUM;i++){
        if(_POS[i].enabled==true){
          data_line += _POS[i].time_ms+",";
          for(int j=0;j<SERVO_NUM;j++){
            data_line += (int)_POS[i].val[j]+",";
          }
          data_line += "\n";
        }
    }
    serial_port.write(data_line+'\0');
  }catch(Exception ex){
    
  }
} //<>//

void COPY()
{
  current_pos.read_val();
  for(int i=0;i<SERVO_NUM;i++){
    buffer_pos.val[i] = current_pos.val[i];
  }
  buffer_pos.time_ms = current_pos.time_ms;
}

void PASTE()
{
  for(int i=0;i<SERVO_NUM;i++){
    current_pos.val[i] = buffer_pos.val[i];
  }
  current_pos.time_ms = buffer_pos.time_ms;
  current_pos.reloadValue();
}

void PLAY_POS()
{
  current_pos.read_val();
  try{
    data_line = "";
    if(current_pos.enabled==true){
      data_line += current_pos.time_ms+",";
      for(int j=0;j<SERVO_NUM;j++){
        data_line += (int)current_pos.val[j]+",";
      }
      data_line += "\n";
    }
    //println(data_line);
    serial_port.write(data_line+'\0');
  }catch(Exception ex){
    
  }
}

void RESET_POS()
{
  current_pos.resetVal();
}

void EXIT_BUTTON()
{
  exit();
}

void ENABLE()
{
  if(current_pos.enabled == false){
    current_pos.enabled = true;
    enable_button.getController("ENABLE").setColorBackground(0xFFFF0000);
  }else if(current_pos.enabled == true){
    current_pos.enabled = false;
    enable_button.getController("ENABLE").setColorBackground(0xFF0000FF);
  }else{
    current_pos.enabled = false;
  }
}

void CONNECT()
{
  try{
    if(connected)return;
    serial_port = new Serial(this, selected_port, BAUDRATE);
    connected = true;
    println("CONNECTED TO "+selected_port);
  }catch(Exception ex){
    println("ERROR:PORT CANNOT OPEN");
  }
}

void LOAD()
{
  BufferedReader reader;
  reader = createReader(file_name);
  String line = "";
  data_line = "";
  while(true){
    try{
      line = reader.readLine();
    }catch(Exception ex){
      line = null;
    }
    if(line==null){
      break;
    }else{
      data_line +=line + "\n";
    }
  }
  String str[] = split(data_line, ",");
  int pos_cnt = 0;
  int servo_cnt = -1;
  
  for(String buf:str){
    buf = buf.replaceAll("\n", "");
    try{
      if(servo_cnt == -1){
        _POS[pos_cnt].time_ms = Integer.parseInt(buf);
      }else{
        _POS[pos_cnt].enabled = true;
        _POS[pos_cnt].val[servo_cnt] = Float.parseFloat(buf);
      }
    }catch(NumberFormatException ex){
      return;
    }
    servo_cnt++;
    if(servo_cnt == SERVO_NUM){
      pos_cnt++;
      servo_cnt = -1;
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

void POS16()
{
    motion_state.setNextState(_POS[16]);
}

void POS17()
{
    motion_state.setNextState(_POS[17]);
}

void POS18()
{
    motion_state.setNextState(_POS[18]);
}

void POS19()
{
    motion_state.setNextState(_POS[19]);
}

void POS20()
{
    motion_state.setNextState(_POS[20]);
}

void POS21()
{
    motion_state.setNextState(_POS[21]);
}
  
void POS22()
{
    motion_state.setNextState(_POS[22]);
}

void POS23()
{
    motion_state.setNextState(_POS[23]);
}

void POS24()
{
    motion_state.setNextState(_POS[24]);
}
  
void POS25()
{
    motion_state.setNextState(_POS[25]);
}
void POS26()
{
    motion_state.setNextState(_POS[26]);
}

void POS27()
{
    motion_state.setNextState(_POS[27]);
}
  
void POS28()
{
    motion_state.setNextState(_POS[28]);
}
void POS29()
{
    motion_state.setNextState(_POS[29]);
}

void POS30()
{
    motion_state.setNextState(_POS[30]);
}

void POS31()
{
    motion_state.setNextState(_POS[31]);
}
  
void POS32()
{
    motion_state.setNextState(_POS[32]);
}

void POS33()
{
    motion_state.setNextState(_POS[33]);
}

void POS34()
{
    motion_state.setNextState(_POS[34]);
}
  
void POS35()
{
    motion_state.setNextState(_POS[35]);
}
void POS36()
{
    motion_state.setNextState(_POS[36]);
}

void POS37()
{
    motion_state.setNextState(_POS[37]);
}
  
void POS38()
{
    motion_state.setNextState(_POS[38]);
}

void POS39()
{
    motion_state.setNextState(_POS[39]);
}

void POS40()
{
    motion_state.setNextState(_POS[40]);
}

void POS41()
{
    motion_state.setNextState(_POS[41]);
}
  
void POS42()
{
    motion_state.setNextState(_POS[42]);
}

void POS43()
{
    motion_state.setNextState(_POS[43]);
}

void POS44()
{
    motion_state.setNextState(_POS[44]);
}
  
void POS45()
{
    motion_state.setNextState(_POS[45]);
}
void POS46()
{
    motion_state.setNextState(_POS[46]);
}

void POS47()
{
    motion_state.setNextState(_POS[47]);
}
  
void POS48()
{
    motion_state.setNextState(_POS[48]);
}
void POS49()
{
    motion_state.setNextState(_POS[49]);
}

void LIST()
{
  selected_port = ports[(int)port_list.getValue()];
  port_list.setLabel(selected_port).close();
  println(selected_port);
}

void serialEvent(Serial s)
{
  while(s.available()>0){
    String data=s.readString();
    if(data!=null){
      print(data);
    }
  }
}