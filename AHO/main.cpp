#include "mbed.h"
#include "machine.h"
#include "aho.h"

Serial pc(USBTX, USBRX);
AHO aho(pc);
Machine machine(1);

extern "C"
void HardFault_Handler() {
    printf("Hard Fault!\r\n");
    while(1);
}


int main() {
    //printf("Hi, I'm SHIRO-OBI!\r\n");
    //printf("Welcome to AHO system\r\n");
    wait(1);
    aho.set_motion(machine.motion);
    while(1) {
        if(aho.has_changed()){
            machine.play_motion(0);
        }

    }
}
