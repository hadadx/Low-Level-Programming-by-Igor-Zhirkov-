global find_word
extern string_equals

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
        mov rax,r14     ; thet node address if not zero
        test rax,rax
        jz .notFond

        mov rdi,r12     
        lea rsi,[r14+8]     ; load the adress of the value in the node
        call string_equals
        
        test rax,rax
        jnz .found

        mov r14,[r14]       ; mov the next node adress 
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