#include "mbed.h"
#include "machine.h"
#include "aho.h"

Serial pc(USBTX, USBRX);
AHO aho(pc);
Machine machine(1);

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
    wait(0.5);
    printf("Hi, I'm SHIRO-OBI!\r\n");
    printf("Welcome to AHO system\r\n");
    aho.set_motion(machine.motion);

    while(1) {
        machine.play_motion(0);
    }
}
