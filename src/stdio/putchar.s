# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ░ This file is part of libbaresea.					░
# ░									░
# ░ libbaresea is free software: you can redistribute it and/or modify	░
# ░ it under the terms of the GNU General Public License as published by░
# ░ the Free Software Foundation, either version 3 of the License, or	░
# ░ (at your option) any later version.					░
# ░									░
# ░ libbaresea is distributed in the hope that it will be useful,	░
# ░ but WITHOUT ANY WARRANTY; without even the implied warranty of	░
# ░ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the	░
# ░ GNU General Public License for more details.			░
# ░									░
# ░ You should have received a copy of the GNU General Public License	░
# ░ along with libbaresea.  If not, see <https://www.gnu.org/licenses/>.░
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ┌─────────────────────────────┐
# │ Writes a character ch	│
# | input:			│
# |		rdi = input ch	│
# | output:			│
# |		NaN		│
# └─────────────────────────────┘
	.file	"putchar.s"
	.text
	.globl	putchar
	.type	putchar, @function

putchar:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$1, %rsp
	movq	%rdi, %rax
	movb	%al, -1(%rbp)	# store 1 byte character
	leaq	-1(%rbp), %rsi	# send address
	movl	$1, %ecx	# print out only 1 character
	call	*0x00100018
	leave
	ret

	.size		putchar, .-putchar
	.section	.note.GNU-stack,"",@progbits

