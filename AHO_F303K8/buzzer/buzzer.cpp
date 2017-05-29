#include "buzzer.h"

Buzzer::Buzzer(PinName pin)
:buzzer(pin)
{

}

void Buzzer::alert(int hz)
{
	buzzer.period(1.0f/hz);
	buzzer.write(0.5f);
}
