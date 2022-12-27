#include "peachos.h"
#include "stdlib.h"
#include "stdio.h"
#include "string.h"

int main(int argc, char** argv)
{
    char* ptr = malloc(20);
    strcpy(ptr, "Hello World");
    print(ptr);
    free(ptr);

    ptr[0] = 'B';
    print("ABC\n");

    while (1) {}
    return 0;
}
