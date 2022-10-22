; Bootloader for PeachOS

; begin at 0x7c00 (set origin)
ORG 0x7c00
; 16-bit architecture (use 16-bit assembly instructions)
BITS 16

start:
    ; si is index register
    mov si, message
    call print
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

message: db 'Hello World!', 0

; pad first 510 bytes with 0
times 510-($ - $$) db 0
; dw- assemble word (write 2 bytes of boot signature)
dw 0xaa55 ; little endian (big-endian is 0x55aa)