all: hello.coe

dump:
	riscv32-unknown-elf-objdump -d hello.elf

hello.elf: bootMain.s hello.c uart.c
	riscv32-unknown-elf-gcc -nostdlib -Ttext=0x200 -o hello.elf bootMain.s hello.c uart.c

hello.hex: hello.elf
	elf2hex 16 1024 hello.elf > hello.hex

hello.coe: hello.hex
	python3 split.py hello.hex hello.coe
