#ifndef PEACHOS_IDT_H
#define PEACHOS_IDT_H
#include <stdint.h>

#include "config.h"
#include "kernel.h"
#include "memory/memory.h"
#include "io/io.h"

struct idt_desc {
    uint16_t offset_1; // Offset bits 0 - 15
    uint16_t selector; // Selector in GDT
    uint8_t zero;      // Does nothing - unused set to zero
    uint8_t type_attr; // Descriptor type and attributes
    uint16_t offset_2; // Offset bits 16-31
} __attribute__((packed));

struct idtr_desc {
    uint16_t limit; // Size of descriptor table - 1
    uint32_t base;  // Base address of interrupt descriptor table
} __attribute__((packed));

void idt_init();

#endif //PEACHOS_IDT_H
