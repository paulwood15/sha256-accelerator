#include "sha2.h"
#include <string.h>
#include "../platform.h"
#include "xil_printf.h"

// command line functionality of sha256 library


/*******************************************************************************************************
 * 
 * 
 *                                      COMMANDLINE FUNCTIONALITY
 * 
 * 
********************************************************************************************************/
int main() {
	init_platform();

    char str[4] = "abc";
    byte_t hash[8];

//    print("Hi\n\r");
//    xil_printf("Hi again\n\r");
//    xil_printf("string: %s\n\r", str);


    bsha256(hash, str, strlen(str));
	output_hash(hash);

	cleanup_platform();
	return 0;
}