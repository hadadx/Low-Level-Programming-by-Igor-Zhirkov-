%include "lib.asm"


section .data
buff: db "hello",0
buff2: times 10 db 0

section .text
global _start

_start:
    mov rdi,0x2
    call print_uint
    mov rdi,rax
    call exit

