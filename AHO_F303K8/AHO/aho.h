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
	Serial* pc;
	Motion* motion;

	void initialize(void);
	void interrupt(void);
};

#endif
