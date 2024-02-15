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
# ┌─────────────────────────────────────┐
# │ returns length of a string		│
# │ input:				│
# │		rdi = *str		│
# │ output:				│
# │		rax = length of	str	│
# └─────────────────────────────────────┘
	.file	"strlen2.s"
	.text
	.globl	strlen2
	.type	strlen2, @function

	.set	EQUAL_EACH, 0b1000

strlen2:
	movq	$-16, %rax	# character counter
	pxor	%xmm0, %xmm0	# compare against null charachter
	next_char:
    		addq		$16, %rax 				# read 16 chars
    		pcmpistri	$EQUAL_EACH, (%rdi, %rax), %xmm0	# returns index of zero in address (%rdi, %rax) if any to ecx
    		jnz		next_char				# or try again in next loop
		add		%rcx, %rax				# to manage the last iteration
	ret

	.size		strlen2, .-strlen2
	.section	.note.GNU-stack,"",@progbits

