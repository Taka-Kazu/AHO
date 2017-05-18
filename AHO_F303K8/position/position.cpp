#include "position.h"

Position::Position(void)
:time_ms(0), servo_angle(SERVO_NUM, 90)
{

}

void Position::set_param(string str)
{
	string buff("");
	int servo_num = 0;
	for(int i=0;i<1000;i++){
		if(str[i] == '\n'){
			break;
		}else if(str[i] != ','){
			buff += str[i];
		}else{
			if(time_ms == 0){
				time_ms = atoi(buff.c_str());
				buff = "";
			}else{
				servo_angle[servo_num++] = atoi(buff.c_str());
				buff = "";
			}
		}
	}
}

int Position::get_time(void)
{
	return time_ms;
}

int Position::get_angle(int id)
{
	if((0<=id) && (id < SERVO_NUM)){
		return servo_angle[id];
	}else{
		return 0;
	}
}
