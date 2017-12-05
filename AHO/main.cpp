#include "mbed.h"
#include "machine.h"
#include "aho.h"

Serial pc(USBTX, USBRX);
//AHO aho(pc);
Machine machine(1);

extern "C"
void HardFault_Handler() {
    printf("Hard Fault!\r\n");
    while(1);
}


int main() {
    printf("Hi, I'm SHIRO-OBI!\r\n");
    printf("Welcome to AHO system\r\n");
    wait(1);
    //aho.set_motion(machine.motion);
    machine.motion.pos[0].set_time(2000);
    machine.motion.pos[0].set_angle(0, 96);
    machine.motion.pos[1].set_time(5000);
    machine.motion.pos[1].set_angle(0, 187);
    machine.play_motion(0);
    while(1) {

    }
}
