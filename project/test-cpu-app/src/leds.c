#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "led_axi.h"
#include "xparameters.h"
#include <stdint.h>
#include "xil_io.h"
#include "test.h"


int main(void) {
	init_platform();

	//volatile u32 *const leds = (volatile u32*)XPAR_LED_AXI_0_LED_IO_AXI_BASEADDR;
	*leds = 0xFF;

	while(1);

	cleanup_platform();
	return 0;
}
