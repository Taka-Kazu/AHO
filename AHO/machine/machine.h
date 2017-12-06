#ifndef __MACHINE_H
#define __MACHINE_H

#include "mbed.h"
#include "motion.h"
#include "buzzer.h"
#include "SDFileSystem.h"
#include "l3gd20.h"
#include "adxl345.h"
#include "ics3_5.h"
#include "rtos.h"


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
	static const PinName ICS_TX = PA_9;
	static const PinName ICS_RX = PA_10;
	static const PinName ICS_ENABLE = PA_1;
	static const PinName BUZZER_PIN = PA_8;
	static const PinName MOSI = PB_5;
	static const PinName MISO = PB_4;
	static const PinName SCLK = PB_3;
	static const PinName SELECT_SD = PA_11;
	static const PinName POWER_PIN = PA_12;
	static const PinName SELECT_GYRO = PA_7;
	static const PinName SELECT_ACCELEROMETER = PA_4;
	static const float LONG_PULSE = 2.3;
	static const float SHORT_PULSE = 0.7;
	static const float CENTER_PULSE = 1.5;
	static const int MAX_ANGLE = 270;
	static const int MIN_ANGLE = 0;
	static const int CENTER_ANGLE = 90;
	static const int SERVO_NUM = 15;
	static const int POS_NUM = 50;
	static const int INTERVAL = 10;//[ms]
	static const int FRAME = 25;//[ms]
	const int MOTION_NUM;

	bool* direction;//true��cw,false��ccw
	Serial ics;
	ICS3_5 servos;
	Buzzer buzzer;
	SPI spi;
	L3GD20 gyro;
	ADXL345 accelerometer;
	SDFileSystem sd_card;
	float* neutral_angle;
	float* current_angle;
	float* target_angle;
	float* min_angle;
	float* max_angle;
	Thread *_thread;
	bool servo_is_moving;

	void reverse_angle(float&);
	static void thread_starter(void *p);
	void servo_controller(void);
	void play();
	void read_from_sd(char*);
};

#endif


