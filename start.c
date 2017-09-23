#include <stdint.h>

/*----------------------------------------------------------------------------
  Linker Generated Symbols
 *----------------------------------------------------------------------------*/
extern uintptr_t __itcm_start__;
extern uintptr_t __itcm_top__;
extern uintptr_t __itcm_end__;
extern uintptr_t __dtcm_start__;
extern uintptr_t __dtcm_top__;
extern uintptr_t __dtcm_end__;
extern uintptr_t __data_start__;
extern uintptr_t __data_top__;
extern uintptr_t __data_end__;
extern uintptr_t __bss_top__;
extern uintptr_t __bss_end__;
extern uintptr_t __stack_top__;

/*----------------------------------------------------------------------------
  Exception / Interrupt Handler Function Prototype
 *----------------------------------------------------------------------------*/
typedef void (*pFunc)(void);

/*----------------------------------------------------------------------------
  Exception / Interrupt Vector table
 *----------------------------------------------------------------------------*/
extern const pFunc Interrupt_Vectors[];

/*----------------------------------------------------------------------------
  External References
 *----------------------------------------------------------------------------*/
extern void main(void); /* Program Entry Point */

/*----------------------------------------------------------------------------
  Internal References
 *----------------------------------------------------------------------------*/
void Default_Handler(void); /* Default Empty Handler */
void Reset_Handler(void);   /* Reset Handler */

/*----------------------------------------------------------------------------
  Exception / Interrupt Handler
 *----------------------------------------------------------------------------*/
void NMI_Handler(void) __attribute__((weak, alias("Default_Handler")));
void HardFault_Handler(void) __attribute__((weak, alias("Default_Handler")));
void MemManage_Handler(void) __attribute__((weak, alias("Default_Handler")));
void BusFault_Handler(void) __attribute__((weak, alias("Default_Handler")));
void UsageFault_Handler(void) __attribute__((weak, alias("Default_Handler")));
void SVC_Handler(void) __attribute__((weak, alias("Default_Handler")));
void DebugMon_Handler(void) __attribute__((weak, alias("Default_Handler")));
void PendSV_Handler(void) __attribute__((weak, alias("Default_Handler")));
void SysTick_Handler(void) __attribute__((weak, alias("Default_Handler")));

/*----------------------------------------------------------------------------
  Exception / Interrupt Vector table
 *----------------------------------------------------------------------------*/
const pFunc Interrupt_Vectors[] __attribute__((section(".vectors"))) = {
    /* Cortex-M7 Processor Exceptions Handler */
    (pFunc)((uintptr_t)&__stack_top__), /* Initial Stack Pointer */
    Reset_Handler,                      /* Reset Handler         */
    NMI_Handler,                        /* NMI Handler           */
    HardFault_Handler,                  /* Hard Fault Handler    */
    MemManage_Handler,                  /* MPU Fault Handler     */
    BusFault_Handler,                   /* Bus Fault Handler     */
    UsageFault_Handler,                 /* Usage Fault Handler   */
    0,                                  /* Reserved              */
    0,                                  /* Reserved              */
    0,                                  /* Reserved              */
    0,                                  /* Reserved              */
    SVC_Handler,                        /* SVCall Handler        */
    DebugMon_Handler,                   /* Debug Monitor Handler */
    0,                                  /* Reserved              */
    PendSV_Handler,                     /* PendSV Handler        */
    SysTick_Handler,                    /* SysTick Handler       */
};

/*----------------------------------------------------------------------------
  Reset Handler called on controller reset
 *----------------------------------------------------------------------------*/
_Noreturn void Reset_Handler(void) {
  uintptr_t *pSrc, *pDest;

  /* Get LMA Section */
  pSrc = &__itcm_start__;

  /* Copy LMA to VMA Section */
  for (pDest = &__itcm_top__; pDest < &__itcm_end__;) {
    *pDest++ = *pSrc++;
  }

  /* Get LMA Section */
  pSrc = &__data_start__;

  /* Copy LMA to VMA Section */
  for (pDest = &__data_top__; pDest < &__data_end__;) {
    *pDest++ = *pSrc++;
  }

  /* Clear BSS Section */
  for (pDest = &__dtcm_top__; pDest < &__dtcm_end__;) {
    *pDest++ = 0UL;
  }

  /* Clear BSS Section */
  for (pDest = &__bss_top__; pDest < &__bss_end__;) {
    *pDest++ = 0UL;
  }

  /* Program Entry Point */
  main();

  /* Fallback */
  while (1) {
  }
}

/*----------------------------------------------------------------------------
  Default Handler for Exceptions / Interrupts
 *----------------------------------------------------------------------------*/
_Noreturn void Default_Handler(void) {
  while (1) {
  };
}
