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
# ┌─────────────────────────────────────────────┐
# │ returns absolute value of an integer number	│
# │ input:					│
# │			rdi = number		│
# │ output:					│
# │			rax = abs(number)	│
# └─────────────────────────────────────────────┘
	.file	"abs.s"
	.text
	.globl	abs
	.type	abs, @function
abs:
	mov	%rdi, %rax	# store rdi in rax
	neg	%rax
	cmovl	%rdi, %rax	# if rax is now negative, restore its saved value
	ret

	.size		abs, .-abs
	.section	.note.GNU-stack,"",@progbits
