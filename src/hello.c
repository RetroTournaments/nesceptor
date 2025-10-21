#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "pico/binary_info.h"

int main() {
    bi_decl(bi_program_description("test hello."));
    stdio_init_all();
    for (;;) {
        sleep_ms(500);
        puts("Hello\n");
    }

    return 0;
}
