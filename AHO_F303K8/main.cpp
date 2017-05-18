#include "mbed.h"
#include "machine.h"

DigitalOut myled(LED1);

int main() {
    while(1) {
    	char* str = "a";
    	Position pos0;
    	pos0.set_param(str);
        myled = 1; // LED is ON
        wait(0.2); // 200 ms
        myled = 0; // LED is OFF
        wait(1.0); // 1 sec
    }
}
