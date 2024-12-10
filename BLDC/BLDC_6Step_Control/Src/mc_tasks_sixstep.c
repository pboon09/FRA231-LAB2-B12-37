
/**
  ******************************************************************************
  * @file    mc_tasks_sixstep.c
  * @author  Motor Control SDK Team, ST Microelectronics
  * @brief   This file implements tasks definition
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
#include "main.h"
//cstat +MISRAC2012-Rule-21.1
#include "mc_type.h"
#include "mc_math.h"
#include "motorcontrol.h"
#include "regular_conversion_manager.h"
#include "mc_interface.h"
#include "digital_output.h"
#include "mc_tasks.h"
#include "parameters_conversion.h"
#include "mcp_config.h"
#include "mc_app_hooks.h"

/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* USER CODE BEGIN Private define */
/* Private define ------------------------------------------------------------*/

/* USER CODE END Private define */

/* Private variables----------------------------------------------------------*/
static volatile uint16_t hBootCapDelayCounterM1 = ((uint16_t)0);
static volatile uint16_t hStopPermanencyCounterM1 = ((uint16_t)0);

#define M1_CHARGE_BOOT_CAP_TICKS          (((uint16_t)SYS_TICK_FREQUENCY * (uint16_t)10) / 1000U)
#define M1_CHARGE_BOOT_CAP_DUTY_CYCLES ((uint32_t)0.000\
                                      * ((uint32_t)PWM_PERIOD_CYCLES / 2U))
#define M2_CHARGE_BOOT_CAP_TICKS         (((uint16_t)SYS_TICK_FREQUENCY * (uint16_t)10) / 1000U)
#define M2_CHARGE_BOOT_CAP_DUTY_CYCLES ((uint32_t)0\
                                      * ((uint32_t)PWM_PERIOD_CYCLES2 / 2U))
#define S16_90_PHASE_SHIFT             (int16_t)(65536/4)

/* USER CODE BEGIN Private Variables */

/* USER CODE END Private Variables */

/* Private functions ---------------------------------------------------------*/
void TSK_MediumFrequencyTaskM1(void);
void TSK_MF_StopProcessing(uint8_t motor);
MCI_Handle_t *GetMCI(uint8_t bMotor);
void SixStep_InitAdditionalMethods(uint8_t bMotor);
void SixStep_CalcSpeedRef(uint8_t bMotor);

/* USER CODE BEGIN Private Functions */

/* USER CODE END Private Functions */
/**
  * @brief  It initializes the whole MC core according to user defined
  *         parameters.
  * @param  pMCIList pointer to the vector of MCInterface objects that will be
  *         created and initialized. The vector must have length equal to the
  *         number of motor drives.
  */
__weak void SIX_STEP_Init( void )
{
  /* USER CODE BEGIN MCboot 0 */

  /* USER CODE END MCboot 0 */

    /**********************************************************/
    /*    PWM and current sensing component initialization    */
    /**********************************************************/
    pwmcHandle[M1] = &PWM_Handle_M1;
    PWMC_Init(&PWM_Handle_M1);

    /* USER CODE BEGIN MCboot 1 */

    /* USER CODE END MCboot 1 */

    /******************************************************/
    /*   PID component initialization: speed regulation   */
    /******************************************************/
    PID_HandleInit(&PIDSpeedHandle_M1);

    /******************************************************/
    /*   Main speed sensor component initialization       */
    /******************************************************/
    BADC_Init (&Bemf_ADC_M1);

    /******************************************************/
    /*   Speed & torque component initialization          */
    /******************************************************/
    STC_Init(pSTC[M1],&PIDSpeedHandle_M1, &Bemf_ADC_M1._Super);

    /**************************************/
    /*   Rev-up component initialization  */
    /**************************************/
    RUC_Init(&RevUpControlM1,pSTC[M1],&VirtualSpeedSensorM1);
    SIX_STEP_Clear(M1);

    MCI_ExecSpeedRamp(&Mci[M1],
    STC_GetMecSpeedRefUnitDefault(pSTC[M1]),0); /* First command to STC */

    /* USER CODE BEGIN MCboot 2 */

    /* USER CODE END MCboot 2 */
}

/**
 * @brief Performs stop process and update the state machine.This function
 *        shall be called only during medium frequency task.
 */
void TSK_MF_StopProcessing(uint8_t motor)
{
  SIX_STEP_Clear(motor);
  TSK_SetStopPermanencyTimeM1(STOPPERMANENCY_TICKS);
  Mci[motor].State = STOP;
}

/**
  * @brief Executes medium frequency periodic Motor Control tasks
  *
  * This function performs some of the control duties on Motor 1 according to the
  * present state of its state machine. In particular, duties requiring a periodic
  * execution at a medium frequency rate (such as the speed controller for instance)
  * are executed here.
  */
__weak void TSK_MediumFrequencyTaskM1(void)
{

  /* USER CODE BEGIN MediumFrequencyTask M1 0 */

  /* USER CODE END MediumFrequencyTask M1 0 */

  int16_t wAux = 0;
  bool IsSpeedReliable = BADC_CalcAvrgMecSpeedUnit(&Bemf_ADC_M1, &wAux);

  if (MCI_GetCurrentFaults(&Mci[M1]) == MC_NO_FAULTS)
  {
    if (MCI_GetOccurredFaults(&Mci[M1]) == MC_NO_FAULTS)
    {
      switch (Mci[M1].State)
      {
        case IDLE:
        {
          if ((MCI_START == Mci[M1].DirectCommand) || (MCI_MEASURE_OFFSETS == Mci[M1].DirectCommand))
          {
              RUC_Clear(&RevUpControlM1, MCI_GetImposedMotorDirection(&Mci[M1]));
              RUC_UpdatePulse(&RevUpControlM1, &BusVoltageSensor_M1._Super);

              PWMC_TurnOnLowSides(pwmcHandle[M1],M1_CHARGE_BOOT_CAP_DUTY_CYCLES);
              TSK_SetChargeBootCapDelayM1(M1_CHARGE_BOOT_CAP_TICKS);
              Mci[M1].State = CHARGE_BOOT_CAP;
          }
          else
          {
            /* Nothing to be done, FW stays in IDLE state */
          }
          break;
        }

        case CHARGE_BOOT_CAP:
        {
          if (MCI_STOP == Mci[M1].DirectCommand)
          {
            TSK_MF_StopProcessing(M1);
          }
          else
          {
            if (TSK_ChargeBootCapDelayHasElapsedM1())
            {
              PWMC_SwitchOffPWM(pwmcHandle[M1]);
              SixStepVars[M1].bDriveInput = EXTERNAL;
              STC_SetSpeedSensor( pSTC[M1], &VirtualSpeedSensorM1._Super );
              BADC_Clear(&Bemf_ADC_M1);
              SIX_STEP_Clear( M1 );
              BADC_SetDirection(&Bemf_ADC_M1, MCI_GetImposedMotorDirection( &Mci[M1]));
              BADC_SetSamplingPoint(&Bemf_ADC_M1, &PWM_Handle_M1, &BusVoltageSensor_M1._Super);

              Mci[M1].State = START;
              BADC_Start(&Bemf_ADC_M1, PWM_Handle_M1.Step, PWM_Handle_M1.LSModArray);
              PWMC_SwitchOnPWM(pwmcHandle[M1]);

            }
            else
            {
              /* Nothing to be done, FW waits for bootstrap capacitor to charge */
            }
          }
          break;
        }

        case START:
        {
          if (MCI_STOP == Mci[M1].DirectCommand)
          {
            TSK_MF_StopProcessing(M1);
          }
          else
          {
            bool ObserverConverged;
              /* Mechanical speed as imposed by the Virtual Speed Sensor during the Rev Up phase. */
              int16_t hForcedMecSpeedUnit;
              /* Execute the Rev Up procedure */
              if(! RUC_Exec(&RevUpControlM1))
              {
                /* The time allowed for the startup sequence has expired */
                MCI_FaultProcessing(&Mci[M1], MC_START_UP, 0);
              }
              else
              {
                /* Execute the torque open loop current start-up ramp:
                 * Compute the Iq reference current as configured in the Rev Up sequence */
                (void) BADC_CalcRevUpDemagTime (&Bemf_ADC_M1);
                SixStepVars[M1].DutyCycleRef = STC_CalcSpeedReference( pSTC[M1] );
              }

              (void)VSS_CalcAvrgMecSpeedUnit(&VirtualSpeedSensorM1, &hForcedMecSpeedUnit);

              /* Check that startup stage where the observer has to be used has been reached */
              if (true == RUC_FirstAccelerationStageReached(&RevUpControlM1))
              {
                ObserverConverged = BADC_IsObserverConverged( &Bemf_ADC_M1);
                (void)VSS_SetStartTransition(&VirtualSpeedSensorM1, ObserverConverged);
              }
              else
              {
                ObserverConverged = false;
              }
            if (ObserverConverged)
            {
              Mci[M1].State = SWITCH_OVER;
            }
          }
          break;
        }

        case SWITCH_OVER:
        {
          if (MCI_STOP == Mci[M1].DirectCommand)
          {
            TSK_MF_StopProcessing(M1);
          }
          else
          {
              bool LoopClosed;
              int16_t hForcedMecSpeedUnit;

              if (! RUC_Exec(&RevUpControlM1))
              {
                /* The time allowed for the startup sequence has expired */
                MCI_FaultProcessing(&Mci[M1], MC_START_UP, 0);
              }
              else
              {
                /* Compute the virtual speed and positions of the rotor.
                   The function returns true if the virtual speed is in the reliability range */
                LoopClosed = VSS_CalcAvrgMecSpeedUnit(&VirtualSpeedSensorM1, &hForcedMecSpeedUnit);

                /* Check if the transition ramp has completed. */
                bool tempBool;
                tempBool = VSS_TransitionEnded(&VirtualSpeedSensorM1);
                LoopClosed = LoopClosed || tempBool;

                /* If any of the above conditions is true, the loop is considered closed.
                   The state machine transitions to the RUN state */
                if (true ==  LoopClosed)
                {
#if PID_SPEED_INTEGRAL_INIT_DIV == 0
                    PID_SetIntegralTerm(&PIDSpeedHandle_M1, 0);
#else
                    PID_SetIntegralTerm(&PIDSpeedHandle_M1,
                                        (((int32_t)SixStepVars[M1].DutyCycleRef * (int16_t)PID_GetKIDivisor(&PIDSpeedHandle_M1))
                                      / PID_SPEED_INTEGRAL_INIT_DIV));
#endif
                    /* USER CODE BEGIN MediumFrequencyTask M1 1 */

                    /* USER CODE END MediumFrequencyTask M1 1 */

                    STC_SetSpeedSensor(pSTC[M1], &Bemf_ADC_M1._Super); /* Observer has converged */
                    SixStep_InitAdditionalMethods(M1);
                    SixStep_CalcSpeedRef(M1);
                    BADC_SetLoopClosed(&Bemf_ADC_M1);
                    PWMC_DisableHighFreqTask( &PWM_Handle_M1 );
                    STC_ForceSpeedReferenceToCurrentSpeed(pSTC[M1]); /* Init the reference speed to current speed */
                    MCI_ExecBufferedCommands(&Mci[M1]); /* Exec the speed ramp after changing of the speed sensor */
                    Mci[M1].State = RUN;
                }
                else
                {
                  /* Nothint to do, Loop not closed */
                }
              }
          }
          break;
        }

        case RUN:
        {
          if (MCI_STOP == Mci[M1].DirectCommand)
          {
            TSK_MF_StopProcessing(M1);
          }
          else
          {
            /* USER CODE BEGIN MediumFrequencyTask M1 2 */

            /* USER CODE END MediumFrequencyTask M1 2 */

            MCI_ExecBufferedCommands(&Mci[M1]);

              SixStep_CalcSpeedRef(M1);
            BADC_SetSamplingPoint(&Bemf_ADC_M1, &PWM_Handle_M1, &BusVoltageSensor_M1._Super);

            (void) BADC_CalcRunDemagTime (&Bemf_ADC_M1);
            if(!IsSpeedReliable)
            {
              MCI_FaultProcessing(&Mci[M1], MC_SPEED_FDBK, 0);
            }
            else
            {
              /* Nothing to do */
            }
          }
          break;
        }

        case STOP:
        {
          if (TSK_StopPermanencyTimeHasElapsedM1())
          {
            STC_SetSpeedSensor(pSTC[M1], &VirtualSpeedSensorM1._Super);    /* Sensor-less */
            VSS_Clear(&VirtualSpeedSensorM1); /* Reset measured speed in IDLE */
            BADC_Clear(&Bemf_ADC_M1);

            /* USER CODE BEGIN MediumFrequencyTask M1 5 */

            /* USER CODE END MediumFrequencyTask M1 5 */

            Mci[M1].DirectCommand = MCI_NO_COMMAND;
            Mci[M1].State = IDLE;
          }
          else
          {
            /* Nothing to do, FW waits for to stop */
          }
          break;
        }

        case FAULT_OVER:
        {
          if (MCI_ACK_FAULTS == Mci[M1].DirectCommand)
          {
            Mci[M1].DirectCommand = MCI_NO_COMMAND;
            Mci[M1].State = IDLE;
          }
          else
          {
            /* Nothing to do, FW stays in FAULT_OVER state until acknowledgement */
          }
          break;
        }

        case FAULT_NOW:
        {
          Mci[M1].State = FAULT_OVER;
          break;
        }

        default:
          break;
       }
    }
    else
    {
      Mci[M1].State = FAULT_OVER;
    }
  }
  else
  {
    Mci[M1].State = FAULT_NOW;
  }
  /* USER CODE BEGIN MediumFrequencyTask M1 6 */

  /* USER CODE END MediumFrequencyTask M1 6 */

}

/**
  * @brief  It re-initializes the current and voltage variables. Moreover
  *         it clears qd currents PI controllers, voltage sensor and SpeednTorque
  *         controller. It must be called before each motor restart.
  *         It does not clear speed sensor.
  * @param  bMotor related motor it can be M1 or M2.
  */
__weak void SIX_STEP_Clear(uint8_t bMotor)
{
  /* USER CODE BEGIN SixStep_Clear 0 */

  /* USER CODE END SixStep_Clear 0 */
  SixStepVars[M1].bDriveInput = EXTERNAL;
  STC_Clear(pSTC[bMotor]);
  SixStepVars[bMotor].DutyCycleRef = STC_GetDutyCycleRef(pSTC[bMotor]);
  BADC_Stop( &Bemf_ADC_M1 );
  BADC_SpeedMeasureOff(&Bemf_ADC_M1); /* Stop timer before BADC_Clear to avoid ADC regular conversion issues.*/
  BADC_Clear( &Bemf_ADC_M1 );
  PWMC_SwitchOffPWM(pwmcHandle[bMotor]);

  /* USER CODE BEGIN SixStep_Clear 1 */

  /* USER CODE END SixStep_Clear 1 */
}

/**
  * @brief  Use this method to initialize additional methods (if any) in
  *         START_TO_RUN state.
  * @param  bMotor related motor it can be M1 or M2.
  */
__weak void SixStep_InitAdditionalMethods(uint8_t bMotor)
{
  /* USER CODE BEGIN FOC_InitAdditionalMethods 0 */

  /* USER CODE END FOC_InitAdditionalMethods 0 */
}

/**
  * @brief  It computes the new values of Iqdref (current references on qd
  *         reference frame) based on the required electrical torque information
  *         provided by oTSC object (internally clocked).
  *         If implemented in the derived class it executes flux weakening and/or
  *         MTPA algorithm(s). It must be called with the periodicity specified
  *         in oTSC parameters.
  * @param  bMotor related motor it can be M1 or M2.
  */
__weak void SixStep_CalcSpeedRef(uint8_t bMotor)
{

  /* USER CODE BEGIN FOC_CalcCurrRef 0 */

  /* USER CODE END FOC_CalcCurrRef 0 */
  if(SixStepVars[bMotor].bDriveInput == INTERNAL)
  {
    SixStepVars[bMotor].DutyCycleRef = STC_CalcSpeedReference(pSTC[bMotor]);
  }
  else
  {
    /* Nothing to do */
  }
  /* USER CODE BEGIN FOC_CalcCurrRef 1 */

  /* USER CODE END FOC_CalcCurrRef 1 */
}

#if defined (CCMRAM)
#if defined (__ICCARM__)
#pragma location = ".ccmram"
#elif defined (__CC_ARM) || defined(__GNUC__)
__attribute__((section (".ccmram")))
#endif
#endif

/**
  * @brief  Executes the Motor Control duties that require a high frequency rate and a precise timing.
  *
  *  This is mainly the FOC current control loop. It is executed depending on the state of the Motor Control
  * subsystem (see the state machine(s)).
  *
  * @retval Number of the  motor instance which FOC loop was executed.
  */
__weak uint8_t SIX_STEP_HighFrequencyTask(uint8_t bMotorNbr)
{

 /* USER CODE BEGIN HighFrequencyTask 0 */

  /* USER CODE END HighFrequencyTask 0 */

  uint16_t hSixStepReturn;
  if(RUN != Mci[M1].State) /*  only for sensor-less*/
  {
    if (START == Mci[M1].State)
    {
      if (0U == RUC_IsAlignStageNow(&RevUpControlM1))
      {
        PWMC_SetAlignFlag(&PWM_Handle_M1, 0);
      }
      else
      {
        PWMC_SetAlignFlag(&PWM_Handle_M1, RUC_GetDirection(&RevUpControlM1));
      }
    }
    else
    {
      PWMC_SetAlignFlag(&PWM_Handle_M1, 0);
    }
    int16_t hObsAngle = SPD_GetElAngle(&VirtualSpeedSensorM1._Super);
    (void)VSS_CalcElAngle(&VirtualSpeedSensorM1, &hObsAngle);
  }
  (void)BADC_CalcElAngle (&Bemf_ADC_M1);
  /* USER CODE BEGIN HighFrequencyTask SINGLEDRIVE_1 */

  /* USER CODE END HighFrequencyTask SINGLEDRIVE_1 */
  hSixStepReturn = SixStep_StepCommution();
  /* USER CODE BEGIN HighFrequencyTask SINGLEDRIVE_2 */

  /* USER CODE END HighFrequencyTask SINGLEDRIVE_2 */

  if(MC_DURATION == hSixStepReturn)
  {
    MCI_FaultProcessing(&Mci[bMotorNbr], MC_DURATION, 0);
  }
  else
  {
    /* USER CODE BEGIN HighFrequencyTask SINGLEDRIVE_3 */

    /* USER CODE END HighFrequencyTask SINGLEDRIVE_3 */
  }

  /* USER CODE BEGIN HighFrequencyTask 1 */

  /* USER CODE END HighFrequencyTask 1 */

  return (bMotorNbr);

}

#if defined (CCMRAM)
#if defined (__ICCARM__)
#pragma location = ".ccmram"
#elif defined (__CC_ARM) || defined(__GNUC__)
__attribute__((section (".ccmram")))
#endif
#endif
inline uint16_t SixStep_StepCommution(void)
{
  uint16_t hCodeError = MC_NO_ERROR;
  int16_t hElAngle, hSpeed, hDirection;
  SpeednPosFdbk_Handle_t *speedHandle;
  RCM_ReadOngoingConv();
  RCM_ExecNextConv();
  hDirection = RUC_GetDirection(&RevUpControlM1);
  PWMC_SetPhaseVoltage( pwmcHandle[M1], SixStepVars[M1].DutyCycleRef );
  if  (false == Bemf_ADC_M1.IsLoopClosed)
  {
    speedHandle = STC_GetSpeedSensor(pSTC[M1]);
    if(false == BADC_IsObserverConverged(&Bemf_ADC_M1))
    {
      hElAngle = SPD_GetElAngle(speedHandle);
    }
    else
    {
      hElAngle = SPD_GetElAngle(&Bemf_ADC_M1._Super);
    }
    hSpeed = SPD_GetElSpeedDpp(speedHandle);

    if (hDirection > 0)
    {
      SixStepVars[M1].qElAngle = hElAngle + S16_90_PHASE_SHIFT;
    }
    else
    {
      SixStepVars[M1].qElAngle = hElAngle - S16_90_PHASE_SHIFT;
    }
    PWM_Handle_M1.hElAngle = SixStepVars[M1].qElAngle;
    if (PWMC_ElAngleToStep(&PWM_Handle_M1))
    {
      PWMC_LoadNextStep( &PWM_Handle_M1 );
      BADC_StepChangeEvent(&Bemf_ADC_M1, hSpeed);
    }
  }
  else
  {
    PWMC_ForceNextStep( &PWM_Handle_M1, hDirection );
    PWMC_LoadNextStep( &PWM_Handle_M1 );
  }
  return(hCodeError);
}

/* Puts parameters for onsensing PWM configuration */

/* USER CODE BEGIN mc_task 0 */

/* USER CODE END mc_task 0 */

/******************* (C) COPYRIGHT 2024 STMicroelectronics *****END OF FILE****/
