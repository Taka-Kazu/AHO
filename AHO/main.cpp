#include "mbed.h"
#include "machine.h"
#include "aho.h"
#include "dualshock3.h"

#define ENABLE_AHO

#ifdef ENABLE_AHO
Serial pc(USBTX, USBRX);
AHO aho(pc);
#else
Dualshock3 ds3(PA_2, PA_3);
#endif
Machine machine(100);


extern "C"
void HardFault_Handler() {
    printf("Hard Fault!\r\n");
    while(1);
}


int main() {
    printf("Hi, I'm SHIRO-OBI!\r\n");
    printf("Welcome to AHO system\r\n");
    wait(1);
#ifdef ENABLE_AHO
    aho.set_motion(machine.motion);
    while(1) {
            if(aho.has_changed()){
                machine.play_motion(0);
            }
    }
#else
    ds3.initialize();
    while(1) {
    	if(ds3.l1_has_been_pushed()){
    		machine.play_motion(2);
    	}else if(ds3.select_has_been_pushed()){
    		machine.free();
    	}else if(ds3.get_left_stick_y() > 0.5){
    		machine.play_motion(4);
    	}
    	ds3.clear();
    }
#endif
}
