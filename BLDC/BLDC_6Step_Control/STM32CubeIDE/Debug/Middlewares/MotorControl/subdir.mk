################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (12.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/bus_voltage_sensor.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Src/g4xx_bemf_ADC_fdbk.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/mcpa.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/ntc_temperature_sensor.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/pid_regulator.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/pwmc_sixstep.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/r_divider_bus_voltage_sensor.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/revup_ctrl_sixstep.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/speed_ctrl.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/speed_pos_fdbk.c \
C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/virtual_speed_sensor.c 

OBJS += \
./Middlewares/MotorControl/bus_voltage_sensor.o \
./Middlewares/MotorControl/g4xx_bemf_ADC_fdbk.o \
./Middlewares/MotorControl/mcpa.o \
./Middlewares/MotorControl/ntc_temperature_sensor.o \
./Middlewares/MotorControl/pid_regulator.o \
./Middlewares/MotorControl/pwmc_sixstep.o \
./Middlewares/MotorControl/r_divider_bus_voltage_sensor.o \
./Middlewares/MotorControl/revup_ctrl_sixstep.o \
./Middlewares/MotorControl/speed_ctrl.o \
./Middlewares/MotorControl/speed_pos_fdbk.o \
./Middlewares/MotorControl/virtual_speed_sensor.o 

C_DEPS += \
./Middlewares/MotorControl/bus_voltage_sensor.d \
./Middlewares/MotorControl/g4xx_bemf_ADC_fdbk.d \
./Middlewares/MotorControl/mcpa.d \
./Middlewares/MotorControl/ntc_temperature_sensor.d \
./Middlewares/MotorControl/pid_regulator.d \
./Middlewares/MotorControl/pwmc_sixstep.d \
./Middlewares/MotorControl/r_divider_bus_voltage_sensor.d \
./Middlewares/MotorControl/revup_ctrl_sixstep.d \
./Middlewares/MotorControl/speed_ctrl.d \
./Middlewares/MotorControl/speed_pos_fdbk.d \
./Middlewares/MotorControl/virtual_speed_sensor.d 


# Each subdirectory must supply rules for building sources it contributes
Middlewares/MotorControl/bus_voltage_sensor.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/bus_voltage_sensor.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/g4xx_bemf_ADC_fdbk.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Src/g4xx_bemf_ADC_fdbk.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/mcpa.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/mcpa.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/ntc_temperature_sensor.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/ntc_temperature_sensor.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/pid_regulator.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/pid_regulator.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/pwmc_sixstep.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/pwmc_sixstep.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/r_divider_bus_voltage_sensor.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/r_divider_bus_voltage_sensor.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/revup_ctrl_sixstep.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/revup_ctrl_sixstep.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/speed_ctrl.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/speed_ctrl.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/speed_pos_fdbk.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/speed_pos_fdbk.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"
Middlewares/MotorControl/virtual_speed_sensor.o: C:/Users/pboon/OneDrive/Desktop/KMUTT/RMX_Lab/FRA231-LAB2-B12-37/BLDC_6Step_Control/MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Src/virtual_speed_sensor.c Middlewares/MotorControl/subdir.mk
	arm-none-eabi-gcc "$<" -mcpu=cortex-m4 -std=gnu11 -g3 -DDEBUG -DARM_MATH_CM4 -DUSE_HAL_DRIVER -DSTM32G474xx -c -I../../Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc -I../../Drivers/STM32G4xx_HAL_Driver/Inc/Legacy -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/Any/Inc -I../../MCSDK_v6.3.2-Full/MotorControl/MCSDK/MCLib/G4xx/Inc -I../../Drivers/CMSIS/Device/ST/STM32G4xx/Include -I../../Drivers/CMSIS/Include -I../../Drivers/CMSIS/DSP/Include -Ofast -ffunction-sections -fdata-sections -Wall -fstack-usage -fcyclomatic-complexity -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@"

clean: clean-Middlewares-2f-MotorControl

clean-Middlewares-2f-MotorControl:
	-$(RM) ./Middlewares/MotorControl/bus_voltage_sensor.cyclo ./Middlewares/MotorControl/bus_voltage_sensor.d ./Middlewares/MotorControl/bus_voltage_sensor.o ./Middlewares/MotorControl/bus_voltage_sensor.su ./Middlewares/MotorControl/g4xx_bemf_ADC_fdbk.cyclo ./Middlewares/MotorControl/g4xx_bemf_ADC_fdbk.d ./Middlewares/MotorControl/g4xx_bemf_ADC_fdbk.o ./Middlewares/MotorControl/g4xx_bemf_ADC_fdbk.su ./Middlewares/MotorControl/mcpa.cyclo ./Middlewares/MotorControl/mcpa.d ./Middlewares/MotorControl/mcpa.o ./Middlewares/MotorControl/mcpa.su ./Middlewares/MotorControl/ntc_temperature_sensor.cyclo ./Middlewares/MotorControl/ntc_temperature_sensor.d ./Middlewares/MotorControl/ntc_temperature_sensor.o ./Middlewares/MotorControl/ntc_temperature_sensor.su ./Middlewares/MotorControl/pid_regulator.cyclo ./Middlewares/MotorControl/pid_regulator.d ./Middlewares/MotorControl/pid_regulator.o ./Middlewares/MotorControl/pid_regulator.su ./Middlewares/MotorControl/pwmc_sixstep.cyclo ./Middlewares/MotorControl/pwmc_sixstep.d ./Middlewares/MotorControl/pwmc_sixstep.o ./Middlewares/MotorControl/pwmc_sixstep.su ./Middlewares/MotorControl/r_divider_bus_voltage_sensor.cyclo ./Middlewares/MotorControl/r_divider_bus_voltage_sensor.d ./Middlewares/MotorControl/r_divider_bus_voltage_sensor.o ./Middlewares/MotorControl/r_divider_bus_voltage_sensor.su ./Middlewares/MotorControl/revup_ctrl_sixstep.cyclo ./Middlewares/MotorControl/revup_ctrl_sixstep.d ./Middlewares/MotorControl/revup_ctrl_sixstep.o ./Middlewares/MotorControl/revup_ctrl_sixstep.su ./Middlewares/MotorControl/speed_ctrl.cyclo ./Middlewares/MotorControl/speed_ctrl.d ./Middlewares/MotorControl/speed_ctrl.o ./Middlewares/MotorControl/speed_ctrl.su ./Middlewares/MotorControl/speed_pos_fdbk.cyclo ./Middlewares/MotorControl/speed_pos_fdbk.d ./Middlewares/MotorControl/speed_pos_fdbk.o ./Middlewares/MotorControl/speed_pos_fdbk.su ./Middlewares/MotorControl/virtual_speed_sensor.cyclo ./Middlewares/MotorControl/virtual_speed_sensor.d ./Middlewares/MotorControl/virtual_speed_sensor.o ./Middlewares/MotorControl/virtual_speed_sensor.su

.PHONY: clean-Middlewares-2f-MotorControl

