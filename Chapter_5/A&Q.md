# A&Q
***


**Question 72 Find out the ld option to automatically strip the symbol table after linking.**
-s


 **Question 73 Study the symbol tables for an obtained shared object using readelf --dyn-syms and objdump -ft**

**Question 74 What is the meaning behind the environment variable LD_LIBRARY_PATH?**
in wich path look for the .so files

**Question 75 Separate the first assignment into two modules. the first module will store all functions defined in lib.inc. the second will have the entry point and will call some of these functions**
Done

**Question 76 take one of the standard linux utilities (from coreutils). Study its object file structure using readelf and objdump**



**Question 77 What is the linked list?**
A linked list is a data structure in which each node contains a value and the address of the next node.
Unlike an array, the nodes of a linked list do not have to be stored next to each other in memory. Each node can be located in a different place in memory and contains a pointer to the next node.


**Question 78 What are the compilation stages?**
sourse code ->  Preprocessor  -> compiler/assmbler -> linker

**Question 79 What is preprocessing?**
Preprocessing is a stage that performs textual manipulation on the source code before assembly or compilation. It handles directives and macros such as `%define`, `%include`, and `%macro`, and replaces or expands them into the final source text that will be passed to the assembler.

**Question 80 What is a macro instantiation?**
macro instantiation is the use of a previously defined macro in the source code, causing the preprocessor to expand it.

Example:
```asm
; This is the macro definition.
%macro clear 1 
	xor %1, %1 
%endmacro

; is the macro instantiation.
clear rax
```


**Question 81 What is the %define directive?**
The `%define` directive creates a textual macro or alias that the preprocessor replaces in the source code.
Example:
```asm
%define SIZE 5

mov rax,SIZE 
```

**Question 82 What is the %macro directive?**
The `%macro` directive defines a multi-line macro that can accept arguments and expand into several lines of assembly code.

**Question 83 What is the difference between %define, %xdefine, and %assign?**
 `%define` - defines a textual replacement. Nested macros are expanded when the macro is used.
 `%xdefine` - defines a textual replacement, but expands nested macros immediately when it is defined.
 `%assign` - defines a numeric preprocessor variable and evaluates the expression immediately. Its value can be changed late

**Question 84 Why do we need the %% operator inside macro?**
%% is used to create a local label that is unique for each macro instantiation.
This prevents label-name conflicts when the same macro is used multiple times.


**Question 85 What types of conditions are supported by nasm macroprocessor?**
**Which directives are used for it?**
Numeric conditions                  - %if, %elif, %else, %endif
Symbol defined/not defined - %ifdef, %ifndef
Text comparison                       - %ifidn, %ifidni, %ifnidn
Token type checks                    - %ifid, %ifstr, %ifnum



**Question 86 What are the three types of elf object files?**
**Relocatable object file** - usually a `.o` file, used as input to the linker.
**Executable object file** - a complete executable program.
**Shared object file** - usually a `.so` file, used as a shared library.


**Question 87 What kinds of headers are present in an elf file?**
**ELF Header** - describes the ELF file itself: type, architecture, entry point, and where the other header tables are located.
**Program Headers** - describe the segments that the loader maps into memory.
**Section Headers** - describe the sections in the file, such as `.text`, `.data`, `.bss`, `.symtab`, etc.


**Question 88 What is relocation?**
Relocation is the linker process of adjusting address-dependent references in code or data after the final layout of the program is known.
For example, if an object file contains a reference to a function or variable whose final address is not yet known, the linker calculates the correct address or displacement and patches the reference.

```
before linking:
call external_func
→ address not final

after linking:
call correct_address
```

**Question 89 What sections can be present in elf files?**
```
.text      → executable machine code
.data      → initialized writable data
.bss       → zero-initialized / reserved data
.rodata    → read-only data
.symtab    → symbol table
.strtab    → symbol names
.rela.*    → relocation information
.debug_*   → debugging information
```


 **Question 90: What is a symbol table? What kind of information does it store?**
A symbol table is a table that stores information about symbols such as functions, variables, and labels.
It can store:
```
Symbol name
Address / offset
Size
Type
Binding        → local / global
Section        → .text / .data / .bss / etc.
Defined or undefined
```

Example:
```
func     → global → .text → offset 0x20
message  → local  → .data → offset 0x00
```

The linker uses the symbol table mainly to **find symbols and resolve references between object files**.



**Question 91 is there a connection between sections and segments?**
Yes. The linker groups sections into segments according to their purpose and permissions. The loader then uses the program headers to map those segments into virtual memory.



**Question 92 is there a connection between assembly sections and elf sections?**
Yes. In assembly, the programmer can explicitly place code and data into named sections such as `.text`, `.data`, and `.bss`.

**Question 93 What symbol marks the program entry point?**
The program entry point is commonly marked by a global symbol named `_start`

**Question 94 Which are the two different kind of libraries?**
 **Static library** - its required code is copied into the executable during linking.
**Dynamic / shared library** - remains a separate file and is loaded and linked at runtime.

**Question 95 is there a difference between a static library and a relocatable object file?**
Yes.

A **relocatable object file** (`.o`) is a single object file produced by the assembler or compiler.
A **static library** (`.a`) is an archive that contains multiple relocatable object files.

```
Relocatable object:
lib.o

Static library:
libsomething.a
├── file1.o
├── file2.o
└── file3.o
```

The linker can take the required object files from the static library and include their code in the final executable.

So:
```
.o - one relocatable object file
.a - collection/archive of .o files
```

