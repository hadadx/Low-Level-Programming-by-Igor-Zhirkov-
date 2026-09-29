%include "lib.asm"
section .data
filename: db "input.txt", 0
struct: times 144 db 0

section .text
global _start 

_start:
    push rbp
    mov rbp,rsp
    sub rsp,0x10

    ; get file strct
    mov rdi,filename
    mov rsi,struct
    mov rax,4
    syscall

    lea rsi,[rbp-8]
    mov rdi,[struct+48]   ; save size
    mov [rsi],rdi

    ; first open the file and get discriptor
    mov rax,2 
    mov rdi,filename
    mov rsi,0
    mov rdx,0
    syscall

    ; map the file to memory to acsess the content 
    mov r8,rax
    
    mov rax,9
    mov rdi,0
    lea rdx,[rbp-8]
    mov rsi,[rdx]
    mov rdx,0x1
    mov r10,0x2
    mov r9,0
    syscall

    ; print content
    mov rsi,rax
    lea rax,[rbp-8]
    mov rdx,[rax]
    mov rax,1
    mov rdi,1
    syscall
    
    ; return file size
    lea rsi,[rbp-8]
    mov rdi,[rsi]
    call exit
