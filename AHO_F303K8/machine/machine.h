#ifndef __MACHINE_H
#define __MACHINE_H

#include "mbed.h"
#include "PCA9685.h"
#include "motion.h"

class Machine
{
public:
	Machine(void);

private:
	static const PinName SDA = PB_7;
	static const PinName SCL = PB_6;
	static const PinName SERVO16_PIN = PA_0;
	static const PinName SERVO17_PIN = PA_0;

	PCA9685 servos;
	PwmOut servo16;
	PwmOut servo17;
};

#endif
