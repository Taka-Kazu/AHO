#include "buzzer.h"

Buzzer::Buzzer(PinName pin)
:buzzer(pin)
{

}

void Buzzer::alert(int hz)
{
	if(hz<=0.0){
		buzzer.write(0);
	}else{
		buzzer.period(1.0f/hz);
		buzzer.write(0.5f);
	}
}
