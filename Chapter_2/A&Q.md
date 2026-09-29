**Question 11 What does instruction xor rdi, rdi do?**
zero rdi 

**Question 12 What is the program return code?**
0

 **Question 13 What is the first argument of the exit system call?**
 return value 

 **Question 14 Check that the ASCII codes mentioned in the last example are correct.**
Correct

**Question 15 What is the difference between SAR and SHR?**

`SAR` shifts the bits to the right and preserves the sign by filling the leftmost bits with the original sign bit.

Example:

```
mov al, 11110000b
sar al, 1
```

Result:

```
al = 11111000b
```

`SAR` is commonly used for signed division by powers of 2.

`SHR` performs a logical right shift and fills the leftmost bits with zeros.

Example:

```c
mov al, 11110000b
shr al, 1
```

Result:

```c
al = 01111000b
```

`SHR` is commonly used for unsigned division by powers of 2.


**Question 16 How do you write numbers in different number systems in a way understandable to NASM?**

NASM supports different prefixes and suffixes for numeric constants.

Examples:

```
1111b       ; binary
0b1111      ; binary

1234h       ; hexadecimal
0x1234      ; hexadecimal

77o         ; octal
0o77        ; octal

1234d       ; decimal
1234        ; decimal
```

So:

- `b` or `0b` → binary
- `h` or `0x` → hexadecimal
- `o` or `0o` → octal
- `d` or no prefix/suffix → decimal



 **Question 17 What is the difference between je and jz?**
There is no functional difference between `JE` and `JZ`.

Both instructions jump when the Zero Flag (`ZF`) is set to 1.

```
je label
jz label
```

Both mean:

```
Jump if ZF = 1
```

The difference is only in how they are commonly used:

- `JE` = Jump if Equal, usually used after `CMP`
- `JZ` = Jump if Zero, usually used after arithmetic or logical instructions

**Question 18 What is test equal to after each of the commands listed previously?**

```asm

section .data
test: dq -1

section .text
mov byte[test], 1 ;1  test = 0xffffffffffffff01
mov word[test], 1 ;2  test = 0xffffffffffff0001
mov dword[test], 1 ;4 test = 0xffffffff00000001
mov qword[test], 1 ;8 test = 0x0000000000000001
```
_____


**Question 20 try to rewrite print_newline without calling print_char or copying its code. hint: read about tail call optimization.**

before:
```c
print_newline:
	mov rdi,0x0a
	call print_char
	mov rax,0
	ret
```

after:
```c
print_newline:
	mov rdi,0x0a
	jmp print_char
```


 **Question 21 try to rewrite print_int without calling print_uint or copying its code. hint: read about tail call optimization.**
befor:
```c
.positive:
	call print_uint
	jmp .end
```
after:
```c
.positive:
	add rsp,0x20
	pop rbp
	jmp print_uint
```


**Question 22 try to rewrite print_int without calling print_uint, copying its code, or using jmp. you will only need one instruction and a careful code placement**



**Question 23 What is the connection between rax, eax, ax, ah, and al?**
all of them parts of the same register

 **Question 24 how do we gain access to the parts of r9?**
 r9 - 64bits
 r9d - 32bits
 r9w - 16bits
 r9d - 8bits
 
 **Question 25 how can you work with a hardware stack? Describe the instructions you can use.**
 pop and push 
 with push you can "add to the top of the stack" pop "remove from the top"

 **Question 26 Which ones of these instructions are incorrect and why**
```c
mov [rax], 0                  // incorrect - memory size is not specified
cmp [rdx], bl                 ; correct - bl specifies the size (8-bit)
mov bh, bl                    ; correct - both are 8-bit registers
mov al, al                    ; correct - valid, but redundant
add bpl, 9                    ; correct - bpl is an 8-bit register
add [9], spl                  ; correct - spl specifies the size (8-bit)
mov r8d, r9d                  ; correct - both are 32-bit registers
mov r3b, al                   ; incorrect - r3b does not exist
mov r9w, r2d                  ; incorrect - r2d does not exist, and sizes don't match
mov rcx, [rax + rbx + rdx]    ; incorrect - address cannot use 3 registers
mov r9, [r9 + 8*rax]          ; correct - valid base + index*scale addressing
mov [r8+r7+10], 6             ; incorrect - r7 does not exist, and memory size is not specified
mov [r8+r7+10], r6            ; incorrect - r7 and r6 do not exist
```



**Question 27 enumerate the callee-saved registers**
rbx,r12,r13,r14,r15,rbp,rsp



**Question 28 enumerate the caller-saved registers**
rax,rdx,rcx,rsi,rdi,r8,r9,r10

 **Question 29 What is the meaning of rip register?**
 instruction pointer, hold the address of the next instruction
 
**Question 30 What is the SF flag?**
SF (Sign Flag) is set to 1 if the operation result has its MSB set to 1. Otherwise, SF is cleared to 0.

**Question 31 What is the ZF flag?**
SF (Zero Flag) is set to 1 if the operation result is 0. 

 **Question 32 Describe the effects of the following instructions:**
• **shr**  - Shifts the bits to the right. The empty bits on the left are filled with 0.              
• **xor** - Performs a bitwise XOR between two operands.
• **jmp** - Unconditionally jumps to another address/label.
• **ja, jb, and similar ones.** - Conditional jumps. They jump depending on the CPU flags. JA/JB are used for unsigned comparisons, while JG/JL are used for signed comparisons
• **cmp** - Compares two operands by subtracting the second from the first without storing the result. It only updates the flags.
• **mov** - Copies a value from the source operand to the destination operand.
• **inc,dec** - INC increases the operand by 1. DEC decreases the operand by 1.
• **add** - Adds the source operand to the destination operand and stores the result in the destination.
• **imul, mul** - MUL performs unsigned multiplication. IMUL performs signed multiplication.
• **sub** - Subtracts the source operand from the destination operand and stores the result in the destination.
• **idiv, div** - DIV performs unsigned division. IDIV performs signed division.
**• call, ret** - CALL calls a function by pushing the return address onto the stack and jumping to the function. RET pops the return address from the stack and jumps back to it.
**• push, pop** - CALL calls a function by pushing the return address onto the stack and jumping to the function. RET pops the return address from the stack and jumps back to it.


**Question 33 What is a label and does it have a size?**
A label is a name that represents an address in the program, such as the address of an instruction or data. A label itself does not have a size.


**Question 34 how do you check whether an integer number is contained in a certain range (x, y)?**
x>n>y

**Question 35 What is the difference between ja/jb and jg/jl?**
JA/JB are used for unsigned comparisons. 
JG/JL are used for signed comparisons.

**Question 36 What is the difference between je and jz?**
Both jump when the Zero Flag (ZF) is set to 1.

**Question 37 how do you test whether rax is zero without the cmp command?**
test rax,rax
jz 

**Question 38 What is the program return code?**
 the number in RAX after syscall exit



**Question 39 how do we multiply rax by 9 using exactly one instruction?**
lea rax, [rax + 8*rax]

**Question 40 by using exactly two instructions (the first is neg), take an absolute value of an integer stored in rax.**

neg rax 
cmovl rax, ??? 

**Question 41 What is the difference between little and big endian?**
Big endian stores the most significant byte (MSB) first. 
Little endian stores the least significant byte (LSB) first.
Big Endian: 12 34 56 78 
Little Endian: 78 56 34 12

**Question 42 What is the most complex type of addressing?**
base + index * scale + displacement
mov rax, [rbx + rcx*8 + 16]

**Question 43 Where does the program execution start?**
The program execution starts at the entry point, usually the  `_start` label.



**Question 44 rax = 0x112233445567788. We have performed push rax. What will be the contents of byte at address [rsp+3]?**
0x45
