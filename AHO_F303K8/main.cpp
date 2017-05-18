#include "mbed.h"
#include "machine.h"
#include "aho.h"

AHO aho;
Machine machine;

int main() {
	aho.set_motion(machine.motion);

    while(1) {

    }
}
