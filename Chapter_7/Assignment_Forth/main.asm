; Program entry point and initial setup.
%include "macros.inc"
%define last_word static_dictionary_head

global _start
extern static_dictionary_head
extern return_stack_end
extern last_word_run_time
extern next_word_run_time
extern user_mem
extern interpreter_loop

section .text
_start:
    push rbp
    mov rbp,rsp

    mov rstack,return_stack_end

    mov rax,last_word
    mov [last_word_run_time],rax

    mov rax,user_mem
    mov [next_word_run_time],rax

    jmp interpreter_loop
