#ifndef PEACHOS_PEACHOS_H
#define PEACHOS_PEACHOS_H
#include <stdbool.h>
#include <stddef.h>

struct command_argument
{
    char argument[512];
    struct command_argument* next;
};

struct command_argument* peachos_parse_command(const char* command, int max);

void print(const char* message);
int peachos_getkey();
int peachos_getkeyblock();
void peachos_terminal_readline(char* out, int max, bool output_while_typing);
void peachos_putchar(char c);
void* peachos_malloc(size_t size);
void peachos_free(void* ptr);
void* peachos_process_load_start(const char* filename);

#endif //PEACHOS_PEACHOS_H
