; Shared state, buffers, return stack, and threaded execution.
%include "macros.inc"

global state
global init_word
global word_building_var
global word_buff
global last_word_run_time
global next_word_run_time
global return_stack
global return_stack_end
global user_mem
global CFRtoD_impl
global DtoR_impl
global RtoD_impl
global toR_impl
global docol
global exit_impl
extern static_dictionary_head
extern next

section .data
state: dq 0
init_word: dq 0
word_building_var: dq 0
section .bss
word_buff resb 255

last_word_run_time:
    resq 1

    
next_word_run_time:
    resq 1


return_stack:
    resq 1024
return_stack_end:


user_mem:
    resq 65536

section .text
CFRtoD_impl:
    mov rax,[rstack]
    push rax
    jmp next


DtoR_impl:
    pop rax
    sub rstack,8
    mov [rstack],rax
    jmp next

RtoD_impl:
    mov rax,[rstack]
    add rstack, 8
    push rax
    jmp next 

toR_impl:
    mov rax,[rstack]
    add rstack, 8
    push rax
    jmp next 

docol:
    sub rstack, 8
    mov [rstack], pc
    lea pc, [w + 8]
    jmp next


exit_impl:
    mov pc,[rstack]
    add rstack,0x8
    jmp next
