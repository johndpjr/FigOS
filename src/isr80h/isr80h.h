#ifndef PEACHOS_ISR80H_H
#define PEACHOS_ISR80H_H

enum SystemCommands
{
    SYSTEM_COMMAND0_SUM,
    SYSTEM_COMMAND1_PRINT,
};

void isr80h_register_commands();

#endif //PEACHOS_ISR80H_H
