
/**
  ******************************************************************************
  * @file    mc_parameters.c
  * @author  Motor Control SDK Team, ST Microelectronics
  * @brief   This file provides definitions of HW parameters specific to the
  *          configuration of the subsystem.
  *
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2024 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */

/* Includes ------------------------------------------------------------------*/
//cstat -MISRAC2012-Rule-21.1
#include "main.h" //cstat !MISRAC2012-Rule-21.1
//cstat +MISRAC2012-Rule-21.1
#include "parameters_conversion.h"
#include "pwmc_sixstep.h"
#include "g4xx_bemf_ADC_fdbk.h"

/* USER CODE BEGIN Additional include */

/* USER CODE END Additional include */
#define UH_POLARITY                 (uint16_t)(0x0000)
#define VH_POLARITY                 (uint16_t)(0x0000)
#define WH_POLARITY                 (uint16_t)(0x0000)
#define UL_POLARITY                 (uint16_t)(0x0008)
#define VL_POLARITY                 (uint16_t)(0x0080)
#define WL_POLARITY                 (uint16_t)(0x0800)

#define CCER_POLARITY_STEP14        UH_POLARITY | UL_POLARITY | VH_POLARITY | VL_POLARITY
#define CCER_POLARITY_STEP25        UH_POLARITY | UL_POLARITY | WH_POLARITY | WL_POLARITY
#define CCER_POLARITY_STEP36        WH_POLARITY | WL_POLARITY | VH_POLARITY | VL_POLARITY
#define CCER_POLARITY_MIDSTEP       UH_POLARITY | UL_POLARITY | VH_POLARITY | VL_POLARITY | WH_POLARITY | WL_POLARITY

#define CCER_UH_VH_UL_VL            (uint16_t)(0x1055)
#define CCER_UH_WH_UL_WL            (uint16_t)(0x1505)
#define CCER_VH_WH_VL_WL            (uint16_t)(0x1550)
#define CCER_UH_VH_WH_UL_VL_WL      (uint16_t)(0x1555)
#define CCER_STEP14                 CCER_UH_VH_UL_VL | CCER_POLARITY_STEP14
#define CCER_STEP25                 CCER_UH_WH_UL_WL | CCER_POLARITY_STEP25
#define CCER_STEP36                 CCER_VH_WH_VL_WL | CCER_POLARITY_STEP36
#define CCER_MIDSTEP                CCER_UH_VH_WH_UL_VL_WL | CCER_POLARITY_MIDSTEP
#define CCER_UH_VH_VL               (uint16_t)(0x1051)
#define CCER_UH_WH_WL               (uint16_t)(0x1501)
#define CCER_VH_WH_WL               (uint16_t)(0x1510)
#define CCER_UH_VH_UL               (uint16_t)(0x1015)
#define CCER_UH_WH_UL               (uint16_t)(0x1105)
#define CCER_VH_WH_VL               (uint16_t)(0x1150)
#define CCER_STEP1_QUASISYNC        CCER_UH_VH_VL | CCER_POLARITY_MIDSTEP
#define CCER_STEP2_QUASISYNC        CCER_UH_WH_WL | CCER_POLARITY_MIDSTEP
#define CCER_STEP3_QUASISYNC        CCER_VH_WH_WL | CCER_POLARITY_MIDSTEP
#define CCER_STEP4_QUASISYNC        CCER_UH_VH_UL | CCER_POLARITY_MIDSTEP
#define CCER_STEP5_QUASISYNC        CCER_UH_WH_UL | CCER_POLARITY_MIDSTEP
#define CCER_STEP6_QUASISYNC        CCER_VH_WH_VL | CCER_POLARITY_MIDSTEP

#define CCMR1_CW_STEP1_MIDALIGN    	(uint16_t)(0x4868)
#define CCMR1_CW_STEP2_MIDALIGN   	(uint16_t)(0x4868)
#define CCMR1_CW_STEP3_MIDALIGN   	(uint16_t)(0x6868)
#define CCMR1_CW_STEP4_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR1_CW_STEP5_MIDALIGN  	(uint16_t)(0x6848)
#define CCMR1_CW_STEP6_MIDALIGN  	(uint16_t)(0x4848)
#define CCMR2_CW_STEP1_MIDALIGN    	(uint16_t)(0x6868)
#define CCMR2_CW_STEP2_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR2_CW_STEP3_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR2_CW_STEP4_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR2_CW_STEP5_MIDALIGN  	(uint16_t)(0x6868)
#define CCMR2_CW_STEP6_MIDALIGN  	(uint16_t)(0x6868)

#define CCMR1_CCW_STEP1_MIDALIGN   	(uint16_t)(0x4868)
#define CCMR1_CCW_STEP2_MIDALIGN   	(uint16_t)(0x6868)
#define CCMR1_CCW_STEP3_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR1_CCW_STEP4_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR1_CCW_STEP5_MIDALIGN  	(uint16_t)(0x4848)
#define CCMR1_CCW_STEP6_MIDALIGN  	(uint16_t)(0x4868)
#define CCMR2_CCW_STEP1_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR2_CCW_STEP2_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR2_CCW_STEP3_MIDALIGN   	(uint16_t)(0x6848)
#define CCMR2_CCW_STEP4_MIDALIGN   	(uint16_t)(0x6868)
#define CCMR2_CCW_STEP5_MIDALIGN  	(uint16_t)(0x6868)
#define CCMR2_CCW_STEP6_MIDALIGN  	(uint16_t)(0x6868)

#define CCMR1_STEP1_HSMOD         	(uint16_t)(0x4868)
#define CCMR1_STEP2_HSMOD        	(uint16_t)(0x0868)
#define CCMR1_STEP3_HSMOD  	        (uint16_t)(0x6808)
#define CCMR1_STEP4_HSMOD  	        (uint16_t)(0x6848)
#define CCMR1_STEP5_HSMOD  	        (uint16_t)(0x0848)
#define CCMR1_STEP6_HSMOD  	        (uint16_t)(0x4808)
#define CCMR2_STEP1_HSMOD         	(uint16_t)(0x6808)
#define CCMR2_STEP2_HSMOD        	(uint16_t)(0x6848)
#define CCMR2_STEP3_HSMOD  	        (uint16_t)(0x6848)
#define CCMR2_STEP4_HSMOD  	        (uint16_t)(0x6808)
#define CCMR2_STEP5_HSMOD  	        (uint16_t)(0x6868)
#define CCMR2_STEP6_HSMOD  	        (uint16_t)(0x6868)

#define CCMR1_STEP1_LSMOD        	(uint16_t)(0x7858)
#define CCMR1_STEP2_LSMOD        	(uint16_t)(0x0858)
#define CCMR1_STEP3_LSMOD        	(uint16_t)(0x5808)
#define CCMR1_STEP4_LSMOD        	(uint16_t)(0x5878)
#define CCMR1_STEP5_LSMOD        	(uint16_t)(0x0878)
#define CCMR1_STEP6_LSMOD        	(uint16_t)(0x7808)
#define CCMR2_STEP1_LSMOD        	(uint16_t)(0x6808)
#define CCMR2_STEP2_LSMOD        	(uint16_t)(0x6878)
#define CCMR2_STEP3_LSMOD        	(uint16_t)(0x6878)
#define CCMR2_STEP4_LSMOD        	(uint16_t)(0x6808)
#define CCMR2_STEP5_LSMOD        	(uint16_t)(0x6858)
#define CCMR2_STEP6_LSMOD        	(uint16_t)(0x6858)

/**
  * @brief  Current sensor parameters Motor 1 - single shunt phase shift
  */
const PWMC_Params_t PWMC_ParamsM1 =
{
/* PWM generation parameters --------------------------------------------------*/
  .TIMx              = TIM1,
};

/**
  * @brief  PWM timer registers Motor 1
  */
PWMC_TimerCfg_t SixPwm_TimerCfgM1 =
{
  .CCER_cfg = {
                CCER_STEP14,
                CCER_STEP25,
                CCER_STEP36,
                CCER_STEP14,
                CCER_STEP25,
                CCER_STEP36,
              },
  .CCER_Align_cfg = CCER_MIDSTEP,
  .CCMR1_Standard_cfg = {
                          CCMR1_STEP1_HSMOD,
                          CCMR1_STEP2_HSMOD,
                          CCMR1_STEP3_HSMOD,
                          CCMR1_STEP4_HSMOD,
                          CCMR1_STEP5_HSMOD,
                          CCMR1_STEP6_HSMOD,
                        },
  .CCMR2_Standard_cfg = {
                          CCMR2_STEP1_HSMOD,
                          CCMR2_STEP2_HSMOD,
                          CCMR2_STEP3_HSMOD,
                          CCMR2_STEP4_HSMOD,
                          CCMR2_STEP5_HSMOD,
                          CCMR2_STEP6_HSMOD,
                        },
  .CCMR1_CW_Align_cfg = {
                          CCMR1_CW_STEP2_MIDALIGN,
                          CCMR1_CW_STEP3_MIDALIGN,
                          CCMR1_CW_STEP4_MIDALIGN,
                          CCMR1_CW_STEP5_MIDALIGN,
                          CCMR1_CW_STEP6_MIDALIGN,
                          CCMR1_CW_STEP1_MIDALIGN,
                        },
  .CCMR2_CW_Align_cfg = {
                          CCMR2_CW_STEP2_MIDALIGN,
                          CCMR2_CW_STEP3_MIDALIGN,
                          CCMR2_CW_STEP4_MIDALIGN,
                          CCMR2_CW_STEP5_MIDALIGN,
                          CCMR2_CW_STEP6_MIDALIGN,
                          CCMR2_CW_STEP1_MIDALIGN,
                        },
  .CCMR1_CCW_Align_cfg = {
                          CCMR1_CCW_STEP6_MIDALIGN,
                          CCMR1_CCW_STEP1_MIDALIGN,
                          CCMR1_CCW_STEP2_MIDALIGN,
                          CCMR1_CCW_STEP3_MIDALIGN,
                          CCMR1_CCW_STEP4_MIDALIGN,
                          CCMR1_CCW_STEP5_MIDALIGN,
                        },
  .CCMR2_CCW_Align_cfg = {
                          CCMR2_CCW_STEP6_MIDALIGN,
                          CCMR2_CCW_STEP1_MIDALIGN,
                          CCMR2_CCW_STEP2_MIDALIGN,
                          CCMR2_CCW_STEP3_MIDALIGN,
                          CCMR2_CCW_STEP4_MIDALIGN,
                          CCMR2_CCW_STEP5_MIDALIGN,
                        },
  .CCMR1_LSMod_cfg = {
                          CCMR1_STEP1_LSMOD,
                          CCMR1_STEP2_LSMOD,
                          CCMR1_STEP3_LSMOD,
                          CCMR1_STEP4_LSMOD,
                          CCMR1_STEP5_LSMOD,
                          CCMR1_STEP6_LSMOD,
                         },
  .CCMR2_LSMod_cfg = {
                          CCMR2_STEP1_LSMOD,
                          CCMR2_STEP2_LSMOD,
                          CCMR2_STEP3_LSMOD,
                          CCMR2_STEP4_LSMOD,
                          CCMR2_STEP5_LSMOD,
                          CCMR2_STEP6_LSMOD,
                         },
  .CCER_QuasiSynch_cfg = {
                          CCER_STEP1_QUASISYNC,
                          CCER_STEP2_QUASISYNC,
                          CCER_STEP3_QUASISYNC,
                          CCER_STEP4_QUASISYNC,
                          CCER_STEP5_QUASISYNC,
                          CCER_STEP6_QUASISYNC,
                        },
};

/**
  * @brief  Current sensor parameters Motor 1 - single shunt phase shift
  */
const Bemf_ADC_Params_t Bemf_ADC_ParamsM1 =
{
  .LfTim                  = TIM2,
  .LfTimerChannel         = LL_TIM_CHANNEL_CH1, /*!< Channel of the LF timer used for speed measurement */
  .gpio_divider_available = true,               /*!< Availability of the GPIO port enabling the bemf resistor divider */
  .bemf_divider_port      = M1_BEMF_DIVIDER_GPIO_Port, /*!< GPIO port of OnSensing divider enabler */
  .bemf_divider_pin       = M1_BEMF_DIVIDER_Pin,
  /*!< Pointer to the ADC */
  .pAdc                   = {ADC2, ADC2, ADC1, ADC2, ADC2, ADC1},
  .AdcChannel             = {MC_ADC_CHANNEL_11, MC_ADC_CHANNEL_5, MC_ADC_CHANNEL_9, MC_ADC_CHANNEL_11, MC_ADC_CHANNEL_5, MC_ADC_CHANNEL_9},
};

ScaleParams_t scaleParams_M1 =
{
 .voltage = (1000 * PWM_PERIOD_CYCLES / (NOMINAL_BUS_VOLTAGE_V * NOMINAL_BUS_VOLTAGE_V)),
 .frequency = ((PWM_PERIOD_CYCLES * TIM_CLOCK_DIVIDER ) / (LF_TIMER_PSC + 1)),
};

/* USER CODE BEGIN Additional parameters */

/* USER CODE END Additional parameters */

/******************* (C) COPYRIGHT 2024 STMicroelectronics *****END OF FILE****/

