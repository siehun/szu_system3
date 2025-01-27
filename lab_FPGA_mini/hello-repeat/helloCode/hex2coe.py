import os

def hex_to_coe(hex_file, coe_file):
    try:
        with open(hex_file, 'r') as hex_f:
            hex_data = hex_f.readlines()

        # 打开或者创建COE文件
        with open(coe_file, 'w') as coe_f:
            # COE文件头
            coe_f.write("memory_initialization_radix=16;\n")
            coe_f.write("memory_initialization_vector=\n")

            # 将HEX文件中的内容转换为COE格式
            for i, line in enumerate(hex_data):
                line = line.strip()
                if line:
                    coe_f.write(f"{line}")
                    if i != len(hex_data) - 1:
                        coe_f.write(",\n")  # 每行数据后面加逗号，最后一行不加
                    else:
                        coe_f.write(";\n")  # 最后一行数据后面加分号

        print(f"Successfully converted {hex_file} to {coe_file}")
    except FileNotFoundError:
        print(f"Error: The file {hex_file} was not found.")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    hex_file_path = input("Enter the path to the HEX file: ")

    # 获取文件名和扩展名
    base_name, _ = os.path.splitext(hex_file_path)
    coe_file_path = base_name + ".coe"

    # 调用转换函数
    hex_to_coe(hex_file_path, coe_file_path)

