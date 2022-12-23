#include "io.h"

#include "kernel.h"
#include "task/task.h"

void* isr80h_command1_print(struct interrupt_frame* frame)
{
    void* user_space_msg_buffer = task_get_stack_item(task_current(), 0);
    char buf[1024];
    copy_string_from_task(task_current(), user_space_msg_buffer, buf, sizeof(buf));

    // Print out buffer
    print(buf);
    return 0;
}
