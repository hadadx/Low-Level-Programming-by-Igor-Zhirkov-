%include "lib.asm"


section .data
buff: db "1251",0
buff2: times 10 db 0

section .text
global _start

_start:
    mov rdi,buff
    mov rsi,buff2
    mov rdx,10
    call string_copy
    test rax,rax
    jz .exit

    mov rdi,rax
    call print_string
    
    call print_newline
    jmp .exit
    .exit:
        mov rdi,rax
        call exit

