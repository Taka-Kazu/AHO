#include "machine.h"

Machine::Machine(void)
:servos(SDA, SCL), servo16(SERVO16_PIN), servo17(SERVO17_PIN)
{

}
