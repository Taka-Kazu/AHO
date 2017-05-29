#ifndef __AHO_H
#define __AHO_H

#include "mbed.h"
#include "motion.h"

class AHO
{
public:
	AHO(void);
	AHO(Serial&);

	void set_motion(Motion&);
private:
	static const int BAUDRATE = 115200;
	static const int8_t STR_LENGTH = 1;
	static const int8_t POS_NUM = 50;
	Serial* pc;
	Motion* motion;
	char str[50][100];

	void initialize(void);
	void interrupt(void);

};

#endif
