#include "machine.h"

Machine::Machine(int motion_num)
:MOTION_NUM(motion_num) , servos(SDA, SCL)
, buzzer(BUZZER_PIN), power(POWER_PIN), servo16(SERVO16_PIN), servo17(SERVO17_PIN)
{
	power_off();
	direction = new bool[SERVO_NUM];
	for(int i=0;i<SERVO_NUM;i++){
		direction[i] = true;
	}
	servos.begin();
	servos.setPrescale(121);
	servos.frequencyI2C(400000);
}

void Machine::play_motion(int motion_id)
{
	//alert();
	wait(0.3);
	if(motion_id>=0||motion_id<=MOTION_NUM){
		for(int i=0;i<POS_NUM;i++)
		{
			int time = motion.pos[i].get_time();
			if(time==0){
				//printf("%d, time == 0!\r\n", i);
				return;
			}
			if(i == (sizeof(motion.pos)/sizeof(Position)-1)){
				return;
			}
			for(int j=0;j<SERVO_NUM;j++){
				move_servo(j, motion.pos[i].get_angle(j));
				//printf("%d, %d, %d[deg]\r\n", i, j, motion.pos[i].get_angle(j));
			}
			//printf("%d, time == %d, %d[deg]\r\n", i, motion.pos[i].get_time(), motion.pos[i].get_angle(0));
			wait_ms(time);
		}
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
	//printf("id=%d, off=%d\r\n", id, off);
}

void Machine::set_servo_angle(int id, float angle)
{

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
