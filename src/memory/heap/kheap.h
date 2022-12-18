#ifndef PEACHOS_KHEAP_H
#define PEACHOS_KHEAP_H
#include <stdint.h>
#include <stddef.h>

#include "heap.h"
#include "config.h"
#include "memory/memory.h"

void kheap_init();
void* kmalloc(size_t size);
void* kzalloc(size_t size);
void kfree(void* ptr);

#endif //PEACHOS_KHEAP_H
