____

**Question 48 read about meaning of the fourth (08:01) and fifth (144225) column in man procfs.**
The fourth column, such as 08:01, identifies the device containing the mapped file using its major and minor device numbers. The fifth column, such as 144225, is the inode number of the mapped file.


**Question 49 What is an associative cache? Why is TLB one?**
An associative cache is a cache where entries are found by searching for a matching key, rather than by using a fixed memory location.

The TLB is associative because the CPU searches it using the virtual page number and, if a matching entry is found, gets the corresponding physical frame and permissions.




 **Question 50 What is virtual memory region?**
A virtual memory region is a continuous range of virtual addresses whose pages have the same permissions and properties. Examples include the code region, data region, heap, stack, and memory-mapped regions.

**Question 51 What will happen if you try to modify the program execution code during its execution**
get SIGSEGV signal


**Question 52 What are forbidden addresses?**
Forbidden addresses are virtual addresses that are not mapped to valid memory for the process, or that the process does not have permission to access. Accessing them usually causes a page fault and may result in SIGSEGV.



**Question 53 What is a canonical address?**
A canonical address is a valid x86-64 virtual address whose upper bits are a sign-extension of the highest implemented address bit. For 48-bit virtual addresses, bits 63:48 must be copies of bit 

**Question 54 What are the translation tables?**
Translation tables are page tables used by the MMU to translate virtual addresses into physical addresses.

In x86-64, the translation usually goes through PML4, PDPT, PD, and PT tables, whose entries also contain page permissions and status flags.


**Question 55 What is a page frame?**
A page frame is a fixed-size block of physical memory that can hold one virtual memory page. For 4 KB pages, each page frame is also 4 KB.


**Question 56 What is a memory region?**
A memory region is a continuous range of virtual memory pages that have the same permissions and properties.

Examples include the code, data, heap, stack, and memory-mapped regions.


**Question 57 What is the virtual address space? how is it different from the physical one?**
The virtual address space is the range of addresses that a process can use and see.
It is different from the physical address space, which represents the actual addresses in RAM.

**Question 58 What is a translation lookaside Buffer?**
A Translation Lookaside Buffer (TLB) is a small, fast cache inside the CPU that stores recent virtual-page to physical-frame translations and their permissions.


**Question 59 What makes the virtual memory mechanism performant?**
The main reasons virtual memory performs well are **locality** and the **TLB**.
Locality → programs usually access the same pages repeatedly, so most needed pages stay in RAM.
TLB → caches recent virtual-to-physical address translations, avoiding expensive page-table walks.
So page faults and full address translations happen relatively rarely.

**Question 60 how is the address space switched?**
The operating system switches address spaces by changing CR3 to point to another process's page tables.

 **Question 61 Which protection mechanisms does the virtual memory incorporate?**
 Virtual memory incorporates page-level protection mechanisms such as:
Read / Write permissions
User / Supervisor permissions
Execute / No-Execute (NX) permission
Present / Not-present state
These protections isolate processes, protect kernel memory from user programs, and prevent illegal memory access.

**Question 62 What is the purpose of EXB bit?**
The **EXB (Execution-Disabled Bit)**, also called **NX (No Execute)**, prevents code from being executed from a memory page.

**Question 63 What is the structure of the virtual address?**
In x86-64 with 4 KB pages, a virtual address is divided into page-table indexes and a page offset:
Bits 47:39 -> PML4 index
Bits 38:30  -> PDPT index
Bits 29:21  -> PD index
Bits 20:12  -> PT index
Bits 11:0   -> offset inside the 4 KB page

Each table index is 9 bits, and the offset is 12 bits.
For the common 48-bit canonical-address model, bits `63:48` are a sign-extension of bit `47`.

**Question 64 Does a virtual and a physical address have anything in common?**
 the offset

**Question 65 Can we write a string in .text section? What happens if we read it? and if we overwrite it?**
Yes, a string can be stored in the .text section. Reading it is usually allowed because .text is normally readable and executable. Overwriting it usually causes a page fault and SIGSEGV because .text is not writable. The CPU will only interpret the string bytes as instructions if execution actually jumps to that

****Question 66 Write a program that will call stat, open, and mmap system calls (check the system calls table in appendix C). it should output the file length and its contents**.
file q66.asm


**Question 67 Write the following programs, which all map a text file input.txt containing an integer x in**
**memory using a mmap system call, and output the following:**
1. **x! (factorial, x! = 1 · 2 · · · · · (x − 1) · x). It is guaranteed that x ≥ 0.**
2. **0 if the input number is prime, 1 otherwise.**
3. **Sum of all number’s digits.**
4. **x-th Fibonacci number.**
5. **Checks if x is a Fibonacci number.**

file q67.asm