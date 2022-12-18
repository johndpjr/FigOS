#ifndef PEACHOS_KERNEL_H
#define PEACHOS_KERNEL_H
#include <stddef.h>
#include <stdint.h>

#define PEACHOS_MAX_PATH 108

#define VGA_WIDTH 80
#define VGA_HEIGHT 20

void kernel_main();
void print(const char* str);

#endif //PEACHOS_KERNEL_H
