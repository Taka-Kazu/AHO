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

bool AHO::has_changed(void)
{
	bool temp = flag;
	flag = false;
	return temp;
}

void AHO::initialize(void)
{
	flag = false;
	pc->baud(BAUDRATE);
	pc->attach(callback(this, &AHO::interrupt), Serial::RxIrq);
	for(int i=0;i<POS_NUM;i++){
		for(int j=0;j<STR_LENGTH;j++){
			str[i][j] = 0;
		}
	}
}

void AHO::interrupt(void)
{
	__disable_irq();
	char c;
	int8_t str_j = 0;//param2
	int8_t str_k = 0;//param1
	while(1){
		while(!pc->readable())
		{
		}
		pc->scanf("%c", &c);
		if(c=='\0'){
			for(int i=0;i<str_k;i++){
				motion->pos[i].set_param(str[i]);
			}
			break;
		}
		str[str_k][str_j] = c;
		str_j++;
		if(c=='\n'){
			str_k++;
			str_j=0;
		}
	}
	flag = true;
	__enable_irq();
}

