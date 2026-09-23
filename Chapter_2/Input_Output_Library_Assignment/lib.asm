;arg1(rdi) - status code
;exit(arg1){
;   make syscall exit and return status code
;}
exit:
    mov rax,60
    syscall
    ret 


;arg1(rdi) - null-terminated string pointer
;string_length(arg1){
;   count all ascii bytes till NULL 
;   return length
;}
string_length:
    push rbp        ;
    mov rbp,rsp     ; open stack frame 
    sub rsp,0x10    ;

    xor rcx,rcx     ; counter
    xor rax,rax     ; temp holds string byte for cmper
    .count:
        mov al,byte[rdi+rcx]    ; mov byte from the string
        cmp al,0x0              ; check if null
        jz .end                 ; if null go to end

        inc rcx                 ; increment counter
        jmp .count              ; coninue to next byte
    
    .end:
        mov rax,rcx             ; return count 
        add rsp,0x10            ; close stack frame
        pop rbp                 ;
        ret


;arg1(rdi) - null-terminated string pointer
;string_length(arg1){
;   print the string  
;   return length
;}
print_string:
    push rbp        ;
    mov rbp,rsp     ; open stack frame 
    sub rsp,0x10    ;

    push rdi                ; save addr pointer 
    call string_length      
    mov rdx,rax             ; syscall write arg4 length 
    pop rdi                 ; restore addr pointer 
    mov rsi,rdi             ; syscall write arg3 addr string
    mov rdi,1               ; syscall write arg2 file discriptor num 1(stdout)
    mov rax,1               ; number of syscall 1(write) 
    syscall

    add rsp,0x10            ; close stack frame
    pop rbp                 ;
    ret

;arg1(rdi) - char ascii code
;print_char(arg1){
;   get a char and print it 
;   return 0 as success 
;}
print_char:
    push rbp        ;
    mov rbp,rsp     ; open stack frame 
    sub rsp,0x10    ;

    lea rsi,[rbp-1]     ; calc the addres of the first byte on the stack to save the cahr    
    mov byte[rsi],dil   ; mov the char to the stack address

    mov rax,1           ;
    mov rdi,1           ; write syscall prep
    mov rdx,1           ;
    syscall             ;

    mov rax,0x0         ; return 0
    add rsp,0x10
    pop rbp
    ret



;print_newline(){
;   print newline  
;   return 0 as success 
;}
print_newline:
    mov rdi,0x0a
    call print_char
    mov rax,0
    ret


;arg1(rdi) -unsigned 8-byte integer
;print_uint(arg1){
;   convert rdi to ascii string as decimal format
;   and print it   
;   return 0 as success 
;}
print_uint:
    push rbp
    mov rbp,rsp
    sub rsp,0x20
    
    lea rsi,[rbp-1]     ; calc the addres of the first byte on the stack to save the cahr    
    mov byte[rsi],0x0   ; mov null to the end of the string 

    mov rax,rdi         ; hold the quotient
    mov rdi,10          ; hold the dvider 
    .convert:
        xor rdx,rdx
        div rdi

        dec rsi
        add dl,0x30
        mov byte[rsi],dl

        cmp rax,0x0
        je .print

        jmp .convert
    
    .print:
        mov rdi,rsi
        call print_string
        jmp .end

    .end:
        add rsp,0x20
        pop rbp 
        ret

    
    



