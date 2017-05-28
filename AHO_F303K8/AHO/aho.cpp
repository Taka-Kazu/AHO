#include "aho.h"

AHO::AHO(void)
{
	pc = new Serial(USBTX, USBRX);
	initialize();
}
AHO::AHO(Serial& s_ptr)
:pc(&s_ptr)
{
	initialize();
}

void AHO::set_motion(Motion& m)
{
	motion = &m;
}

void AHO::initialize(void)
{
	pc->baud(BAUDRATE);
	pc->attach(callback(this, &AHO::interrupt), Serial::RxIrq);
}

void AHO::interrupt(void)
{
	char c;
	while(pc->readable()){
		pc->scanf("%c", &c);
		pc->printf("%c", c);
	}
}
