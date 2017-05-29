#ifndef __MOTION_H
#define __MOTION_H

#include "mbed.h"
#include "position.h"

class Motion
{
public:
	Motion(void);
	static const int8_t POS_NUM = 50;
	Position pos[POS_NUM];


};

#endif
