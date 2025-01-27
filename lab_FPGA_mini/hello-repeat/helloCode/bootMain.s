    .text
    .globl _start
_start:
	mv s0, zero
	li sp, 0x800
    call main
spin:
    j spin
