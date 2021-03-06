#define NDEBUG

#include "mbed.h"
#include "machine.h"
#include "aho.h"

Serial pc(USBTX, USBRX);
AHO aho(pc);
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
	printf("%d, %d, %d, %d\r\n", sizeof(Position), sizeof(Motion), sizeof(AHO), sizeof(Machine));
	aho.set_motion(machine.motion);

    while(1) {
    	machine.play_motion(0);
    }
}

void set_motions(void)
{
	machine.motion.pos[0].set_param("100,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90\n");
}
