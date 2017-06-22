#include "position.h"

Position::Position(void)
{
	time_ms = 0;
	servo_angle = new uint8_t[SERVO_NUM];
	for(int i=0;i<SERVO_NUM;i++){
		servo_angle[i] = 90;
	}
}

void Position::set_param(char* str)
{
	int val = 0;
	const int8_t BUFF_NUM = 5;
	char buff[BUFF_NUM] = {0};
	int j=0;
	int servo_num = 0;
	for(int16_t i=0;i<1000;i++){
		if(str[i] == '\n'){
			break;
		}else if(str[i] != ','){
			buff[j] += str[i];
			j++;
		}else{
			buff[j] = '\0';
			val = atoi(buff);
			if(time_ms == 0){
				time_ms = val;
				for(int k=0;k<BUFF_NUM;k++){
					buff[k] = 0;
				}
				j=0;
			}else{
				servo_angle[servo_num] = val;
				servo_num++;
				for(int k=0;k<BUFF_NUM;k++){
					buff[k] = 0;
				}
				j=0;
			}
		}
	}
}

int Position::get_time(void)
{
	int temp = time_ms;
	time_ms = 0;
	return temp;
}

int Position::get_angle(int id)
{
	if((0<=id) && (id < SERVO_NUM)){
		return servo_angle[id];
	}else{
		return 0;
	}
}
