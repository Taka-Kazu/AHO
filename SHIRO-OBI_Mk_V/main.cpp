#include "mbed.h"
#include "machine.h"
#include "dualshock3.h"

Dualshock3 controller(USBTX, USBRX);
Machine machine(1);

int main() {
    
    controller.set_baudrate(115200);
    controller.initialize();
    //machine.alert(1760);
    wait(0.5);
    machine.alert(0);
    machine.power_on();
    printf("Hi, I'm SHIRO-OBI!\r\n");
    

    while(1) {
        machine.play_motion(0);
        printf("kuroda\r\n");
        wait(1.0);
    }
}
