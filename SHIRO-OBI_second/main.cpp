#define NDEBUG

#include "mbed.h"
#include "machine.h"



extern "C"
void HardFault_Handler()
{
	printf("Hard_Fault\r\n");
}

int main() {

	SPI spi(PB_5, PB_4, PB_3);
	L3GD20 gyro(spi, PF_0);
	printf("Hi, I'm SHIRO-OBI!\r\n");
	//printf("%d, %d, %d\r\n", sizeof(Position), sizeof(Motion), sizeof(Machine));

    while(1) {
    	printf("v = %f\r\n", gyro.get_x_angular_velocity());
    	wait(1);
    }
}
