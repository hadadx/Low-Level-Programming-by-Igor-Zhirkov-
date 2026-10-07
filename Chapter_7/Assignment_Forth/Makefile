main: main.o lib.o dict.o
	ld main.o lib.o dict.o -o main

main.o: main.asm
	nasm -felf64 main.asm -o main.o

lib.o: lib.asm
	nasm -felf64 lib.asm -o lib.o

dict.o: dict.asm
	nasm -felf64 dict.asm -o dict.o


.PHONY: clean

clean:
	rm -f main main.o lib.o dict.o
	
