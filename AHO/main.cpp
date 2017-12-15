#include "mbed.h"
#include "machine.h"
#include "aho.h"
#include "dualshock3.h"

InterruptIn mode_switch(PA_12);
bool enable_aho = false;

void change_mode(void)
{
	NVIC_SystemReset();
}
extern "C"
void HardFault_Handler() {
    printf("Hard Fault!\r\n");
    while(1);
}


int main() {
	mode_switch.rise(change_mode);
	mode_switch.fall(change_mode);
	Machine machine(100);
    //printf("Hi, I'm SHIRO-OBI!\r\n");
    //printf("Welcome to AHO system\r\n");
    wait(1);
    if(mode_switch == 0){
    	machine.alert(1760);
    	wait(0.5);
    	machine.alert(0);
    	wait(0.5);
    	Serial pc(USBTX, USBRX);
    	AHO aho(pc);
    	aho.set_motion(machine.motion);
    	while(1) {
    		if(aho.has_changed()){
                machine.play_motion(0);
            }
    	}
    }else{
    	Dualshock3 ds3(PA_2, PA_3);
    	ds3.initialize();
    	machine.alert(1760);
    	wait(0.1);
    	machine.alert(0);
    	wait(0.1);
    	machine.alert(1760);
    	wait(0.1);
    	machine.alert(0);
    	wait(0.1);
    	machine.alert(1760);
    	wait(0.1);
    	machine.alert(0);
    	wait(0.1);
    	float interval = 0.3;
    	while(1) {
    		if(ds3.l1_has_been_pushed()){
    			machine.play_motion(2);
    		}else if(ds3.select_has_been_pushed()){
    			machine.free();
    		}else if(ds3.get_left_stick_y() > 0.5){
    			machine.play_motion(4);
    			continue;
    		}else if(ds3.get_left_stick_y() < -0.5){
    			machine.play_motion(5);
    			continue;
    		}else if(ds3.get_right_stick_x() > 0.5){
    			machine.play_motion(6);
    			continue;
    		}else if(ds3.get_right_stick_x() < -0.5){
    			machine.play_motion(7);
    			continue;
    		}else if(ds3.up_has_been_pushed()){
    			machine.play_motion(8);
    		}else if(ds3.start_has_been_pushed()){
    			machine.play_motion(9);
    		}else{

    		}
    		ds3.clear();
    		wait(interval);
    	}
    }
}
