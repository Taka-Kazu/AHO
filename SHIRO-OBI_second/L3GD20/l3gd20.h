#ifndef _L3GD20_H
#define _l3GD20_H

#include "mbed.h"

class L3GD20
{
public:
	L3GD20(SPI&, PinName);
	float get_x_angular_velocity(void);
	float get_y_angular_velocity(void);
	float get_z_angular_velocity(void);

private:
	SPI* spi;
	DigitalOut cs;

	void write(uint16_t, uint16_t);
	uint8_t read(uint16_t);
};

#endif
