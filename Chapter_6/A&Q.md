# A&Q
___

**Question 96 What are non-maskable interrupts? What is their connection with the interrupt with code 2 and IF flag?**
A non-maskable interrupt (NMI) is an interrupt that cannot be disabled by clearing the `IF` flag.
In x86-64, interrupt vector 2 is reserved for the NMI.


**Question 97 Is the TF flag cleared automatically when entering interrupt handlers? refer to**
Yes.
When the CPU enters an interrupt or exception handler through an interrupt gate or trap gate, it first saves `RFLAGS` on the stack and then clears the TF flag automatically.

**Question 98 What is an interrupt?**
An interrupt is an event that changes the normal control flow of a program and causes the CPU to execute an interrupt handler.

**Question 99 What is Idt?**
The **IDT (Interrupt Descriptor Table)** is a table that maps interrupt numbers to interrupt handlers.

```
Interrupt number
      ↓
     IDT
      ↓
Handler address
```

Its address and size are stored in `IDTR`

**Question 100 What does setting IF change?**
`IF` is the **Interrupt Flag** in `RFLAGS`.

```
IF = 1 → maskable interrupts are accepted
IF = 0 → maskable interrupts are ignored
```

Non-maskable interrupts such as NMI are not blocked by `IF`

**Question 101 In which situation does the Gp error occur?**
According to the chapter, `#GP` (General Protection Fault) occurs when the program performs an invalid or forbidden operation, such as:
```
accessing a forbidden address
executing an operation requiring higher privilege
```


**Question 102 In which situations does the PF error occur?**
`#PF` (Page Fault) occurs when the CPU accesses a page whose page-table entry indicates that the page is not currently present.

```
Memory access
    ↓
Page not present
    ↓
#PF
```

**Question 103 how is PF error related to the swapping? how does the operating system use it?**
The OS can intentionally leave a page marked as not present.

When the program accesses it:
```
Program accesses page
      ↓
#PF
      ↓
Kernel page-fault handler
      ↓
Load missing page from disk
      ↓
Continue execution
```
This mechanism is used for **swapping** and file-backed memory mappings.



**Question 104 Can we implement system calls using interrupts?**
Yes.
Older Unix-like systems on x86 used:
```
int 0x80
```

The interrupt handler then inspected registers to determine the system-call number and arguments.



 **Question 105 Why do we need a separate instruction to implement system calls?**
 System calls are very frequent, while the general interrupt mechanism can be relatively expensive.

Intel 64 therefore provides:
```
syscall
sysret
```
as a more specialized mechanism for entering and leaving the kernel.



 **Question 106 Why does the interrupt handler need a dpl field?**
 `DPL` controls whether code at a certain privilege level is allowed to invoke that handler using the `int` instruction.
```
User code
   ↓ int N
Check DPL
   ↓
Allowed / denied
```
This prevents user programs from directly invoking privileged handlers that they should not be able to call.

**Question 107 What is the purpose of interrupt stack tables?**
ISTs provide **special known-good stacks** for specific interrupts.
They are useful for serious faults where the current stack may be damaged or unreliable.
Examples:
```
NMI
Double Fault
```
The IST pointers are stored in the TSS.

**Question 108 does a single thread application have only one stack?**
No.
A thread normally has its **user-mode stack**, but when execution enters the kernel, the CPU may switch to another stack.
There can also be special IST stacks for particular interrupts.
```
User stack
Kernel stack
IST stacks
```
The TSS stores stack pointers used for privilege transitions and special interrupt handling.


 **Question 109 What kinds of input/output mechanisms does Intel 64 provide?**
Two main mechanisms:
```
1. Port I/O
   → separate I/O address space
   → IN / OUT instructions

2. Memory-Mapped I/O
   → device mapped into memory address space
   → normal memory instructions such as MOV
```



**Question 110 What is a model-specific register?**
An **MSR (Model-Specific Register)** is a special CPU register that may exist only on particular processor models or architectures.
They are accessed using:
```
rdmsr
wrmsr
```
`ECX` selects the MSR, and the value is transferred through `EDX:EAX`.

 **Question 111 What are the shadow registers?**
Shadow registers are hidden internal CPU registers associated with segment registers such as `CS`, `SS`, or `TR`.
When a selector is loaded, the CPU reads the corresponding descriptor and caches information such as:
```
base
limit
attributes
privilege information
```
The chapter specifically mentions that the hidden part of `TR` is updated from the GDT when `LTR` loads a new task-register selector.


 **Question 112 how are the model-specific registers used in the system call mechanism?**
`syscall` uses several MSRs:
```
STAR
→ CS / SS information

LSTAR
→ address of the syscall handler

SFMASK
→ which RFLAGS bits should be cleared
```
So:
```
syscall
   ↓
LSTAR → new RIP
STAR  → privilege/segment information
SFMASK → modify RFLAGS
```



 **Question 113 Which registers are used by syscall instruction?**
The important implicitly used registers are:
```
RCX → stores the old RIP
R11 → stores the old RFLAGS
```

The new `RIP` is loaded from `LSTAR`. Pasted text

In the Linux syscall ABI, registers such as `RAX`, `RDI`, `RSI`, `RDX`, `R10`, `R8`, and `R9` are also used for the syscall number and arguments, but that calling convention is separate from what the CPU's `syscall` instruction itself implicitly does.



