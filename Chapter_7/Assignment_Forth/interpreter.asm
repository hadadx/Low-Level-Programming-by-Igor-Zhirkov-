%include "macros.inc"
%define last_word static_dictionary_head

global interpreter_loop
global next
extern static_dictionary_head
extern last_word_run_time
extern word_buff
extern state
extern read_word
extern parse_int
extern find_word
extern cfa
extern build_word
extern defining_word_impl
extern stop_build_impl
extern exit

section .data
program_stub:
    dq 0
    dq interpreter_xt
interpreter_xt:
    dq interpreter_loop

section .text
interpreter_loop:
    mov rdi, word_buff
    mov rsi, 255
    call read_word

    test rax, rax
    jz .read_word_error

    cmp byte [word_buff],0
    je .end_of_input

    mov dl, [word_buff]

    cmp dl, ':'
    je defining_word_impl

    cmp dl, ';'
    je stop_build_impl

    mov rax, [state]
    test rax, rax
    jnz build_word


    cmp dl,0x2d
    je .decide_if_neg_number_or_word

    sub dl, '0'
    cmp dl, 0x9
    jbe .conver_number_and_push

    jmp .look_on_dic


    .decide_if_neg_number_or_word:
        mov dl,byte[word_buff+1]
        test dl,dl
        jz .look_on_dic

        jmp .conver_number_and_push


    .conver_number_and_push:
        mov rdi,word_buff
        call parse_int
        push rax

        jmp interpreter_loop

    .look_on_dic:
        mov rdi,word_buff
        mov rsi,[last_word_run_time]
        call find_word

        test rax,rax
        jz .word_not_found


        call cfa
        mov [program_stub], rax
        mov pc, program_stub
        

        jmp next        


    .read_word_error:
        jmp interpreter_loop

    .word_not_found:
        jmp interpreter_loop

    .end_of_input:
        mov rdi,0
        jmp exit

next:
    mov w, [pc]
    add pc, 8
    jmp [w]
