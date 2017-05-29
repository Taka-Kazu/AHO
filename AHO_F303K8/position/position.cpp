#include "position.h"

Position::Position(void)
{
	time_ms = 0;
}

void Position::set_param(char* str)
{
	printf("%s", str);
	int val = 0;
	const int8_t BUFF_NUM = 5;
	char buff[BUFF_NUM] = {0};
	int _time_ms = 0;
	printf("t=0x%X\r\n", time_ms);

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
			printf("%d\r\n", val);
			if(0){
				time_ms = _time_ms = val;
				for(int k=0;k<BUFF_NUM;k++){
					buff[k] = 0;
				}
				j=0;
				printf("time=%d\r\n", time_ms);
			}else{
				servo_angle[servo_num] = val;
				servo_num++;
				for(int k=0;k<BUFF_NUM;k++){
					buff[k] = 0;
				}
				j=0;
				printf("servo[%d]=%d\r\n", servo_num-1, servo_angle[servo_num-1]);
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
