#include "machine.h"

Machine::Machine(void)
:servos(SDA, SCL), servo16(SERVO16_PIN), servo17(SERVO17_PIN),direction(SERVO_NUM, true)
{
	servos.begin();
	servos.setPrescale(121);
	servos.frequencyI2C(400000);
	servo16.period_ms(PULSE_PERIOD);
	servo17.period_ms(PULSE_PERIOD);
}

void Machine::play_motion(void)
{
	for(int i=0;i<POS_NUM;i++)
	{
		std::vector<Position>::iterator it;
		if(it == motion.pos.end())return;
		for(int j=0;j<SERVO_NUM;j++){
			move_servo(j, motion.pos[i].get_angle(j));
		}
		wait_ms(motion.pos[i].get_time());
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
	int pulse = (angle-CENTER_ANGLE)/(MAX_ANGLE-MIN_ANGLE)*(LONG_PULSE-SHORT_PULSE)+CENTER_PULSE;
	servos.setPWM(id, 0, pulse/(PULSE_PERIOD)*(PCA9685_RESOLUTION-1));
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
