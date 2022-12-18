#ifndef PEACHOS_STRING_H
#define PEACHOS_STRING_H
#include <stdbool.h>

int strlen(const char* ptr);
int strnlen(const char* ptr, int max);
bool isdigit(char c);
int tonumericdigit(char c);

#endif //PEACHOS_STRING_H
