#ifndef _L3GD20_H
#define _l3GD20_H

#include "mbed.h"

#ifndef M_PI
#define M_PI 3.1415927
#endif

class L3GD20
{
public:
	L3GD20(SPI&, PinName);
	float get_x_angular_velocity(void);
	float get_y_angular_velocity(void);
	float get_z_angular_velocity(void);
	void calibrate(uint16_t n = 10);

private:
	SPI* spi;
	DigitalOut cs;
	float offset_x;
	float offset_y;
	float offset_z;

	void write(uint8_t, uint8_t);
	int read(uint8_t);
};

#endif
