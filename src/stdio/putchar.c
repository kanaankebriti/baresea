// =============================================================================
// BareMetal -- a 64-bit OS written in Assembly for x86-64 systems
// Copyright (C) 2008-2023 Return Infinity -- see LICENSE.TXT
//
// Version 1.0
// =============================================================================

#include <stdio.h>

void b_output(const char *str, unsigned long nbr) {
	asm volatile ("call *0x00100018" : : "S"(str), "c"(nbr));
}

/*
void* memset(void* s, int c, int n)
{
	char* _src;

	_src = (char*)s;

	while (n--) {
		*_src++ = c;
	}

	return s;
}

void* memcpy(void* d, const void* s, int n)
{
	char* dest;
	char* src;

	dest = (char*)d;
	src = (char*)s;

	while (n--) {
		*dest++ = *src++;
	}

	return d;
}

int strlen(const char* s)
{
	int r = 0;

	for(; *s++ != 0; r++) { }

	return r;
}
*/

int putchar (int __c) {
  char ch = __c;
  b_output(&ch, 1);
}

// =============================================================================
// EOF
