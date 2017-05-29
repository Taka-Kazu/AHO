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

private:
	static const int SERVO_NUM = 20;
	int16_t time_ms;
	uint8_t servo_angle[SERVO_NUM];
};

#endif
