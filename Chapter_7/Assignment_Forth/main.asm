%include "macro.inc"
extern read_word
extern print_string
extern print_newline
extern parse_int
extern exit
extern find_word
extern string_length

section .data 
word "dup", dup

section .bss
word_buff resb 255

section .text                   
global _start    
global stage_one

_start:
    push rbp
    mov rbp,rsp

    jmp stage_one





stage_one:
    mov rdi,word_buff
    mov rsi,255

    call read_word

    test rax,rax
    jz .read_word_error

    xor dl,dl
    mov dl,[word_buff]

    cmp dl,0x2d
    je .decide_if_neg_number_or_word

    cmp dl,0x30
    je .conver_number_and_push

    cmp dl,0x39
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

        jmp stage_one

    .look_on_dic:
        mov rdi,word_buff
        mov rsi,last_word
        call find_word

        test rax,rax
        jz .word_not_found


        call cfa
        jmp [rax]

        jmp stage_one        


    .read_word_error:
        jmp stage_one

    .word_not_found:
        jmp stage_one





; ARG1 - rdi get pointer to node and find the XT adress  
cfa:
    push rdi
    add rdi,8
    call string_length
    pop rdi
    add rax,rdi
    ret


dup_impl:
    pop rdi
    pop rax
    imul rax,rdi
    push rax
    jmp stage_one




