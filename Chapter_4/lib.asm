;arg1(rdi) - status code
;exit(arg1){
;   make syscall exit and return status code
;}
exit:
    mov rax,60      ; number of syscall 60(exit)
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
        jmp .count              ; continue to next byte

    .end:
        mov rax,rcx             ; return count
        add rsp,0x10            ; close stack frame
        pop rbp                 ;
        ret


;arg1(rdi) - null-terminated string pointer
;print_string(arg1){
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
    mov rdi,1               ; syscall write arg2 file descriptor num 1(stdout)
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

    lea rsi,[rbp-1]     ; calc the address of the first byte on the stack to save the char
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
    jmp print_char


;arg1(rdi) - unsigned 8-byte integer
;print_uint(arg1){
;   convert rdi to ascii string as decimal format
;   and print it
;   return 0 as success
;}
print_uint:
    push rbp
    mov rbp,rsp
    sub rsp,0x20

    cmp rdi,0x0
    jz .printZero

    lea rsi,[rbp-1]     ; calc the address of the first byte on the stack to save the char
    mov byte[rsi],0x0   ; mov null to the end of the string

    mov rax,rdi         ; hold the quotient
    mov rdi,10          ; hold the divider
    .convert:
        xor rdx,rdx             ;
        div rdi                 ;

        dec rsi                 ;
        add dl,0x30             ; divided by 10 and save the remainder as ascii till quotient = 0
        mov byte[rsi],dl        ;

        cmp rax,0x0             ;
        je .print               ;

        jmp .convert            ;

    .print:
        mov rdi,rsi
        call print_string       ; print the number string
        jmp .end

    .printZero:
        mov rdi,0x30
        call print_char
        jmp .end

    .end:
        mov rax,0
        add rsp,0x20
        pop rbp
        ret


;arg1(rdi) - signed 8-byte integer
;print_int(arg1){
;   convert rdi to ascii string as decimal format
;   and print it
;   return 0 as success
;}

print_int:
    push rbp
    mov rbp,rsp
    sub rsp,0x20

    cmp rdi,0x0
    jz .printZero

    test rdi, rdi
    jns .positive           ; sign flag clear, number is positive

    not rdi                 ; negate rdi
    add rdi,1               ; two's complement, rdi now holds |rdi|

    lea rsi,[rbp-1]
    mov byte[rsi],0x0
    mov rax,rdi
    mov rdi,10

    .convert:
        xor rdx,rdx             ;
        div rdi                 ;

        dec rsi                 ;
        add dl,0x30             ; divided by 10 and save the remainder as ascii till quotient = 0
        mov byte[rsi],dl        ;

        cmp rax,0x0             ;
        je .print               ;

        jmp .convert

    .print:
        dec rsi                 ; make room for the sign
        mov byte[rsi],0x2d      ; prepend minus sign
        mov rdi,rsi
        call print_string
        jmp .end

    .positive:
        add rsp,0x20
        pop rbp
        jmp print_uint


;    .positive:
;       call print_uint
;       jmp .end

    .printZero:
        mov rdi,0x30
        call print_char
        jmp .end

    .end:
        mov rax,0
        add rsp,0x20
        pop rbp
        ret







;read_char(){
;   Read one character from stdin and return it.
;   return 0 if end of input stream occurs
;}
read_char:
    push rbp        ;
    mov rbp,rsp     ; open stack frame
    sub rsp,0x10    ;

    mov rax,0           ; number of syscall 0(read)
    mov rdi,0           ; syscall read arg2 file descriptor num 0(stdin)
    lea rsi,[rbp-1]     ; syscall read arg3 addr to save the char
    mov rdx,1           ; syscall read arg4 length (1 byte)
    syscall

    cmp rax,-1          ; check if syscall returned error
    je .EOF
    jmp .end

    .end:
        xor rax,rax
        mov al,byte[rsi]    ; return the char that was read
        add rsp,0x10
        pop rbp
        ret

    .EOF:
        mov rax,0           ; return 0 on end of input
        jmp .end


;arg1(rdi) - buffer address
;arg2(rsi) - size
;read_word(arg1,arg2){
; Reads next word from stdin
; (skipping whitespaces into buffer). Stops and returns 0 if word is too big for the
; buffer specified; otherwise returns a buffer address.
;}
read_word:
    push rbp
    mov rbp,rsp     ; open stack frame
    push r12
    push r13
    push r14
    sub rsp,0x10

    mov r12,rdi     ; save buffer address
    mov r13,rsi     ; save buffer size
    xor r14,r14     ; counter of chars written to buffer

    .loop:
        call read_char

        test al, al
        jz .success             ; end of input, finish word

        cmp al,0x09
        je .checkWhitespaces
        cmp al,0x0A
        je .checkWhitespaces
        cmp al,0x0B
        je .checkWhitespaces
        cmp al,0x0C
        je .checkWhitespaces
        cmp al,0x0D
        je .checkWhitespaces
        cmp al,0x20
        je .checkWhitespaces    ; char is a whitespace

        cmp r14, r13
        jae .error              ; buffer full, word too big

        mov byte[r12+r14],al    ; store char in buffer
        inc r14                 ; increment counter

        jmp .loop


    .checkWhitespaces:
        cmp r14,0x0
        je .loop                ; skip leading whitespaces
        jmp .success            ; whitespace ends the word

    .error:
        mov byte[r12+r14],0x0   ; null-terminate buffer
        mov rax,0               ; return 0, word too big
        jmp .end

    .success:
        mov byte[r12+r14],0x0   ; null-terminate buffer
        mov rax,r12             ; return buffer address
        jmp .end

    .end:
        add rsp,0x10            ; close stack frame
        pop r14
        pop r13
        pop r12
        pop rbp
        ret


;arg1(rdi) - null-terminated string represent unsigned number
;parse_uint(arg1){
; Returns the number parsed in rax, its characters count in rdx.
;}
parse_uint:
    push rbp
    mov rbp,rsp     ; open stack frame
    push r12
    push r13
    sub rsp,0x10

    mov r12,rdi         ; save string pointer
    call string_length
    mov rdi,r12         ; ptr
    mov r13,rax         ; len
    xor rcx,rcx         ; counter
    mov rsi,10         ; multiplier
    xor r12,r12         ; clear digit register
    xor rax,rax         ; clear accumulator
    dec r13             ; stop loop one digit before the last

    .loop:
        cmp r13,rcx
        je .end

        mov r12b,byte[rdi+rcx]     ; current digit char
        sub r12b,0x30              ; convert char to digit value
        add rax,r12                ; add digit to accumulator

        mul rsi                    ; multiply accumulator by 10
        inc rcx

        jmp .loop

    .end:
        mov r12b,byte[rdi+rcx]     ; last digit char
        sub r12b,0x30              ; convert char to digit value
        add rax,r12                ; add last digit to accumulator

        mov rdx,rcx         ; return chars count
        add rsp,0x10
        pop r12
        pop r13
        pop rbp
        ret




;arg1(rdi) - null-terminated string represent signed number
;parse_int(arg1){
;Returns the number parsed in rax its characters count in rdx (including sign if any).
;No spaces between sign and digits are allowed.
;}
parse_int:
    push rbp
    mov rbp,rsp     ; open stack frame
    sub rsp,0x10

    cmp byte[rdi],0x2d      ; check for '-' sign
    jne .positive


    inc rdi             ; skip the sign char
    call parse_uint
    not rax             ;
    add rax,1           ; two's complement, negate the parsed value

    jmp .end

    .positive:
        call parse_uint
        jmp .end

    .end:
        add rsp,0x10        ; close stack frame
        pop rbp
        ret

;arg1(rdi) - null string ptr
;arg2(rsi) - null string ptr
;string_equals(arg1,arg2){
;Accepts two pointers to strings and compares them. Returns 1 if they are equal,
;otherwise 0.
;}
string_equals:
    push rbp
    mov rbp,rsp     ; open stack frame
    sub rsp,0x10

    push r12
    push r13


    mov r12,rdi     ; save first string pointer
    mov r13,rsi     ; save second string pointer

    xor rdi,rdi
    xor rax,rax
    xor rcx,rcx     ; counter

    .loop:
        mov dl,byte[r12+rcx]    ; char from first string
        mov al,byte[r13+rcx]    ; char from second string

        cmp dl,al
        jne .notEqual           ; chars differ, strings not equal

        cmp dl,0x0
        jz .equal               ; both strings ended, equal

        inc rcx
        jmp .loop

    .notEqual:
        mov rax,0       ; return 0
        jmp .end

    .equal:
        mov rax,1       ; return 1
        jmp .end

    .end:
        pop r13
        pop r12
        add rsp,0x10
        pop rbp
        ret

;arg1(rdi) - null string ptr
;arg2(rsi) - dest copy buffer
;arg3(rdx) - size dest buffer
;string_copy(arg1,arg2,arg3){
;   Copies string to the destination. The destination address is returned if the string fits the buffer;
;   otherwise zero is returned.
;}
string_copy:
    push rbp
    mov rbp,rsp     ; open stack frame
    sub rsp,0x10

    push rdi
    push rsi
    push rdx

    call string_length      ; get source string length
    pop rdx
    pop rsi
    pop rdi

    cmp rax,rdx
    ja .smallBuffer         ; string doesn't fit in destination buffer

    mov r8,rax          ; save string length
    xor rcx,rcx         ; counter
    xor rax,rax
    .copyLoop:
        mov al,byte[rdi+rcx]    ; char from source
        mov byte[rsi+rcx],al    ; copy char to destination
        inc rcx

        cmp rcx,r8
        je .success

        jmp .copyLoop

    .smallBuffer:
        mov rax,0       ; return 0
        jmp .end

    .success:
        mov byte[rsi+rcx],0x0  ; null-terminate destination
        mov rax,rsi             ; return destination address
        jmp .end

    .end:
        add rsp,0x10
        pop rbp
        ret
