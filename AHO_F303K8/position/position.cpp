#include "position.h"

Position::Position(void)
{

}

Position::Position(char* str)
:time_ms(0)
{
	string buff("");
	int servo_num = 0;
	for(int i=0;i<1000;i++){
		char c = str[i];
		if(c == '\n'){
			break;
		}else if(c != ','){
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
