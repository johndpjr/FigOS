; Bootloader for PeachOS

; begin at 0x7c00 (set origin)
ORG 0x7c00
; 16-bit architecture (use 16-bit assembly instructions)
BITS 16

CODE_SEG equ gdt_code - gdt_start ; gives offset 0x08
DATA_SEG equ gdt_data - gdt_start ; gives offset 0x10

_start:
    jmp short start
    nop

; BIOS parameter block
times 33 db 0

start:
    ; code segment becomes 0x00
    jmp 0:step2

step2:
    ; clear interrupts (about to change segment registers)
    cli
    ; set 0x00 as the data segment register
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7c00 ; data segment
    ; enable interrupts
    sti

.load_protected:
    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:load32

; Global Descriptor Table (GDT)
gdt_start:
gdt_null: ; 64 bits of 0
    dd 0x0
    dd 0x0

; offset 0x8
gdt_code:        ; CS should point to this
    dw 0xffff    ; segment limit first 0-15 bits
    dw 0         ; base first 0-15 bits
    db 0         ; base 16-23 bits
    db 0x9a      ; access byte
    db 11001111b ; high 4 bit flags and low 4 bit flags
    db 0         ; base 24-31 bits

; offset 0x10
gdt_data:        ; DS, SS, ES, FS, GS
    dw 0xffff    ; segment limit first 0-15 bits
    dw 0         ; base first 0-15 bits
    db 0         ; base 16-23 bits
    db 0x92      ; access byte
    db 11001111b ; high 4 bit flags and low 4 bit flags
    db 0         ; base 24-31 bits

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; calculate size of code above
    dd gdt_start

[BITS 32]
load32:
    mov ax, DATA_SEG
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0x00200000
    mov esp, ebp
    jmp $


; pad first 510 bytes with 0
times 510-($ - $$) db 0
; dw- assemble word (write 2 bytes of boot signature)
dw 0xaa55 ; little endian (big-endian is 0x55aa)

buffer: