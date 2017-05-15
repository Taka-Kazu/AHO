################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../test/test.cpp 

OBJS += \
./test/test.o 

CPP_DEPS += \
./test/test.d 


# Each subdirectory must supply rules for building sources it contributes
test/%.o: ../test/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: MCU G++ Compiler'
	@echo %cd%
	arm-none-eabi-g++ -mcpu=cortex-m4 -mthumb  -mfpu=fpv4-sp-d16 -DDEVICE_I2C=1 -D__MBED__=1 -DDEVICE_I2CSLAVE=1 -DTARGET_LIKE_MBED -DDEVICE_PORTINOUT=1 -DTARGET_RTOS_M4_M7 -DDEVICE_LOWPOWERTIMER=1 -DDEVICE_RTC=1 -DTOOLCHAIN_object -DDEVICE_SERIAL_ASYNCH=1 -D__CMSIS_RTOS -DDEVICE_ANALOGOUT=1 -DTOOLCHAIN_GCC -DDEVICE_CAN=1 -DTARGET_CORTEX_M -DTARGET_LIKE_CORTEX_M4 -DTARGET_STM32L476RG -DTARGET_M4 -DTARGET_UVISOR_UNSUPPORTED -DARM_MATH_CM4 -DTARGET_STM32L4 -DDEVICE_SERIAL=1 -DDEVICE_INTERRUPTIN=1 -DTARGET_NUCLEO_L476RG -DDEVICE_PORTOUT=1 -D__CORTEX_M4 -DDEVICE_STDIO_MESSAGES=1 -DTARGET_FF_MORPHO -D__FPU_PRESENT=1 -DTARGET_FF_ARDUINO -DDEVICE_PORTIN=1 -DTARGET_RELEASE -DTARGET_STM -DDEVICE_SERIAL_FC=1 -D__MBED_CMSIS_RTOS_CM -DDEVICE_SLEEP=1 -DTOOLCHAIN_GCC_ARM -DDEVICE_SPI=1 -DDEVICE_SPISLAVE=1 -DDEVICE_ANALOGIN=1 -DDEVICE_PWMOUT=1 -DMBED_BUILD_TIMESTAMP=1494656752.6 -I"E:/SW4STM32/SHIRO-OBI_mbed/." -I"E:/SW4STM32/SHIRO-OBI_mbed/mbed/." -I"E:/SW4STM32/SHIRO-OBI_mbed/mbed/TARGET_NUCLEO_L476RG" -I"E:/SW4STM32/SHIRO-OBI_mbed/mbed/TARGET_NUCLEO_L476RG/TARGET_STM" -I"E:/SW4STM32/SHIRO-OBI_mbed/mbed/TARGET_NUCLEO_L476RG/TARGET_STM/TARGET_STM32L4" -I"E:/SW4STM32/SHIRO-OBI_mbed/mbed/TARGET_NUCLEO_L476RG/TARGET_STM/TARGET_STM32L4/TARGET_NUCLEO_L476RG" -I"E:/SW4STM32/SHIRO-OBI_mbed/mbed/TARGET_NUCLEO_L476RG/TOOLCHAIN_GCC_ARM" -I"E:/SW4STM32/SHIRO-OBI_mbed/" -I"E:/SW4STM32/SHIRO-OBI_mbed/test" -O0 -g3 -Wall -fmessage-length=0 -ffunction-sections -c -fno-exceptions -fno-rtti -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


