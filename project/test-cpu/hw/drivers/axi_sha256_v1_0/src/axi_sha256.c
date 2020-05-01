

/***************************** Include Files *******************************/
#include "axi_sha256.h"



/************************** Function Definitions ***************************/
s32 sha256(sha256_t *sha256_obj) {
    // get copy of msg_ptr to do manipulation on and get pointer of the last word in the message 
    // to know when to stop inputting into the message block buffer 
    uint32_t *msg_ptr = sha256_obj->msg_ptr;
    uint32_t *last_word_ptr = msg_ptr + sha256_obj->msg_size - 1;
    bool is_final_block = false;

    // disable while inputting the message size
    sha256_disable();

    SHA256_MSG_SIZE_L = sha256_obj->msg_size;
    SHA256_MSG_SIZE_H = sha256_obj->msg_size >> 32;

    // enter data into the message block buffer in little-endian format
    sha256_msg_little_endian_mode();

    // enable to and reset module
    sha256_enable();
    sha256_reset();

    // start hash loop
    while (!sha256_is_hash_done()) {
        // if is_final_block is true, then that means the previous intermediate hash was the last
        // and the loop should have been exited
        if (is_final_block)
            return XST_FAILURE;

        // load a word into the message block buffer until all words have been filled
        for (uint32_t i = 0; i < 16; i++) {
            if (msg_ptr <= last_word_ptr) {
                SHA256_MSG0[i] = *msg_ptr;
                msg_ptr++;
            }
            else
                is_final_block = true;
        }

        // now that the message block buffer has been filled, start the intermediate hash
        sha256_update();

        // wait for the intermediate hash to be done, then check of the overall hash is done
        while (sha256_is_block_done());
    }

    return XST_SUCCESS;
}