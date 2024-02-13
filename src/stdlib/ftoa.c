/*
 *░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
 *░ This file is part of libbaresea.					░
 *░									░
 *░ libbaresea is free software: you can redistribute it and/or modify	░
 *░ it under the terms of the GNU General Public License as published by░
 *░ the Free Software Foundation, either version 3 of the License, or	░
 *░ (at your option) any later version.					░
 *░									░
 *░ libbaresea is distributed in the hope that it will be useful,	░
 *░ but WITHOUT ANY WARRANTY; without even the implied warranty of	░
 *░ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the	░
 *░ GNU General Public License for more details.			░
 *░									░
 *░ You should have received a copy of the GNU General Public License	░
 *░ along with libbaresea.  If not, see <https://www.gnu.org/licenses/>.░
 *░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
 *┌─────────────────────────────────────────────────────┐
 *│ converts float to ascii				│
 *│ input:						│
 *│			xmm0 = float input		│
 *│			no rdx -> rdi = *_result_str	│
 *│			_result_str db 20 dup(?),0	│
 *│ output:						│
 *│			NaN				│
 *└─────────────────────────────────────────────────────┘
 */
long ftoa (char* buffer, double value) {
	// define variables
	// buffer -8(%rbp)
	// double -16(%rbp)
	asm volatile (
		".set	integer_part, -24	\n\t"	// long integer_part;
		".set	decimal_part, -32	\n\t"	// double decimal_part; then convert to long decimal_part;
		".set	ten_const, -40		\n\t"	// double ten_const;
	);
	// initilize variables
	asm volatile (
		"movl	$10, ten_const(%rbp)	\n\t"	// ten_const = 10;
	);
	
	asm volatile (
		"movsd	%xmm0, decimal_part(%rbp)	\n\t"	// get decimal_part from input
		"xor	%ecx, %ecx			\n\t"	// number of decimal points counter
		"mov	%rdi, %rbx			\n\t"	// store *_result_str into rdx so we can use mul

		// multiply by 10 until no digits after decimal points left
		"next_decimal:					\n\t"
			"inc		%cl			\n\t"
			
			"fldl		decimal_part(%rbp)	\n\t"	// load real number (decimal_part) into stack at ST(0) ░ example 3.14
			"fimull		ten_const(%rbp)		\n\t"	// ST0 *= ten_const = 10 (decimal_part *= 10) ░ example 31.4
			"fisttpq	integer_part(%rbp)	\n\t"	// trunc [decimal_part] in ST(0) and store it to [integer_part] e.g. ░ example store 31

			"fildq		integer_part(%rbp)	\n\t"	// load integer number (integer_part) into stack at ST(1) ░ example load 31
			"fldl		decimal_part(%rbp)	\n\t"	// load real number into stack at ST(0) ░ example 3.14 again
			"fimull		ten_const(%rbp)		\n\t"	// ST0 *= 10 ░ example 31.4 again
			"fstl		decimal_part(%rbp)	\n\t"	// store [decimal_part]*10 to [decimal_part] for next iteration ░ example store 31.4

			"fcomip		%st(1)  		\n\t"	// compare integer_part by decimal_part ░ example 31.4 != 31
			"jne		next_decimal		\n\t"	// st(0) == st(1)
	

		"fisttpq	decimal_part(%rbp)		\n\t"	// convert [decimal_part] in ST(1) into integer. at this point, decimal_part contains all digits.
		"movsd		%xmm0, integer_part(%rbp)	\n\t"	// put back float input into integer_part
		"fldl		integer_part(%rbp)		\n\t"	// load real number into stack at ST(0)
		"fisttpq	integer_part(%rbp)		\n\t"	// trunc [decimal_part] and store it to [integer_part]. at this point, decimal_part contains trailing zeros.
"movq	decimal_part(%rbp), %rax	\n\t"

		"call		pow10i			\n\t"	// rax = 10^rcx and rcx is loop counter
	/*mov		rcx,[integer_part]	; rcx = [integer_part]
	mul		rcx					; rax = [integer_part] * 10^rcx
	sub		[decimal_part],rax	; now decimal_part contains only digits after radix point

	mov		rcx,[decimal_part]	; handle negative values
	call	fa_abs
	mov		[decimal_part],rax

	mov		rdx,rbx				; load back *_result_str and point to _result_str[0]
	call	fa_itoa				; copy [integer_part] which is already in rcx to _result_str

	mov		rcx,rbx				; pass *_result_str for strlen
	call	fa_strlen

	mov		rdi,rbx				; load back *_result_str and point to _result_str[0]
	add		rdi,rax				; point to the digit after last digit.
	mov		rdx,rdi				; store position of the last digit for later (appending decimal_part)
	mov		rax,'.'				; load radix 'dot' character
	stosq						; append 'dot' character to integer_part

	mov		rcx,[decimal_part]
	inc		rdx					; decimal_part begins after radix 'dot' character
	call	fa_itoa				; append decimal_part to 'dot' character
*/
);
}
