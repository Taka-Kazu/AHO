#include "mbed.h"
#include "machine.h"
#include "aho.h"

AHO aho;
Machine machine(1);

void set_motions(void);

int main() {
	printf("High, I'm SHIRO-OBI!\r\n");
	aho.set_motion(machine.motion[0]);

    while(1) {
    	machine.play_motion(0);
    }
}

void set_motions(void)
{
	machine.motion[0].pos[0].set_param("100,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90,90\n");
}
