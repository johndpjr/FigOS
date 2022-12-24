#ifndef PEACHOS_PROCESS_H
#define PEACHOS_PROCESS_H
#include <stdint.h>

#include "config.h"
#include "task.h"

struct process
{
    // The process id
    uint16_t id;

    char filename[PEACHOS_MAX_PATH];

    // The main process task
    struct task* task;

    // The memory (malloc) allocations of the process
    // This ensures all memory is freed after the process exits
    void* allocations[PEACHOS_MAX_PROGRAM_ALLOCATIONS];

    // The physical pointer to the process memory
    void* ptr;

    // The physical pointer to the stack memory
    void* stack;

    // The size of the data pointed to by "ptr"
    uint32_t size;

    struct keyboard_buffer
    {
        char buffer[PEACHOS_KEYBOARD_BUFFER_SIZE];
        int tail;
        int head;
    } keyboard;
};

struct process* process_current();
struct process* process_get(int process_id);

int process_load(const char* filename, struct process** process);
int process_load_for_slot(const char* filename, struct process** process, int process_slot);

#endif //PEACHOS_PROCESS_H
