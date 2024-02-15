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
# │ Writes a string		│
# | input:			│
# |		rdi = *str	│
# | output:			│
# |		NaN		│
# └─────────────────────────────┘
	.file	"puts.s"
	.text
	.globl	puts
	.type	puts, @function

puts:
	pushq	%rbp
	movq	%rsp, %rbp
	call	strlen
	movq	%rdi, %rsi	# send address
	movq	%rax, %rcx	# print out only 1 character
	call	*0x00100018
	leave
	ret

	.size		puts, .-puts
	.section	.note.GNU-stack,"",@progbits

