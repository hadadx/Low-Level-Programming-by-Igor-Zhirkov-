%include "words.inc"
%define buffSize 4

%define EXIT_SUCCESS 0
%define EXIT_FAILURE 1

extern exit
extern find_word
extern read_word
extern print_string

section .data
bufferOverFlow: db "word size bigger then buferr",0
error_len_BOF: equ $ - bufferOverFlow

wordNotFound: db "Key not found",0
error_len_notFound: equ $ - wordNotFound

section .bss
my_word: resb 255


section .text
global _start

_start:
    mov rdi,my_word
    mov rsi,buffSize

    call read_word
    test rax,rax
    jz .bufferErorr

    mov rdi,rax
    mov rsi,first_word  
    call find_word

    test rax,rax
    jz .wordNotFoundErorr

    mov rdi,[rax + 8]
    call print_string
    
    mov rdi,EXIT_SUCCESS
    jmp .exit 

    .exit:
        call exit


    .bufferErorr:
        mov rsi,bufferOverFlow
        mov rdx,error_len
        jmp .writeErorr

    .wordNotFoundErorr:
        mov rsi,wordNotFound
        mov rdx,error_len_notFound
        jmp .writeErorr
        
    .writeErorr:
        mov rax,1
        mov rdi,2
        syscall

        mov rdi,EXIT_FAILURE
        jmp exit




    





