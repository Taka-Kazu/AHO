#include "machine.h"

Machine::Machine(int motion_num)
:MOTION_NUM(motion_num)
, ics(ICS_TX, ICS_RX)
, servos(ics, ICS_ENABLE)
, buzzer(BUZZER_PIN), spi(MOSI, MISO, SCLK)
, gyro(spi, SELECT_GYRO)
, accelerometer(spi, SELECT_ACCELEROMETER)
, sd_card(MOSI, MISO, SCLK, SELECT_SD, "sd")
{
	direction = new bool[SERVO_NUM];
	for(int i=0;i<SERVO_NUM;i++){
		direction[i] = true;
	}
	neutral_angle = new float[SERVO_NUM];
	min_angle = new float[SERVO_NUM];
	max_angle = new float[SERVO_NUM];
	neutral_angle[0] = 114;min_angle[0] = 96;max_angle[0] = 187;
	neutral_angle[1] = 104;min_angle[1] = 48;max_angle[1] = 104;
	neutral_angle[2] = 105;min_angle[2] = 105;max_angle[2] = 169;
	neutral_angle[3] = 122;min_angle[3] = 122;max_angle[3] = 216;
	neutral_angle[4] = 132;min_angle[4] = 91;max_angle[4] = 174;
	neutral_angle[5] = 131;min_angle[5] = 64;max_angle[5] = 146;
	neutral_angle[6] = 137;min_angle[6] = 137;max_angle[6] = 213;
	neutral_angle[7] = 143;min_angle[7] = 74;max_angle[7] = 143;
	neutral_angle[8] = 123;min_angle[8] = 32;max_angle[8] = 123;
	neutral_angle[9] = 137;min_angle[9] = 137;max_angle[9] = 185;
	neutral_angle[10] = 180;min_angle[10] = 0;max_angle[10] = 180;
	neutral_angle[11] = 135;min_angle[11] = 16;max_angle[11] = 135;
	neutral_angle[12] = 16;min_angle[12] = 16;max_angle[12] = 196;
	neutral_angle[13] = 52;min_angle[13] = 52;max_angle[13] = 144;
	neutral_angle[14] = 106;min_angle[14] = 45;max_angle[14] = 227;
	current_angle = new float[SERVO_NUM];
	target_angle = new float[SERVO_NUM];
	for(int i=0;i<SERVO_NUM;i++){
		current_angle[i] = target_angle[i] = neutral_angle[i];
	}

	alert(1760);
    wait(0.5);
    alert(0);
	wait(0.5);

	//_thread = new Thread(&Machine::thread_starter, this);
	for(int i=0;i<SERVO_NUM;i++){
		move_servo(i, neutral_angle[i]);
		//printf("hello\r\n");
	}
	gyro.calibrate(100);
	printf("Machine is ready\r\n");
}

void Machine::play_motion(int motion_id)
{
	//alert();
	wait(0.3);
	if(!(motion_id<0||motion_id>MOTION_NUM)){
		switch (motion_id) {
			case 0:
				//for AHO only
				//nothing to do here
				break;
			case 1:
				read_from_sd((char*)"/sd/mydir/default.csv");
				break;
			case 2:
				read_from_sd((char*)"/sd/mydir/punch.csv");
				break;
			case 3:
				read_from_sd((char*)"/sd/mydir/motion.csv");
				break;
			default:
				break;
		}
		play();
		motion.reset();
	}
}

void Machine::move_servo(int id, float angle)
{
	if(id<0 || id>SERVO_NUM - 1){
		return;
	}
	if(angle >= max_angle[id]){
		angle = max_angle[id];
	}else if(angle < min_angle[id]){
		angle = min_angle[id];
	}
	//printf("id:%d, angle:%f\r\n", id, angle);
	float omega =0;//= gyro.get_y_angular_velocity();
	float k=2;
	//printf("omega = %f\r\n", omega);
	if((id!=0) || (id!=5)){
		servos.move(id, angle);
	}else if(id==0){
		//right ankle
		servos.move(id, angle-omega*k);
	}else if(id==5){
		//left ankle
		servos.move(id, angle-omega*k);
	}
}

void Machine::set_direction(int id, bool cw)
{
	if(id<0 || id>SERVO_NUM - 1){
		//�����Ȓl
		return;
	}
	direction[id] = cw;
}



void Machine::reverse_angle(float &angle)
{
	angle = MAX_ANGLE - angle;
}

void Machine::alert(int hz)
{
	buzzer.alert(hz);
}

void Machine::power_on(void)
{

}

void Machine::power_off(void)
{

}

float Machine::get_angular_velocity_x(void)
{
	float val = 0;
	val =  gyro.get_x_angular_velocity();
	return val;
}

float Machine::get_angular_velocity_y(void)
{
	float val = 0;
	val =  gyro.get_y_angular_velocity();
	return val;
}

void Machine::thread_starter(void *p)
{
	Machine *instance = (Machine*)p;
  	instance->servo_controller();
}

void Machine::servo_controller(void)
{
	Thread::wait(INTERVAL);
}

void Machine::play(void)
{
	DigitalOut led(LED1);
	led = 0;
	for(int i=0;i<POS_NUM;i++)
	{
		const int DT = 25;//[ms]
		int time = motion.pos[i].get_time();
		if(time==0){
			break;
		}
		if(i == (sizeof(motion.pos)/sizeof(Position)-1)){
			break;
		}
		////////////////////////////////////////////////////////
		const int LOOP = time / DT;
		float d_theta[SERVO_NUM];
		for(int j=0;j<SERVO_NUM;j++){
			d_theta[j] = (motion.pos[i].get_angle(j) - current_angle[j]) / LOOP;
		}
		for(int j=0;j<LOOP;j++){
			for(int k=0;k<SERVO_NUM;k++){
				move_servo(k, current_angle[k] + d_theta[k] * j);
			}
			wait_ms(DT);
		}
		for(int j=0;j<SERVO_NUM;j++){
			current_angle[j] = motion.pos[i].get_angle(j);
		}
	}
	led = 1;
}

void Machine::read_from_sd(char* file_name)
{
	char c;
	int8_t str_j = 0;//param2
	int8_t str_k = 0;//param1
	char str[POS_NUM][200];
	bool flag = true;
	for(int i=0;i<POS_NUM;i++){
		for(int j=0;j<200;j++){
			str[i][j] = 0;
		}
	}
	mkdir("/sd/mydir", 0777);
	//motion_idによってopenするファイルを変える
	FILE *fp = fopen("/sd/mydir/motion.csv", "r");
	if(fp == NULL){
		printf("SD card error!\r\n");
		return;
	}
	printf("file opend!\r\n");
	while(1){
		fscanf(fp, "%c", &c);
		//printf("%c", c);
		if(c=='\n'){
			if(flag==false){
				c = '\0';
			}
			flag = false;
		}else{
			flag = true;
		}
		if(c=='\0'){
			for(int i=0;i<str_k;i++){
				//set data
				motion.pos[i].set_param(str[i]);
				printf("str[%d] = %s\r\n", i, str[i]);
			}
			break;
		}
		str[str_k][str_j] = c;
		if(c == '\n'){
			str[str_k][str_j] = '\0';
		}
		//printf("str[%d][%d] = 0x%X\r\n", str_k, str_j, str[str_k][str_j]);
		str_j++;
		if(c=='\n'){
			str_k++;
			str_j=0;
		}
	}
	fclose(fp);
	printf("file closed!\r\n");
}
