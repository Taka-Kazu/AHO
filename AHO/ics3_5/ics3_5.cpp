#include "ics3_5.h"

ICS3_5::ICS3_5(Serial& _serial, PinName _enpin)
:serial(&_serial), enable_pin(_enpin)
{
    serial->format(8, Serial::Even, 1);
    serial->baud(115200);
    input();
    wait(0.5);
    //debug
    output();
}

void ICS3_5::move(int id, float degree)
{
    //input();
    while(serial->readable()){
        printf("readable:0x%X\r\n", serial->getc());
    }
    if(degree > MAX_ANGLE){
        degree = MAX_ANGLE;
    }else if(degree < MIN_ANGLE){
        degree = MIN_ANGLE;
    }
    uint8_t cmd[3];
    cmd[0] = (0x80 | id);
    uint16_t deg_val = (degree) * (MAX_VAL - MIN_VAL) / (MAX_ANGLE - MIN_ANGLE) + MIN_VAL;
    cmd[1] = ((deg_val >> 7) & 0b01111111);
    cmd[2] = (deg_val & 0b01111111);
    output();
    wait_us(50);
    //printf("degree = %.1f, deg_val = %d\r\n", degree, deg_val);
    //while(serial->writeable()){}
    for(int i=0;i<3;i++){
        serial->putc(cmd[i]);
        //printf("send:0x%X\r\n", cmd[i]);
    }
    //wait_us(50);
    //input();
    while(serial->readable()){
        printf("readable:0x%X\r\n", serial->getc());
    }
    wait_us(50);
}

void ICS3_5::output(void)
{
    enable_pin = 1;
}

void ICS3_5::input(void)
{
    enable_pin = 0;
}
