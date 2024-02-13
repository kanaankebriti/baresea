// =============================================================================
// BareMetal -- a 64-bit OS written in Assembly for x86-64 systems
// Copyright (C) 2008-2023 Return Infinity -- see LICENSE.TXT
//
// Version 1.0
// =============================================================================

//┌─────────────────────────────────────────────┐
//│ converts integer to ascii			│
//| input:					│
//|			rsi = uint64		│
//|			rdi = *_result_str	│
//| output:					│
//|			NaN			│
//└─────────────────────────────────────────────┘
char* itoa (const char *buffer, long value) {
	asm volatile (
		"mov $0xCCCCCCCCCCCCCCCD, %r8	\n\t"	// store magic number into r8
		"mov %rdi, %rdx			\n\t"	// store *_result_str to rdx to reverse ordered store string
		"mov %rdi, %r9			\n\t"	// store *_result_str to r9 for reversing the string

		"test %rsi, %rsi		\n\t"	// check for signed number
		"jns itoa_div_loop		\n\t"

		/* handle negative numbers */
		"mov	$'-', %rax		\n\t"	// load negative symbol
		"stosb				\n\t"	// store negative symbol
		"neg	%rsi			\n\t"	// make original number positive for futher division
		"inc	%r9			\n\t"	// skip first '-' character

		"itoa_div_loop:			\n\t"
			"mov	%rsi, %rax	\n\t"	// save original number
			"mul	%r8		\n\t"	// divide by 10 bu multiplication using magic number rdx = rax * r8
			"shr	$3, %rdx	\n\t"	// rdx = quotient
			"mov	%rdx, %rbx	\n\t"	// save quotient for next loop
			"imul	$10, %rdx	\n\t"	// rbx = rdx * 10 = quotient * 10
			"sub	%rdx, %rsi	\n\t"	// rsi = remainder = original number  - (10 * quotient)
			"add	$48, %rsi	\n\t"	// ascii conversion. '0' = 48
			"mov	%rsi, %rax	\n\t"	// load resulted digit in rax
			"stosb			\n\t"	// store resulted digit to rdi
			"mov	%rbx, %rsi	\n\t"	// do next division using quotient
			"test	%rbx, %rbx	\n\t"	// check for no more digits
			"jnz	itoa_div_loop	\n\t"

		"xor	%eax, %eax		\n\t"
		"dec	%rdi			\n\t"	// point to last digit
		"mov	%rdi, %r8		\n\t"	// save rdi to r8

		"mov	%r9, %rsi		\n\t"	// save *_result_str for return

		// until now number is in reverse order. this section shuffle it to correct order.
		"itoa_rev_loop:			\n\t"
			"movzx	(%r8), %rax	\n\t"	// digit n, n-1, n-2, ...
			"movzx	(%r9), %rbx	\n\t"	// digit 1, 2, 3, ...
			"xchg	%rbx, %rax	\n\t"	// exchange (n,1), (n-1,2), (n-3,3), ...
			"mov	%r8, %rdi	\n\t"
			"stosb			\n\t"
			"xchg	%rbx, %rax	\n\t"
			"mov	%r9, %rdi	\n\t"
			"stosb			\n\t"
			"dec	%r8		\n\t"	// decrease pointer to the end of the string
			"inc	%r9		\n\t"	// increase pointer to the beginning of the string
			"cmp	%r9, %r8	\n\t"
			"jg	itoa_rev_loop	\n\t"	// repeat until r9 > r8. that is, upper pointer is greater than lower pointer.

		"mov %rsi, %rax			\n\t"
	);
}

// =============================================================================
// EOF
