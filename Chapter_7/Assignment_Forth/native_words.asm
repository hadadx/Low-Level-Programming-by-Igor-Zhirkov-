%include "macros.inc"
%define last_word static_dictionary_head

global rot_impl
global dup_impl
global swap_impl
global drop_impl
global remainder_impl
global less_than_impl
global equal_impl
global div_impl
global sub_impl
global plus_impl
global not_impl
global get_last_word_impl
global mem_impl
global inbuf_impl
global read_byte_impl
global store_impl
global petch_impl
global prints_impl
global emit_impl
global count_impl
global dot_impl
global print_impl
global mul_impl
global bey_impl
extern static_dictionary_head
extern next
extern user_mem
extern word_buff
extern print_string
extern print_char
extern string_length
extern print_int
extern print_newline
extern exit

section .text
rot_impl:
    pop rax
    pop rdi
    pop rsi

    push rax
    push rdi
    push rsi
    jmp next

dup_impl:
    pop rax
    push rax
    push rax
    jmp next


swap_impl:
    pop rax
    pop rdi
    push rax
    push rdi
    jmp next


drop_impl:
    pop rax
    jmp next

section .text
not_impl:
    pop rax

    test rax,rax
    jz .zero

    mov rax,0
    push rax
    jmp next
    .zero:
        mov rax,1
        push rax
        jmp next


remainder_impl:
    pop rdi
    pop rax
    cqo
    idiv rdi
    push rdx
    jmp next




less_than_impl:
    pop rdi
    pop rax

    cmp rax,rdi
    jb .true

    mov rax,0
    push rax
    jmp next


    .true:
        mov rax,0
        not rax
        push rax
        jmp next


equal_impl:
    pop rdi
    pop rax

    cmp rdi,rax
    je .eq

    mov rax,0
    push rax
    jmp next

    .eq:
        mov rax,0
        not rax
        push rax
        jmp next
    

div_impl:
    pop rdi
    pop rax
    cqo
    idiv rdi
    push rax
    jmp next




sub_impl:
    pop rdi
    pop rax
    sub rax,rdi
    push rax
    jmp next



plus_impl:
    pop rdi
    pop rax
    add rax,rdi
    push rax
    jmp next





; ARG1 - rdi get pointer to node and find the XT adress

section .text
get_last_word_impl:
    push last_word
    jmp next


mem_impl:
    push user_mem
    jmp next



inbuf_impl:
    push word_buff
    jmp next


read_byte_impl:
    pop rdi
    xor rax,rax
    mov al,byte[rdi]
    push rax
    jmp next

store_impl:
    pop rdi
    pop rax
    mov [rax],rdi
    jmp next

petch_impl:
    pop rdi
    mov rax,[rdi]
    push rax
    jmp next

section .data
stack_prompt: db "Stack frame:",0

section .text
prints_impl:
    pop rdi
    call print_string
    jmp next


emit_impl:
    pop rdi
    call print_char
    jmp next


count_impl:
    pop rdi
    call string_length
    push rax
    jmp next

dot_impl:
    pop rax
    mov rdi,rax
    call print_int
    call print_newline
    jmp next

print_impl:
    push r12    ;save copy of rsp
    push r13    ; save copy rbp

    mov r12,rsp
    add r12,0x10
    mov r13,rbp 

    cmp r12,r13
    je .no_elements
    
    mov rdi,stack_prompt
    call print_string

    .loop:
        call print_newline
        sub r13,8
        mov rdi,[r13]
        call print_int
        
        cmp r12,r13
        je .end

        jmp .loop
    
    .end:
        call print_newline
        pop r13
        pop r12
        jmp next

    .no_elements:
        jmp next

bey_impl:
    mov rdi,1
    call exit

mul_impl:
    pop rdi
    pop rax
    imul rax,rdi
    push rax
    jmp next
