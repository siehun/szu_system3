    .data
str: .asciiz "the data of matrix 3:\n"
mx1: .space 32
mx2: .space 32
mx3: .space 32

    .text
# 给三个矩阵赋初值
initial:    
    daddi r22, r0, mx1
    daddi r23, r0, mx2
    daddi r21, r0, mx3
input:		
    daddi r9, r0, 2
    daddi r17, r0, 0
iloop1:		
    daddi r18, r0, 0
iloop2:     
    dsll r10, r17, 4
    dsll r11, r18, 3
    dadd r11, r11, r10
    dadd r10, r11, r22
    dadd r11, r11, r23
    daddi r12, r0, 2
    daddi r13, r0, 3
    sd r12, 0(r10)
    sd r13, 0(r11)

    daddi r18, r18, 1
    slt r10, r18, r9
    bne r10, r0, iloop2
    
    daddi r17, r17, 1
    slt r10, r17, r9
    bne r10, r0, iloop1

mul:		
    daddi r16, r0, 2
    daddi r17, r0, 0


loop1:		
    daddi r18, r0, 0

loop2:		
    daddi r19, r0, 0
    daddi r20, r0, 0
loop3:		
    dsll r8, r17, 4
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 4
    dsll r9, r18, 3
    dadd r8, r8, r9
    dadd r8, r8, r23
    ld r11, 0(r8)
    dmul r13, r10, r1
    dadd r20, r20, r13

    daddi r19, r19, 1
    slt r8, r19, r16
    bne r8, r0, loop3

    dsll r8, r17, 4
    dsll r9, r18, 3
    dadd r8, r8, r9
    dadd r8, r8, r21
    sd r20, 0(r8)

    daddi r18, r18, 1
    slt r8, r18, r16
    bne r8, r0, loop2

    daddi r17, r17, 1
    slt r8, r17, r16
    bne r8, r0, loop1    
    halt
