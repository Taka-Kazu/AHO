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
	bool has_changed(void);

private:
	static const int BAUDRATE = 115200;
	static const int8_t STR_LENGTH = 120;
	static const int8_t POS_NUM = 20;
	static const int8_t DATA_LENGTH = 17;
	Serial* pc;
	Motion* motion;
	char str[POS_NUM][STR_LENGTH];
	bool flag;//interrupt�����s������ture
	uint16_t data[DATA_LENGTH];

	void initialize(void);
	void interrupt(void);

};

#endif

