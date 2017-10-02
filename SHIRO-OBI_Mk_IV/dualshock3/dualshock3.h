#ifndef __DUALSHOCK3
#define __DUALSHOCK3

#include "mbed.h"

class Dualshock3
{
public:
	Dualshock3(PinName, PinName);

	void set_baudrate(int);
	void initialize(void);
	bool circle_is_pushed(void);
	bool cross_is_pushed(void);
	bool rectangle_is_pushed(void);
	bool triangle_is_pushed(void);
	bool up_is_pushed(void);
	bool down_is_pushed(void);
	bool left_is_pushed(void);
	bool right_is_pushed(void);
	bool start_is_pushed(void);
	bool select_is_pushed(void);
	bool r1_is_pushed(void);
	bool l1_is_pushed(void);
	bool r2_is_pushed(void);
	bool l2_is_pushed(void);
	float get_left_stick_x(void);
	float get_left_stick_y(void);
	float get_right_stick_x(void);
	float get_right_stick_y(void);
	bool circle_is_risen(void);
	bool cross_is_risen(void);
	bool rectangle_is_risen(void);
	bool triangle_is_risen(void);
	bool up_is_risen(void);
	bool down_is_risen(void);
	bool left_is_risen(void);
	bool right_is_risen(void);
	bool start_is_risen(void);
	bool select_is_risen(void);
	bool r1_is_risen(void);
	bool l1_is_risen(void);
	bool r2_is_risen(void);
	bool l2_is_risen(void);
	void clear(void);

private:
	static const int DEFAULT_BAUDRATE = 115200;
	static const int DATA_LENGTH = 8;
	static const float CENTER_STICK_VAL = 64;
	static const int UP = 0x0001;//0b 0000 0000 0000 0001
	static const int DOWN = 0x0002;//0b 0000 0000 0000 0010
	static const int RIGHT = 0x0004;//0b 0000 0000 0000 0100
	static const int LEFT = 0x0008;//0b 0000 0000 0000 1000
	static const int TRIANGLE = 0x0010;//0b 0000 0000 0001 0000
	static const int CROSS = 0x0020;//0b 0000 0000 0010 0000
	static const int CIRCLE = 0x0040;//0b 0000 0000 0100 0000
	static const int RECTANGLE = 0x0100;//0b 0000 0001 0000 0000
	static const int L1 = 0x0200;//0b 0000 0010 0000 0000
	static const int L2 = 0x0400;//0b 0000 0100 0000 0000
	static const int R1 = 0x0800;//0b 0000 1000 0000 0000
	static const int R2 = 0x1000;//0b 0001 0000 0000 0000
	static const int START = 0x0003;//0b 0000 0000 0000 0011
	static const int SELECT = 0x000C;//0b 0000 000 0000 1100

	Serial controller;
	int baudrate;
	int data[DATA_LENGTH];
	int button_state;
	int button_risen;
	int previous_button_state;

	void read(void);
};
#endif

