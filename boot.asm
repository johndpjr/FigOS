; Bootloader for PeachOS

; begin at 0x7c00 (set origin)
ORG 0
; 16-bit architecture (use 16-bit assembly instructions)
BITS 16
_start:
    jmp short start
    nop

; BIOS parameter block
times 33 db 0

start:
    ; code segment becomes 0x7c0
    jmp 0x7c0:step2

step2:
    ; clear interrupts (about to change segment registers)
    cli
    ; set 0x7c0 as the data segment register
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax
    mov sp, 0x7c00 ; data segment
    ; enable interrupts
    sti

    ; infinite loop- jump to itself (don't want to call below >1 time)
    jmp $

print:
    mov bx, 0
.loop:
    ; load byte at address si into al register
    lodsb
    ; 0 is the null char for strings- signals end of string
    cmp al, 0
    je .done
    call print_char
    jmp .loop

.done:
    ret

print_char:
    ; set output to screen
    mov ah, 0eh
    ; call a BIOS routine to output char in al register
    ; int 0x10 (http://www.ctyme.com/intr/rb-0106.htm)
    int 0x10
    ret

; pad first 510 bytes with 0
times 510-($ - $$) db 0
; dw- assemble word (write 2 bytes of boot signature)
dw 0xaa55 ; little endian (big-endian is 0x55aa)