#ifndef __AHO_H
#define __AHO_H

/*
 * PCとの通信用クラス
 */

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
	static const int8_t STR_LENGTH = 100;
	static const int8_t POS_NUM = 50;
	Serial* pc;
	Motion* motion;
	char str[POS_NUM][STR_LENGTH];
	bool flag;//interruptを実行したらture

	void initialize(void);
	void interrupt(void);

};

#endif
