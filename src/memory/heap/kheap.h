#ifndef PEACHOS_KHEAP_H
#define PEACHOS_KHEAP_H
#include <stddef.h>
#include <stdint.h>

#include "config.h"
#include "heap.h"
#include "memory/memory.h"

void kheap_init();
void* kmalloc(size_t size);
void* kzalloc(size_t size);
void kfree(void* ptr);

#endif //PEACHOS_KHEAP_H
