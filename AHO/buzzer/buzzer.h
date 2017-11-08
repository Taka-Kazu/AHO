#ifndef __BUZZER_H
#define __BUZZER_H

#include "mbed.h"

class Buzzer
{
public:
	Buzzer(PinName);//pwm

	void alert(int hz = 440);

private:
	PwmOut buzzer;
};

#endif

