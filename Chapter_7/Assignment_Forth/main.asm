%include "macro.inc"
extern read_word
extern print_string
extern print_newline
extern parse_int
extern exit
extern find_word


section .data 
word "dup", dup

section .bss
word_buff resb 255

section .text                   
global _start    


_start:
    push rbp    ; start stack data 
    mov rbp,rsp ;

    .next_word:
        mov rdi,word_buff
        mov rsi,255
        call read_word
        jmp .decide_action

    .decide_action:
        xor dl,dl
        mov dl,byte[word_buff]

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
        jmp .next_word

    .look_on_dic:
        mov rdi,word_buff
        mov rsi,last_word
        call find_word
        test rax,rax
        jz .word_not_found
        
        lea rdi,[rax+13]
        call [rdi]
        jmp .next_word

    .word_not_found:
        xor rax,rax

dup_impl:
    pop rsi
    pop rdi
    pop rax
    imul rax,rdi
    push rax
    push rsi
    ret








