#include "machine.h"

Machine::Machine(void)
:servos(SDA, SCL), servo16(SERVO16_PIN), servo17(SERVO17_PIN)
{

}

void Machine::move_servo(int id, int angle)
{
	if(angle>=180){
		angle = 180;
	}else if(angle<=0){
		angle = 0;
	}
	if(id<0 || id>SERVO_NUM - 1){
		return;
	}

}
