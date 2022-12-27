#include "shell.h"

#include "peachos.h"
#include "stdlib.h"
#include "stdio.h"

int main(int argc, char** argv)
{
    print("PeachOS v1.0.0\n");
    while (1) {
        print("> ");
        char buf[1024];
        peachos_terminal_readline(buf, sizeof(buf), true);
        peachos_process_load_start(buf);
        print("\n");
    }
    return 0;
}
