%include "macros.inc"

global stop_build_impl
global build_word
global defining_word_impl

extern state
extern next_word_run_time
extern last_word_run_time
extern init_word
extern word_buff
extern word_building_var

extern find_word
extern cfa
extern string_copy
extern string_length

extern docol
extern xt_exit
extern interpreter_loop


section .text


defining_word_impl:
    mov qword [state], 1
    mov qword [init_word], 0
    jmp interpreter_loop



build_word:
    mov rax, [init_word]
    test rax, rax
    jz .init


 

    mov rdi, word_buff
    mov rsi, [last_word_run_time]
    call find_word

    test rax, rax
    jz .error

    call cfa

  

    mov rdi, [word_building_var]

    mov [rdi], rax

    add rdi, 8
    mov [word_building_var], rdi

    mov [next_word_run_time], rdi

    jmp interpreter_loop



.init:

    ; RDI = start of free memory
    mov rdi, [next_word_run_time]

    ; Save new header address
    mov rbx, rdi

    ; previous pointer
    mov rax, [last_word_run_time]
    mov [rdi], rax

    add rdi, 8



    mov rsi, rdi
    mov rdi, word_buff
    mov rdx, 255
    call string_copy
    test rax, rax
    jz .error


    mov rdi, word_buff
    call string_length



    lea rdi, [rbx + 8]
    add rdi, rax

    inc rdi

    mov byte [rdi], 0
    inc rdi


    mov qword [rdi], docol
    add rdi, 8

    mov [word_building_var], rdi
    mov [next_word_run_time], rdi

    ; Save new dictionary head
    mov [last_word_run_time], rbx

    mov qword [init_word], 1

    jmp interpreter_loop

.error:
    mov qword [state], 0
    mov qword [init_word], 0
    jmp interpreter_loop


stop_build_impl:
    ; Append xt_exit to body
    mov rdi, [word_building_var]

    mov qword [rdi], xt_exit

    add rdi, 8

    mov [word_building_var], rdi
    mov [next_word_run_time], rdi

    ; Back to interpret mode
    mov qword [state], 0
    mov qword [init_word], 0

    jmp interpreter_loop
