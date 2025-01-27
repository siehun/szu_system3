import os
import sys

hex_file = sys.argv[1]
coe_file = hex_file[:-4]+".coe"
f_hex = open(hex_file, "r")
f_coe = open(coe_file, "w")

f_coe.write("memory_initialization_radix=16;\n")
f_coe.write("memory_initialization_vector=\n")
# for i in range(63):
#     f_coe.write("0000000000000000,\n")
for line in f_hex:
    if len(line) < 32:
        break
    hex1 = line[0:16] + ",\n"
    hex2 = line[16:32] + ",\n"  # 最后一行改分号
    f_coe.write(hex2)  # 小端，命令从右边往左边读
    f_coe.write(hex1)
    # print(hex1)
    # print(hex2)
f_coe.write("0000000000000000;\n")
f_hex.close()
f_coe.close()
pass
