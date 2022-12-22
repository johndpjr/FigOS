[BITS 32]

section .asm

global restore_general_purpose_registers
global task_return
global user_registers

; void task_return(struct registers* regs);
task_return:
    mov ebp, esp
    ; Push the Data Segment
    ; Push the Stack Address
    ; Push the Flags
    ; Push the Code Segment
    ; Push ip

    ; Access the structure passed to us
    mov ebx, [ebp+4]
    ; Push the Data/Stack selector
    push dword [ebx+44]
    ; Push the stack pointer
    push dword [ebx+40]

    ; Push the Flags
    pushf
    pop eax
    or eax, 0x200
    push eax

    ; Push the Code Segment
    push dword [ebx+32]

    ; Push the ip to execute
    push dword [ebx+28]

    ; Setup Segment Registers
    mov ax, [ebx+44]
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    push dword [ebx+4]
    call restore_general_purpose_registers
    add esp, 4

    ; Leave Kernel land and execute in User land
    iretd

; void restore_general_purpose_registers(struct registers* regs);
restore_general_purpose_registers:
    push ebp
    mov ebp, esp
    mov ebx, [ebp+8]
    mov edi, [ebx]
    mov esi, [ebx+4]
    mov ebp, [ebx+8]
    mov edx, [ebx+16]
    mov ecx, [ebx+20]
    mov eax, [ebx+24]
    mov ebx, [ebx+12]
    pop ebp
    ret

; void user_registers();
user_registers:
    mov ax, 0x23
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ret
