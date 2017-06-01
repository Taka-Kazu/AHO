#define NDEBUG

#include "mbed.h"
#include "machine.h"

Serial pc(USBTX, USBRX);
Machine machine(1);


void set_motions(void);
extern "C"
void HardFault_Handler()
{
	printf("Hard_Fault\r\n");
}

int main() {
	machine.alert(1760);
	wait(0.5);
	machine.alert(0);
	machine.power_on();
	printf("Hi, I'm SHIRO-OBI!\r\n");
	printf("%d, %d, %d,\r\n", sizeof(Position), sizeof(Motion), sizeof(Machine));

    while(1) {
    	for(int i=0;i<180;i++){
    		machine.move_servo(0, i);
    		wait(0.5);
    	}
    }
}

void set_motions(void)
{
	machine.motion.pos[0].set_param("100,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90\n");
}
