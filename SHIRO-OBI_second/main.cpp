#define NDEBUG

#include "mbed.h"
#include "machine.h"

SPI spi(PB_5, PB_4, PB_3);
L3GD20 gyro(spi, PF_0);

extern "C"
void HardFault_Handler()
{
	printf("Hard_Fault\r\n");
}

int main() {

	DigitalOut a(PF_1);
	a=1;
	DigitalOut s(PA_11);
	s = 1;
	wait(1);

	printf("Hi, I'm SHIRO-OBI!\r\n");
	//printf("%d, %d, %d\r\n", sizeof(Position), sizeof(Motion), sizeof(Machine));
	wait(1);
    while(1) {
    	int val = gyro.get_x_angular_velocity();

    	printf("v = %d\r\n", val);
    	wait(1.0);
    }
}
