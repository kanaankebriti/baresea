# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ░ This file is part of libbaresea.					░
# ░									░
# ░ libfastact is free software: you can redistribute it and/or modify	░
# ░ it under the terms of the GNU General Public License as published by░
# ░ the Free Software Foundation, either version 3 of the License, or	░
# ░ (at your option) any later version.					░
# ░									░
# ░ libfastact is distributed in the hope that it will be useful,	░
# ░ but WITHOUT ANY WARRANTY; without even the implied warranty of	░
# ░ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the	░
# ░ GNU General Public License for more details.			░
# ░									░
# ░ You should have received a copy of the GNU General Public License	░
# ░ along with libfastact.  If not, see <https://www.gnu.org/licenses/>.░
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ┌─────────────────────────────────────────────┐
# │ Converts integer to ascii			│
# | input:					│
# |			rsi = uint64		│
# |			rdi = *_result_str	│
# | output:					│
# |			NaN			│
# └─────────────────────────────────────────────┘
	.file	"itoa.s"
	.text
	.globl	itoa
	.type	itoa, @function

itoa:
	mov $0xCCCCCCCCCCCCCCCD, %r8	# store magic number into r8
	mov %rdi, %rdx			# store *_result_str to rdx to reverse ordered store string
	mov %rdi, %r9			# store *_result_str to r9 for reversing the string

	test %rsi, %rsi			# check for signed number
	jns itoa_div_loop

	# handle negative numbers
	mov	$'-', %rax		# load negative symbol
	stosb				# store negative symbol
	neg	%rsi			# make original number positive for futher division
	inc	%r9			# skip first '-' character

	itoa_div_loop:
		mov	%rsi, %rax	# save original number
		mul	%r8		# divide by 10 bu multiplication using magic number rdx = rax * r8
		shr	$3, %rdx	# rdx = quotient
		mov	%rdx, %rbx	# save quotient for next loop
		imul	$10, %rdx	# rbx = rdx * 10 = quotient * 10
		sub	%rdx, %rsi	# rsi = remainder = original number  - (10 * quotient)
		add	$48, %rsi	# ascii conversion. '0' = 48
		mov	%rsi, %rax	# load resulted digit in rax
		stosb			# store resulted digit to rdi
		mov	%rbx, %rsi	# do next division using quotient
		test	%rbx, %rbx	# check for no more digits
		jnz	itoa_div_loop

	xor	%eax, %eax
	dec	%rdi			# point to last digit
	mov	%rdi, %r8		# save rdi to r8

	mov	%r9, %rsi		# save *_result_str for return

	# until now number is in reverse order. this section shuffle it to correct order.
	itoa_rev_loop:
		movzx	(%r8), %rax	# digit n, n-1, n-2, ...
		movzx	(%r9), %rbx	# digit 1, 2, 3, ...
		xchg	%rbx, %rax	# exchange (n,1), (n-1,2), (n-3,3), ...
		mov	%r8, %rdi
		stosb
		xchg	%rbx, %rax
		mov	%r9, %rdi
		stosb
		dec	%r8		# decrease pointer to the end of the string
		inc	%r9		# increase pointer to the beginning of the string
		cmp	%r9, %r8
		jg	itoa_rev_loop	# repeat until r9 > r8. that is, upper pointer is greater than lower pointer.

	mov %rsi, %rax
	ret

	.size	itoa, .-itoa
	.section	.note.GNU-stack,"",@progbits
