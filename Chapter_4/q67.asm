%include "lib.asm"

section .data
filename: db "input.txt",0
struct: times 144 db 0


section .text
global _start 

_start:
    push rbp
    mov rbp,rsp
    sub rsp,0x20

    push r12
    
    ; save file discriptor 
    mov rax,2
    mov rdi,filename
    mov rsi,0
    mov rdx,0
    syscall

    mov r12,rax   ; file discriptor save


    ; get file structer 
    mov rdi,filename
    mov rsi,struct
    mov rax,4
    syscall

    test rax,rax
    jnz .exit

    ; map it to mem 
    mov rax,9
    mov rdi,0
    mov rsi,[struct+48]
    mov rdx,0x1
    mov r10,0x2
    mov r8,r12
    mov r9,0
    syscall

    mov rdi,rax
    call parse_int
    mov rdi,rax

    ; call factorial
    ; mov rdi,rax

    ; call prime
    ; mov rdi,rax

    ; call sumAllDigits
    ; mov rdi,rax

    ; call fiboNum
    ; mov rdi,rax

    call isFibo
    mov rdi,rax

    jmp .exit


    .exit:
        call exit





; arg1 (rdi) - uint
; isFibo(arg1) {
;   Checks whether x is a Fibonacci number.
;   Returns 0 if x is a Fibonacci number, otherwise returns 1.
; }
isFibo:
    push rbp 
    mov rbp,rsp
    sub rsp,0x10

    push r12
    mov r12,rdi
    xor rcx,rcx

    .loop:
        mov rdi,rcx
        call fiboNum
        inc rcx
        cmp r12,rax
        je .fiboConfirm
        jb .notFibo
        ja .loop

    .fiboConfirm:
        mov rax,0
        jmp .end

    .notFibo:
        mov rax,1
        jmp .end

    .end:
        pop r12
        add rsp,0x10
        pop rbp
        ret





; arg1 (rdi) - uint
; fiboNum(arg1) {
;   return the x-th Fibonacci number.
;   If x > 93, return 9 to indicate that the value would overflow 64 bits.
; }
fiboNum:
    ; check f(0)
    test rdi,rdi
    jz .fzero
    ; check f(1)
    cmp rdi,1
    je .fone

    ; max fibo index in this func 93
    cmp rdi,0x5D
    ja .maxIndex


    ; f(0)
    mov rsi,0
    ; f(1)
    mov r8,1

    ; counter
    mov rcx,1

    xor rax,rax
    ; start calc fibo
    .fibo:
        add rax,rsi
        add rax,r8
        inc rcx

        cmp rcx,rdi
        je .end
        
        mov rsi,r8
        mov r8,rax
        xor rax,rax
        jmp .fibo

    .end:
        ret
    .fzero:
        mov rax,0
        jmp .end

    .fone:
        mov rax,1
        jmp .end
    .maxIndex:
        mov rax,0x9
        jmp .end



;arg1(rdi) - uint
;sumAllDigits(arg1){
;   return Sum of all number’s digits
;}
sumAllDigits:
    mov rcx,10
    mov rax,rdi
    xor rdi,rdi
     .loop:
        xor rdx,rdx
        div rcx
        add rdi,rdx

        test rax,rax
        jz .exit

        jmp .loop

    .exit:
        mov rax,rdi
        ret
    


;arg1(rdi) - uint
;parse_int(arg1){
;   return 0 if prime or 1 if not 
;}
prime:
    push rbp
    mov rbp,rsp
    sub rsp,0x10

    cmp rdi,1
    jbe .notPrim

    mov rcx,rdi
    dec rcx
    .testPrim:
        mov rax,rdi
        xor rdx,rdx
        div rcx
        test rdx,rdx
        jz .notPrim

        dec rcx 

        cmp rcx,2
        jb .itsPrime


        jmp .testPrim

    .itsPrime:
        mov rax,0
        jmp .end

    .notPrim:
        mov rax,1
        jmp .end
    
    .end:
        add rsp,0x10
        pop rbp
        ret




;arg1(rdi) - factorial n
;parse_int(arg1){
; return n! (n × (n-1) × (n-2) × ... × 1)
;}
factorial:
    push rbp
    mov rbp,rsp
    sub rsp,0x10

    ; test zero 
    test rdi,rdi
    jz .end
    mov rax,rdi
    dec rdi
    .loop:
       mul rdi  
       dec rdi
       test rdi,rdi
       jz .end
       jmp .loop

    .end: 
        add rsp,0x10
        pop rbp 
        ret




