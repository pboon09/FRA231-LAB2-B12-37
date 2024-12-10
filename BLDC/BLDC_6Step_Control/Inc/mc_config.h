
/**
  ******************************************************************************
  * @file    mc_config.h
  * @author  Motor Control SDK Team, ST Microelectronics
  * @brief   Motor Control Subsystem components configuration and handler
  *          structures declarations.
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

#ifndef MC_CONFIG_H
#define MC_CONFIG_H

#include "speed_ctrl.h"
#include "revup_ctrl_sixstep.h"
#include "mc_config_common.h"
#include "pwmc_sixstep.h"
#include "g4xx_bemf_ADC_fdbk.h"

extern PWMC_Handle_t PWM_Handle_M1;
extern Bemf_ADC_Handle_t Bemf_ADC_M1;
extern SixStepVars_t SixStepVars[NBR_OF_MOTORS];
extern RevUpCtrl_Handle_t RevUpControlM1;
extern MCI_Handle_t* pMCI[NBR_OF_MOTORS];
extern SpeednTorqCtrl_Handle_t *pSTC[NBR_OF_MOTORS];
extern MCI_Handle_t Mci[NBR_OF_MOTORS];
extern PID_Handle_t PIDSpeedHandle_M1;

/* USER CODE BEGIN Additional extern */

/* USER CODE END Additional extern */

#endif /* MC_CONFIG_H */
/******************* (C) COPYRIGHT 2024 STMicroelectronics *****END OF FILE****/
