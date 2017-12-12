#include "mbed.h"
#include "machine.h"
#include "aho.h"
#include "dualshock3.h"

//Serial pc(USBTX, USBRX);
//AHO aho(pc);
Machine machine(10);
Dualshock3 ds3(PA_2, PA_3);

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
    ds3.initialize();
    while(1) {
    	/*
        if(aho.has_changed()){
            machine.play_motion(0);
        }
        */
    	if(ds3.l1_has_been_pushed()){
    		machine.play_motion(2);
    	}
    	ds3.clear();
    	wait(0.1);
    }
}
