#ifndef __ICS3_5_H
#define __ICS3_5_H

#include "mbed.h"

class ICS3_5
{
public:
    ICS3_5(Serial&, PinName);
    
    void move(int, float);
private:
    static const float MIN_ANGLE = 0;
    static const float CENTER_ANGLE = 135;
    static const float MAX_ANGLE = 270;
    static const int MIN_VAL = 3500;
    static const int CENTER_VAL = 7500;
    static const int MAX_VAL = 11500;

    Serial* serial;
    DigitalOut enable_pin;
    
    void output(void);
    void input(void);
    
};

#endif
