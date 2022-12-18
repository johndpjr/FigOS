#ifndef PEACHOS_DISK_H
#define PEACHOS_DISK_H

#include "config.h"
#include "io/io.h"
#include "memory/memory.h"
#include "status.h"

typedef unsigned int PEACHOS_DISK_TYPE;

// Represents a real physical hard disk
#define PEACHOS_DISK_TYPE_REAL 0

struct disk
{
    PEACHOS_DISK_TYPE type;
    int sector_size;
};

void disk_search_and_init();
struct disk* disk_get(int index);
int disk_read_block(struct disk* idisk, unsigned int lba, int total, void* buf);

#endif //PEACHOS_DISK_H
