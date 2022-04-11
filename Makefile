PREFIX = /usr/local
BIN = bin

.PHONY build:
build:
	@nasm -f elf64 asmstrap.asm
	@ld -melf_x86_64 -s -o asmstrap asmstrap.o
.PHONY build-32:
build-32:
	@nasm -f elf asmstrap.asm
	@ld -melf_i386 -s -o asmstrap asmstrap.o
.PHONY install:
install:
	@cp asmstrap ${PREFIX}/${BIN}