%include "macros.inc"

global last_word_static
global static_dictionary_head
global cfa
global find_word
global xt_exit
extern drop_impl
extern swap_impl
extern dup_impl
extern rot_impl
extern plus_impl
extern sub_impl
extern div_impl
extern mul_impl
extern less_than_impl
extern remainder_impl
extern not_impl
extern equal_impl
extern bey_impl
extern print_impl
extern dot_impl
extern prints_impl
extern count_impl
extern emit_impl
extern petch_impl
extern store_impl
extern read_byte_impl
extern inbuf_impl
extern get_last_word_impl
extern mem_impl
extern exit_impl
extern RtoD_impl
extern DtoR_impl
extern CFRtoD_impl
extern defining_word_impl
extern stop_build_impl
extern string_length
extern string_equals

section .data
word "drop",drop
word "swap",swap
word "dup",dup
word "rot",rot

word "+", plus
word "-", sub
word "/", div
word "*", mul
word "<",less_than
word "%",remainder

word "not",not
word "=", equal

word "bey", bey
word ".S", print
word ".",dot

word "prints",prints
word "count",count
word "emit",emit

word "@",petch
word "!",store
word "@c",read_byte

word "inbuf", inbuf
word "last_word", get_last_word
word "mem", mem
word "exit",exit
word ">r",RtoD
word "r>",DtoR
word "r@",CFRtoD

word ":" ,defining_word
word ";" ,stop_build

last_word_static: dq last_word

static_dictionary_head equ last_word

section .text
cfa:
    add rax,8
    push rax
    mov rdi,rax
    call string_length
    mov rdi,rax
    pop rax
    add rax,rdi
    add rax,2
    ret


; arg1(rdi) - A pointer to a null terminated key string
; arg2(rsi) - poiter to the first node in the linkig list
; find_word(){
;       loop on the list and look for the key if found return ptr to the node otherwise 0
;}
find_word:
    push rbp
    mov rbp,rsp 
    sub rsp,0x10
    
    push r12 ; save wordTofind ptr
    push r13 ; link list entry ptr
    push r14 ; next node

    mov r12,rdi
    mov r13,rsi
    mov r14,rsi
    
    .lookUp:
        mov rax,r14     
        test rax,rax
        jz .notFond

        mov rdi,r12     
        lea rsi,[r14+8]     
        call string_equals
        
        test rax,rax
        jnz .found

        mov r14,[r14]        
        jmp .lookUp
    
    .found:
        mov rax,r14
        jmp .end

    .notFond:
        mov rax,0
        jmp .end

    .end:
        pop r14
        pop r13
        pop r12
        add rsp,0x10
        pop rbp
        ret
