all: main

main.o: main.asm lib.asm
	nasm -felf64 -g -F dwarf main.asm -o main.o

main: main.o
	ld -o main main.o


clean:
	rm -f main.o main
