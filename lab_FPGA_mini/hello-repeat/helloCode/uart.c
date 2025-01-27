#include "uart.h"

void uart_putchar(const char ch) {
  while (0 == ((*WRITE_VALID) & 1))
    ;
  *WRITE_DATA_ADDR = ch;
}

void uart_puts(const char *str) {
  for (int k = 0; str[k]; ++k)
    uart_putchar(str[k]);
}

char uart_getchar() {
  char ch = 0;
  while (0 == ((*READ_VALID) & 1))
		;
  ch = *READ_DATA_ADDR;
  return ch;
}
