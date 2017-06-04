#include "l3gd20.h"

#define L3GD20_RESOLUTION 0.00875//dps

#define L3GD20_WHO_AM_I 0x0F
#define L3GD20_CTRL_REG1 0x20
#define L3GD20_CTRL_REG2 0x21
#define L3GD20_CTRL_REG3 0x22
#define L3GD20_CTRL_REG4 0x23
#define L3GD20_CTRL_REG5 0x24
#define L3GD20_REFERENCE 0x26
#define L3GD20_OUT_TEMP 0x27
#define L3GD20_STATUS_REG 0x28
#define L3GD20_OUT_X_L 0x28
#define L3GD20_OUT_X_H 0x29
#define L3GD20_OUT_Y_H 0x2A
#define L3GD20_OUT_Y_L 0x2B
#define L3GD20_OUT_Z_H 0x2C
#define L3GD20_OUT_Z_L 0x2D

L3GD20::L3GD20(SPI& _spi, PinName cs_pin)
:spi(&_spi), cs(cs_pin)
{
	spi->frequency(1000000);
	spi->format(8, 3);
	if(read(L3GD20_WHO_AM_I) == 0xD4)
	{
		printf("L3GD20_ERROR!\r\n");
	}
	write(L3GD20_CTRL_REG1, 0x0f);
	write(L3GD20_CTRL_REG4, 0x00);
}

float L3GD20::get_x_angular_velocity(void)
{
	return ((read(L3GD20_OUT_X_H)<<8) + read(L3GD20_OUT_X_L));
}

float L3GD20::get_y_angular_velocity(void)
{
	return ((read(L3GD20_OUT_X_H)<<8) + read(L3GD20_OUT_X_L));
}

float L3GD20::get_z_angular_velocity(void)
{
	return ((read(L3GD20_OUT_X_H)<<8) + read(L3GD20_OUT_X_L));
}

void L3GD20::write(int reg, int val)
{
	spi->write(reg);
	spi->write(val);
}

int L3GD20::read(int reg)
{
	spi->write(reg);
	wait_us(10);
	return spi->write(0);
}
