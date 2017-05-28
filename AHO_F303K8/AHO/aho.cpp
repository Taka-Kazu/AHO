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
	int i=0;
	char c[2] = {'c'};
	string str;
	while(1){
		while(!pc->readable());
		pc->scanf("%c", &c[0]);
		if(c[0]=='\0'){
			break;
		}
		str+=c;
		if(c[0]=='\n'){
			motion->pos[i].set_param(str);
			i++;
			str="";
		}
	}
	/*
	const char* cstr = str.c_str();
	pc->printf("%s\r\n", cstr);
	*/
	pc->printf("end\r\n");
}
