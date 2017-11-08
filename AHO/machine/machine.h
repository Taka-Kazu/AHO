#ifndef __MACHINE_H
#define __MACHINE_H

#include "mbed.h"
#include "PCA9685.h"
#include "motion.h"
#include "buzzer.h"
#include "SDFileSystem.h"
#include "l3gd20.h"
#include "adxl345.h"


class Machine
{
public:
	Machine(int);

	void move_servo(int, float);//id, angle
	void set_direction(int, bool);
	void play_motion(int);
	void alert(int hz=440);
	void power_on(void);
	void power_off(void);
	float get_angle_x(void);

	Motion motion;

private:
	static const PinName SDA = PB_7;
	static const PinName SCL = PB_6;
	static const PinName SERVO16_PIN = PA_3;
	static const PinName SERVO17_PIN = PA_1;//PA_4;
	static const PinName BUZZER_PIN = PA_8;
	static const PinName MOSI = PB_5;
	static const PinName MISO = PB_4;
	static const PinName SCLK = PB_3;
	static const PinName SELECT_SD = PA_11;
	static const PinName POWER_PIN = PA_12;
	static const PinName SELECT_GYRO = PA_6;//PF_0;
	static const PinName SELECT_ACCELEROMETER = PA_7;//PF_1;
	static const float LONG_PULSE = 2.5;
	static const float SHORT_PULSE = 0.5;
	static const float CENTER_PULSE = 1.5;
	static const int MAX_ANGLE = 180;
	static const int MIN_ANGLE = 0;
	static const int CENTER_ANGLE = 90;
	static const int SERVO_NUM = 18;
	static const int POS_NUM = 50;
	static const int PCA9685_SERVO_NUM = 16;
	static const float PULSE_PERIOD = 20;//[ms]
	static const int PCA9685_RESOLUTION = 4096;
	const int MOTION_NUM;

	PCA9685 servos;
	PwmOut servo16;
	PwmOut servo17;
	bool* direction;//true��cw,false��ccw
	Buzzer buzzer;
	DigitalOut power;
	SPI spi;
	L3GD20 gyro;
	ADXL345 accelerometer;
	SDFileSystem sd_card;

	void set_pca9685_angle(int, float);//PCA9685�p
	void set_servo_angle(int, float);//pwm�s���p
	void reverse_angle(float&);
};

#endif


