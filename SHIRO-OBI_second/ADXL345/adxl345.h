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
