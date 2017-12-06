#include "motion.h"

Motion::Motion(void)
{

}

void Motion::reset(void)
{
	__disable_irq();
	for(int i=0;i<POS_NUM;i++){
		pos[i].reset();
	}
	__enable_irq();
}
