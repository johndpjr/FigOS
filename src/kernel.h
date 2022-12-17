#ifndef PEACHOS_KERNEL_H
#define PEACHOS_KERNEL_H
#include <stdint.h>
#include <stddef.h>

#include "idt/idt.h"
#include "io/io.h"

#define VGA_WIDTH 80
#define VGA_HEIGHT 20

void kernel_main();
void print(const char* str);

#endif //PEACHOS_KERNEL_H
