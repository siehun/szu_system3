#include "uart.h"

int main() {
	while(1){
		uart_puts("hello, world\n");
	}
  return 0;
}
