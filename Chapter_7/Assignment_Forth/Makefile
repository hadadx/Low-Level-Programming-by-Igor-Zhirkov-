main: main.o interpreter.o dictionary.o compiler.o native_words.o forth_runtime.o lib.o
	ld main.o interpreter.o dictionary.o compiler.o native_words.o forth_runtime.o lib.o -o main

main.o: main.asm macros.inc
	nasm -f elf64 main.asm -o main.o

interpreter.o: interpreter.asm macros.inc
	nasm -f elf64 interpreter.asm -o interpreter.o

dictionary.o: dictionary.asm macros.inc
	nasm -f elf64 dictionary.asm -o dictionary.o

compiler.o: compiler.asm macros.inc
	nasm -f elf64 compiler.asm -o compiler.o

native_words.o: native_words.asm macros.inc
	nasm -f elf64 native_words.asm -o native_words.o

forth_runtime.o: forth_runtime.asm macros.inc
	nasm -f elf64 forth_runtime.asm -o forth_runtime.o

lib.o: lib.asm
	nasm -f elf64 lib.asm -o lib.o

.PHONY: clean
clean:
	rm -f main main.o interpreter.o dictionary.o compiler.o native_words.o forth_runtime.o lib.o
