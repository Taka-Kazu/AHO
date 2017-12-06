#ifndef __POSITION_H
#define __POSITION_H

#include "mbed.h"
#include "string.h"
#include "stdlib.h"

class Position{
public:
	Position(void);

	void set_param(char*);
	int get_time(void);
	int get_angle(int);
	void set_time(int);
	void set_angle(int, int);
	void reset();


private:
	static const uint8_t SERVO_NUM = 16;
	static const uint16_t CENTER = 135;

	int16_t time_ms;
	uint16_t*  servo_angle;
};

#endif

