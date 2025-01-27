    .data
str: .asciiz "the data of matrix 3:\n"
mx1: .space 512
mx2: .space 512
mx3: .space 512

    .text
initial:    
    daddi r22, r0, mx1
    daddi r23, r0, mx2
    daddi r21, r0, mx3
input:		
    daddi r9, r0, 64
    daddi r8, r0, 0
loop1:		
    dsll r11, r8, 3
    dadd r10, r11, r22
    dadd r11, r11, r23
    daddi r12, r0, 2
    daddi r13, r0, 3
    sd r12, 0(r10)
    sd r13, 0(r11)

    daddi r8, r8, 1
    slt r10, r8, r9
    bne r10, r0, loop1

mul:		
    daddi r16, r0, 8
    daddi r17, r0, 0
# for (int i = 0; i < 8; i++)
loop2:		
    daddi r18, r0, 0

# for (int j = 0; j < 8; ji++)
loop3:		
    daddi r19, r0, 0  # k = 0
    daddi r20, r0, 0  # r20 存计算 result[i][j] 过程中每个乘法结果的叠加值

# 循环展开
    # k = 0
    dsll r8, r17, 6
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 6
    dsll r9, r18, 3
    dadd r8, r8, r9       
    dadd r8, r8, r23
    ld r11, 0(r8)
    dmul r13, r10, r11
    dadd r20, r20, r13
    daddi r19, r19, 1 
	
    # k = 1
    dsll r8, r17, 6
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 6
    dsll r9, r18, 3
    dadd r8, r8, r9       
    dadd r8, r8, r23
    ld r11, 0(r8)
    dmul r13, r10, r11
    dadd r20, r20, r13
    daddi r19, r19, 1

    # k = 2
    dsll r8, r17, 6
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 6
    dsll r9, r18, 3
    dadd r8, r8, r9       
    dadd r8, r8, r23
    ld r11, 0(r8)
    dmul r13, r10, r11
    dadd r20, r20, r13
    daddi r19, r19, 1

    # k = 3
    dsll r8, r17, 6
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 6
    dsll r9, r18, 3
    dadd r8, r8, r9       
    dadd r8, r8, r23
    ld r11, 0(r8)
    dmul r13, r10, r11
    dadd r20, r20, r13
    daddi r19, r19, 1

    # k = 4
    dsll r8, r17, 6
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 6
    dsll r9, r18, 3
    dadd r8, r8, r9       
    dadd r8, r8, r23 
    ld r11, 0(r8)	
    dmul r13, r10, r11
    dadd r20, r20, r13
    daddi r19, r19, 1
	
    # k = 5
    dsll r8, r17, 6
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 6
    dsll r9, r18, 3
    dadd r8, r8, r9       
    dadd r8, r8, r23
    ld r11, 0(r8)
    dmul r13, r10, r11
    dadd r20, r20, r13
    daddi r19, r19, 1

    # k = 6
    dsll r8, r17, 6
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 6
    dsll r9, r18, 3
    dadd r8, r8, r9       
    dadd r8, r8, r23
    ld r11, 0(r8)
    dmul r13, r10, r11
    dadd r20, r20, r13
    daddi r19, r19, 1

    # k = 7
    dsll r8, r17, 6
    dsll r9, r19, 3
    dadd r8, r8, r9
    dadd r8, r8, r22
    ld r10, 0(r8)
    dsll r8, r19, 6
    dsll r9, r18, 3
    dadd r8, r8, r9       
    dadd r8, r8, r23
    ld r11, 0(r8)
    dmul r13, r10, r11
    dadd r20, r20, r13
    daddi r19, r19, 1
# 循环展开结束

    dsll r8, r17, 6
    dsll r9, r18, 3
    dadd r8, r8, r9
    dadd r8, r8, r21  # 计算 result[i][j] 的位置
    sd r20, 0(r8)  # 将结果存入 result[i][j] 中

    daddi r18, r18, 1
    slt r8, r18, r16
    bne r8, r0, loop3

    daddi r17, r17, 1
    slt r8, r17, r16
    bne r8, r0, loop2    

    halt
