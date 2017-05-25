#ifndef __MACHINE_H
#define __MACHINE_H

#include "mbed.h"
#include "PCA9685.h"
#include "motion.h"

class Machine
{
public:
	Machine(void);

	void move_servo(int, float);//id, angle
	void set_direction(int, bool);
	void play_motion(void);

	Motion motion;

private:
	static const PinName SDA = PB_7;
	static const PinName SCL = PB_6;
	static const PinName SERVO16_PIN = PB_4;
	static const PinName SERVO17_PIN = PB_5;
	static const int LONG_PULSE = 2500;
	static const int SHORT_PULSE = 500;
	static const int CENTER_PULSE = 1500;
	static const int MAX_ANGLE = 180;
	static const int MIN_ANGLE = 0;
	static const int CENTER_ANGLE = 90;
	static const int SERVO_NUM = 18;
	static const int POS_NUM = 50;
	static const int PCA9685_SERVO_NUM = 16;
	static const int PULSE_PERIOD = 20;//[ms]
	static const int PCA9685_RESOLUTION = 4096;

	PCA9685 servos;
	PwmOut servo16;
	PwmOut servo17;
	std::vector<bool>direction;//trueはcw,falseはccw

	void set_pca9685_angle(int, float);//PCA9685用
	void set_servo_angle(int, float);//pwmピン用
	void reverse_angle(float&);
};

#endif
