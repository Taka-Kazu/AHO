#ifndef __POSITION_H
#define __POSITION_H

#include "mbed.h"
#include <vector>
#include <string>

using namespace std;

class Position{
public:
	Position(void);
	Position(char*);

private:
	int time_ms;
	vector<int> servo_angle;
};

#endif
