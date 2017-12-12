#include "dualshock3.h"

Dualshock3::Dualshock3(PinName tx, PinName rx)
:controller(tx, rx), baudrate(DEFAULT_BAUDRATE)
{
	button_state = 0;
	button_risen = 0;
	previous_button_state = button_state;
	data[3] = 0x40;
	data[4] = 0x40;
	data[5] = 0x40;
	data[6] = 0x40;
	//printf("dualshock3 is ready\r\n");
}

void Dualshock3::set_baudrate(int baud)
{
	baudrate = baud;
}

void Dualshock3::initialize(void)
{
	controller.baud(baudrate);
	controller.attach(callback(this, &Dualshock3::read), Serial::RxIrq);
}

void Dualshock3::clear(void)
{
	button_state = 0;
	button_risen = 0;
}

void Dualshock3::read(void)
{
	__disable_irq();
	data[0] = controller.getc();
	if(data[0]==0x80){
		for(int i=1;i<DATA_LENGTH;i++){
			data[i] = controller.getc();
		}
		//printf("hi\r\n");
		button_state = (data[1]<<DATA_LENGTH) + data[2];
		//今該当ボタンのビットが1で、前回は0なら、risenを1にする
		if((button_state & UP) && !(previous_button_state & UP)){
			button_risen |= UP;
		}
		if((button_state & DOWN) && !(previous_button_state & DOWN)){
			button_risen |= DOWN;
		}
		if((button_state & LEFT) && !(previous_button_state & LEFT)){
			button_risen |= LEFT;
		}
		if((button_state & RIGHT) && !(previous_button_state & RIGHT)){
			button_risen |= RIGHT;
		}
		if((button_state & TRIANGLE) && !(previous_button_state & TRIANGLE)){
			button_risen |= TRIANGLE;
		}
		if((button_state & CROSS) && !(previous_button_state & CROSS)){
			button_risen |= CROSS;
		}
		if((button_state & CIRCLE) && !(previous_button_state & CIRCLE)){
			button_risen |= CIRCLE;
		}
		if((button_state & RECTANGLE) && !(previous_button_state & RECTANGLE)){
			button_risen |= RECTANGLE;
		}
		if((button_state & L1) && !(previous_button_state & L1)){
			button_risen |= L1;
		}
		if((button_state & L2) && !(previous_button_state & L2)){
			button_risen |= L2;
		}
		if((button_state & R1) && !(previous_button_state & R1)){
			button_risen |= R1;
		}
		if((button_state & R2) && !(previous_button_state & R2)){
			button_risen |= R2;
		}
		if((button_state & START) && !(previous_button_state & START)){
			button_risen |= START;
		}
		if((button_state & SELECT) && !(previous_button_state & SELECT)){
			button_risen |= SELECT;
		}
		previous_button_state = button_state;
	}
	__enable_irq();
	//printf("bi\r\n");
}

bool Dualshock3::circle_is_pushed(void)
{
	if(button_state & CIRCLE){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::cross_is_pushed(void)
{
	if(button_state & CROSS){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::rectangle_is_pushed(void)
{
	if(button_state & RECTANGLE){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::triangle_is_pushed(void)
{
	if(button_state & TRIANGLE){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::up_is_pushed(void)
{
	if(button_state & UP){
		if(button_state & DOWN){
			return 0;
		}else{
			return true;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::down_is_pushed(void)
{
	if(button_state & DOWN){
		if(button_state & UP){
			return 0;
		}else{
			return true;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::left_is_pushed(void)
{
	if(button_state & LEFT){
		if(button_state & RIGHT){
			return 0;
		}else{
			return true;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::right_is_pushed(void)
{
	if(button_state & RIGHT){
		if(button_state & LEFT){
			return 0;
		}else{
			return true;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::l1_is_pushed(void)
{
	if(button_state & L1){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::l2_is_pushed(void)
{
	if(button_state & L2){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::r1_is_pushed(void)
{
	if(button_state & R1){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::r2_is_pushed(void)
{
	if(button_state & R2){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::start_is_pushed(void)
{
	if((button_state & START) == START){
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::select_is_pushed(void)
{
	if((button_state & SELECT) == SELECT){
		return true;
	}else{
		return 0;
	}
}

float Dualshock3::get_left_stick_x(void)
{
	return (float)(data[3] - CENTER_STICK_VAL) / CENTER_STICK_VAL;
}

float Dualshock3::get_left_stick_y(void)
{
	return -(float)(data[4] - CENTER_STICK_VAL) / CENTER_STICK_VAL;
}

float Dualshock3::get_right_stick_x(void)
{
	return (float)(data[5] - CENTER_STICK_VAL) / CENTER_STICK_VAL;
}

float Dualshock3::get_right_stick_y(void)
{
	return -(float)(data[6] - CENTER_STICK_VAL) / CENTER_STICK_VAL;
}

bool Dualshock3::circle_has_been_pushed(void)
{
	if(button_risen & CIRCLE){
		button_risen = 0;
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::cross_has_been_pushed(void)
{
	if(button_risen & CROSS){
		button_risen = 0;
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::rectangle_has_been_pushed(void)
{
	if(button_risen & RECTANGLE){
		button_risen = 0;
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::triangle_has_been_pushed(void)
{
	if(button_risen & TRIANGLE){
		button_risen = 0;
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::up_has_been_pushed(void)
{
	if(button_risen & UP){
		if(up_is_pushed()){
			button_risen = 0;
			return true;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::down_has_been_pushed(void)
{
	if(button_risen & DOWN){
		if(down_is_pushed()){
			button_risen = 0;
			return true;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::left_has_been_pushed(void)
{
	if(button_risen & LEFT){
		if(left_is_pushed()){
			button_risen = 0;
			return true;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::right_has_been_pushed(void)
{
	if(button_risen & RIGHT){
		if(right_is_pushed()){
			button_risen = 0;
			return true;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::l1_has_been_pushed(void)
{
	if(button_risen & L1){
		button_risen = 0;
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::l2_has_been_pushed(void)
{
	if(button_risen & L2){
		button_risen = 0;
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::r1_has_been_pushed(void)
{
	if(button_risen & R1){
		button_risen = 0;
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::r2_has_been_pushed(void)
{
	if(button_risen & R2){
		button_risen = 0;
		return true;
	}else{
		return 0;
	}
}

bool Dualshock3::start_has_been_pushed(void)
{
	if((button_risen & START) == START){
		if(start_is_pushed()){
			button_risen = 0;
			return true;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}

bool Dualshock3::select_has_been_pushed(void)
{
	if((button_risen & SELECT) == SELECT){
		if(select_is_pushed()){
			button_risen = 0;
			return true;
		}else{
			return 0;
		}
	}else{
		return 0;
	}
}

