#include "PCA9685.h"
#include "mbed.h"
PCA9685::PCA9685(PinName sda, PinName scl, int addr) : i2c(sda, scl), _i2caddr(addr) {}

void PCA9685::begin(void)
{
    reset();
}

void PCA9685::frequencyI2C(int freq)
{
    i2c.frequency(freq);
}
void PCA9685::write8(uint8_t address, uint8_t data)
{
    char cmd[2];
    cmd[0] = address;
    cmd[1] = data;
    i2c.write(_i2caddr, cmd, 2);
}

char PCA9685::read8(char address)
{
    i2c.write(_i2caddr, &address, 1);
    char rtn;
    i2c.read(_i2caddr, &rtn, 1);
    return rtn;
}

void PCA9685::reset(void)
{
    write8(PCA9685_MODE1, 0x0);
}
void PCA9685::setPrescale(uint8_t prescale) {
    uint8_t oldmode = read8(PCA9685_MODE1);
    uint8_t newmode = (oldmode&0x7F) | 0x10; // sleep
    write8(PCA9685_MODE1, newmode); // go to sleep
    wait_ms(5);
    write8(PCA9685_PRESCALE, prescale); // set the prescaler
    write8(PCA9685_MODE1, oldmode);
    wait_ms(5);
    write8(PCA9685_MODE1, oldmode | 0xa1);
}
void PCA9685::setPWMFreq(float freq)
{
    float prescaleval = 25000000;
    prescaleval /= 4096;
    prescaleval /= freq;
    uint8_t prescale = floor(prescaleval  + 0.5) - 1;
    setPrescale(prescale);
}

void PCA9685::setPWM(uint8_t num, uint16_t on, uint16_t off)
{
    char cmd[5];
    cmd[0] = LED0_ON_L + 4 * num;
    cmd[1] = on;
    cmd[2] = on >> 8;
    cmd[3] = off;
    cmd[4] = off >> 8;
    i2c.write(_i2caddr, cmd, 5);
    /*
    wait_ms(5);
    int a = read8(6);
    wait_ms(5);
    int b = read8(7);
    wait_ms(5);
    int c = read8(8);
    wait_ms(5);
    int d = read8(9);
    printf("%d, %d, %d, %d\r\n", a, b, c, d);
    */
}
