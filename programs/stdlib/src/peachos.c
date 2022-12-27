#include "peachos.h"

int peachos_getkeyblock()
{
    int val;
    do {
        val = peachos_getkey();
    } while (val == 0);

    return val;
}

void peachos_terminal_readline(char* out, int max, bool output_while_typing)
{
    int i = 0;
    for ( ; i < max-1; ++i) {
        char key = peachos_getkeyblock();
        // Carriage return means we have read the line (Enter key)
        if (key == 13)
            break;

        if (output_while_typing)
            peachos_putchar(key);

        // Backspace
        if (key == 0x08 && i >= 1) {
            out[i-1] = 0x00;
            i -= 2;  // -2 b/c going to continue
            continue;
        }

        out[i] = key;
    }

    // Add the null terminator
    out[i] = 0x00;
}
