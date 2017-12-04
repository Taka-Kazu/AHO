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
    printf("Hi, I'm SHIRO-OBI!\r\n");
    printf("Welcome to AHO system\r\n");
    wait(1);
    //aho.set_motion(machine.motion);
    while(1) {
            for(int i=0;i<270;i++){
            	machine.move_servo(1, i);
            	machine.move_servo(2, i);
            	wait(0.025);
            }
            for(int i=270;i>0;i--){
            	machine.move_servo(1, i);
            	machine.move_servo(2, i);
                wait(0.025);
            }
    }
}
