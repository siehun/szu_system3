#define READ_VALID      ((unsigned int*) 0x10000000)
#define READ_DATA_ADDR  ((unsigned char*)0x10000004)
#define WRITE_VALID     ((unsigned int*) 0x10000008)
#define WRITE_DATA_ADDR ((unsigned char*)0x1000000c)

void uart_putchar(const char ch);
void uart_puts(const char *str);
char uart_getchar();
