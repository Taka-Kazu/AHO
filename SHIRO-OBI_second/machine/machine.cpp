#include "machine.h"

Machine::Machine(int motion_num)
:MOTION_NUM(motion_num) , servos(SDA, SCL), servo16(SERVO16_PIN), servo17(SERVO17_PIN)
, buzzer(BUZZER_PIN), power(POWER_PIN), spi(MOSI, MISO, SCLK)
, gyro(spi, SELECT_GYRO), sd_card(MOSI, MISO, SCLK, SELECT_SD, "sd")
, accelerometer(spi, SELECT_ACCELEROMETER)
{
	power_off();
	direction = new bool[SERVO_NUM];
	for(int i=0;i<SERVO_NUM;i++){
		direction[i] = true;
	}
	servos.begin();
	servos.setPrescale(121);
	servos.frequencyI2C(400000);
	servo16.period_ms(PULSE_PERIOD);
	servo17.period_ms(PULSE_PERIOD);
}

void Machine::play_motion(int motion_id)
{
	//alert();
	char c;
	int8_t str_j = 0;//param2
	int8_t str_k = 0;//param1
	char str[50][100];

	wait(0.3);
	if(!(motion_id<0||motion_id>MOTION_NUM)){
		FILE* fp = fopen("/sd/mydir/motion.csv", "r");
		if(fp == NULL){
			printf("SD card error!\r\n");
			return;
		}

		while(1){
			fscanf(fp, "%c", &c);
			if(c=='\0'){
				for(int i=0;i<str_k;i++){
					motion.pos[i].set_param(str[i]);
					//printf("%s\r\n", str[i]);
				}
				break;
			}
			str[str_k][str_j] = c;
			str_j++;
			if(c=='\n'){
				str_k++;
				str_j=0;
			}
		}

		for(int i=0;i<POS_NUM;i++)
		{
			int time = motion.pos[i].get_time();
			if(time==0){
				return;
			}
			if(i == (sizeof(motion.pos)/sizeof(Position)-1)){
				return;
			}
			for(int j=0;j<SERVO_NUM;j++){
				move_servo(j, motion.pos[i].get_angle(j));
			}
			wait_ms(time);
		}
		fclose(fp);
	}
}

void Machine::move_servo(int id, float angle)
{
	//角度指定は0°~180°
	if(angle>=180.0f){
		angle = 180.0f;
	}else if(angle<0.0f){
		angle = 0.0f;
	}
	if(id<0 || id>SERVO_NUM - 1){
		//無効な値
		return;
	}
	if(id<PCA9685_SERVO_NUM){
		set_pca9685_angle(id, angle);
	}else{
		set_servo_angle(id, angle);
	}
}

void Machine::set_direction(int id, bool cw)
{
	if(id<0 || id>SERVO_NUM - 1){
		//無効な値
		return;
	}
	direction[id] = cw;
}

void Machine::set_pca9685_angle(int id, float angle)
{
	if(!direction[id]){
			reverse_angle(angle);
		}
	float pulse = (angle-CENTER_ANGLE)/(MAX_ANGLE-MIN_ANGLE)*(LONG_PULSE-SHORT_PULSE)+CENTER_PULSE;
	int off = pulse/(PULSE_PERIOD)*(PCA9685_RESOLUTION-1);
	servos.setPWM(id, 0, off);
	printf("id=%d, off=%d\r\n", id, off);
}

void Machine::set_servo_angle(int id, float angle)
{
	if(!direction[id]){
		reverse_angle(angle);
	}
	int pulse = (angle-CENTER_ANGLE)/(MAX_ANGLE-MIN_ANGLE)*(LONG_PULSE-SHORT_PULSE)+CENTER_PULSE;
	switch(id){
	case 16:
	{
		servo16.pulsewidth_ms(pulse);
		break;
	}
	case 17:
	{
		servo17.pulsewidth_ms(pulse);
		break;
	}
	default:
		break;
	}
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
	power = 1;
}

void Machine::power_off(void)
{
	power = 0;
}

float Machine::get_angle_x(void)
{
	float val = 0;
	val =  gyro.get_x_angular_velocity();
	return val;
}
