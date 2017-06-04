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
	cs=1;
}

float L3GD20::get_x_angular_velocity(void)
{
	float angular_velocity = ((read(L3GD20_OUT_X_H)<<8) + read(L3GD20_OUT_X_L))*L3GD20_RESOLUTION;
	return angular_velocity;
}

float L3GD20::get_y_angular_velocity(void)
{
	float angular_velocity = ((read(L3GD20_OUT_Y_H)<<8) + read(L3GD20_OUT_Y_L))*L3GD20_RESOLUTION;
	return angular_velocity;
}

float L3GD20::get_z_angular_velocity(void)
{
	float angular_velocity = ((read(L3GD20_OUT_Z_H)<<8) + read(L3GD20_OUT_Z_L))*L3GD20_RESOLUTION;
	return angular_velocity;
}

void L3GD20::write(uint16_t reg, uint16_t val)
{
	cs=0;
	spi->write(reg);
	cs=1;
	cs=0;
	spi->write(val);
	cs=1;
}

uint8_t L3GD20::read(uint16_t reg)
{
	cs=0;
	spi->write(reg);
	cs=1;
	wait_us(10);
	cs=0;
	uint8_t data = spi->write(0);
	cs=1;
	return data;
}
