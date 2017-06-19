#ifndef __ADXL345_H
#define __ADXL345_H

#include "mbed.h"

class ADXL345
{
public:
	ADXL345(SPI&, PinName);

	float get_x_acceleration(void);
	float get_y_acceleration(void);
	float get_z_acceleration(void);

private:
	SPI* spi;
	DigitalOut cs;

	void write(uint8_t, uint8_t);
	int read(uint8_t);
};

#endif
