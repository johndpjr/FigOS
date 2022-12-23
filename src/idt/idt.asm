section .asm

extern int21h_handler
extern no_interrupt_handler
extern isr80h_handler

global idt_load
global int21h
global no_interrupt
global enable_interrupts
global disable_interrupts
global isr80h_wrapper

enable_interrupts:
    sti
    ret

disable_interrupts:
    cli
    ret

idt_load:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8]
    lidt [ebx]
    pop ebp
    ret

int21h:
    ; interrupt does not change state, so push all registers
    pushad
    call int21h_handler
    popad
    iret

no_interrupt:
    pushad
    call no_interrupt_handler
    popad
    iret

isr80h_wrapper:
    ; Interrupt frame start
    ; Already pushed to us by the processor upon entry to this interrupt:
    ; uint32_t ip
    ; uint32_t cs
    ; uint32_t flags
    ; uint32_t sp;
    ; uint32_t ss;
    ; Push general-purpose registers to stack
    pushad
    ; Interrupt frame ends
    
    ; Push stack ptr so that we point to interrupt frame ^
    push esp

    ; eax holds the command
    push eax
    call isr80h_handler
    mov dword[tmp_res], eax
    add esp, 8
    
    ; Restore general-purpose registers for user land
    popad
    mov eax, [tmp_res]
    iretd

section .data
; Stores return result from isr80h_handler
tmp_res: dd 0
