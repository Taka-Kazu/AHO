#ifndef __POSITION_H
#define __POSITION_H

#include "mbed.h"
#include <vector>
#include <string>

class Position{
public:
	Position(void);

	void set_param(string);
	int get_time(void);
	int get_angle(int);

private:
	static const int SERVO_NUM = 20;
	int time_ms;
	std::vector<int> servo_angle;
};

#endif
