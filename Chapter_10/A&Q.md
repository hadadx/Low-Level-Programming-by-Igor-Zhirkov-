
#  A&Q
_____

**Question 188 Compile the file main by using gcc -o main main_square.o square.o line. Study its object table using objdump -t main. What can you tell about functions main and square?**

the main and square make as global without explicit theme global like asm


**Question 189 Try to find the same symbols using nm utility instead of readelf.**

**■Question 190 What is the difference between a declaration and a definition?**
A **declaration** tells the compiler that a variable or function exists and gives its type.
A **definition** actually creates the object or provides the function body.


**Question 191 What is a forward declaration?**
A **forward declaration** is a declaration that appears **before the full definition**, so the compiler knows that the function or object exists and how it should be used.


**Question 192 When are function declarations needed?**
Function declarations are needed **before a function is called**, if the compiler has not already seen its definition.


 **Question 193 When are structure declarations needed?**
 Structure declarations are needed when you want to tell the compiler that a structure type exists before providing its full definition.

**Question 194 how can the functions defined in other files be called?**
Functions defined in other files can be called by providing a **declaration** for them in the current file, usually through a header file, and then linking the corresponding object files together.


**Question 195 What effect does a function declaration make on the symbol table?**
A function declaration by itself does **not define** the function, so it does not create a defined function symbol in the object file.


**Question 196 how do we access data defined in other files?**
Data defined in another file is usually accessed with an **`extern` declaration**.

**Question 197 What is the concept of header files? What are they typically used for?**
Header files provide a common interface that can be included by multiple source files, typically containing declarations, types, macros, and other shared definitions.


 **Question 198 Which parts does the standard C library consist of?**

**Question 199 how does the program accept command-line arguments?**
Command-line arguments are passed to main through argc and argv.


**Question 201 how can we use the functions from the standard C library?**
To use functions from the standard C library, you usually:
1. Include the appropriate header so the compiler sees the function declaration.
2. Compile/link normally so the implementation is provided by the C library.


**Question 202 describe the machinery that allows the programmer to use external functions by including relevant headers.**

The machinery works in several stages:
```
#include header
      ↓
preprocessor inserts declarations
      ↓
compiler knows the function's type
      ↓
object file contains a reference to the external symbol
      ↓
linker resolves that symbol to the actual implementation
```



**Question 203 read about ld-linux.**


 **Question 204 What are the main directives of the C preprocessor?**
 According to the book, the main C preprocessor directives you should know here are:
```
#define
#include
#ifndef
#endif
```


**Question 205 What is the include guard used for and how do we write it?**
An **include guard** prevents the same header file from being included more than once in a single translation unit.



**Question 206 What is the effect of static global variables and functions on the symbol table?**
`static` global variables and `static` functions become **local symbols in the object file** instead of global/exported symbols.


 **Question 207 What are static local variables?**
 static local variable
→ local scope
→ initialized once
→ keeps its value between function calls


**Question 208 Where are static local variables created?**
Static local variables are **not created on the stack** like ordinary local variables.

They have **static storage duration**, so storage exists for the entire program. In practice, they are usually placed in the program’s global data sections


**Question 209 What is linkage? Which types of linkage exist?**
Linkage describes whether the **same identifier name** used in different places refers to the **same object/function**.

There are three types:

`1. No linkage 2. External linkage 3. Internal linkage`