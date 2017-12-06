#include "motion.h"

Motion::Motion(void)
{

}

void Motion::reset(void)
{
	for(int i=0;i<POS_NUM;i++){
		pos[i].reset();
	}
}
