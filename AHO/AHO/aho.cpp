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
	uint8_t c[2] = {0};
	int data_count = 0;
	int pos_count = 0;

	while(1){
		int count = 0;
		while(!pc->readable())
		{
			count++;
			if(count == 1000000){
				return;
			}
		}
		c[0] = pc->getc();
		c[1] = pc->getc();
		data[data_count] = (c[0]<<8) + c[1];
		data_count++;
		if(data_count == DATA_LENGTH){
			motion->pos[pos_count].set_time(data[0]);
			for(int i=0;i<DATA_LENGTH;i++){
				motion->pos[pos_count].set_angle(i, data[i+1]);
			}
			break;
		}
		pos_count++;
	}
	flag = true;
	__enable_irq();
}

