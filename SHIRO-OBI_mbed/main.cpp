#include "mbed.h"
#include "test.h"
 
AnalogIn analog_value(A0);
 
DigitalOut led(LED1);

int main() {
    float meas;
    Test test;
    
    printf("\nAnalogIn example\n");
    
    while(1) {
        meas = analog_value.read(); // Converts and read the analog input value (value from 0.0 to 1.0)
        meas = meas * 3300; // Change the value to be in the 0 to 3300 range
        printf("measure = %.0f mV\n", meas);
        if (meas > 2000) { // If the value is greater than 2V then switch the LED on
          led = 1;
        }
        else {
          led = 0;
        }
        wait(0.2); // 200 ms
    }
}
