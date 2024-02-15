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
# │ sqruare root			│
# │ input:				│
# │		xmm0 = number		│
# │ output:				│
# │		xmm0 = sqrt(number)	│
# │		or if number < 0	|
# │		xmm0 = number		│
# └─────────────────────────────────────┘
	.file	"sqrt.s"
	.text
	.globl	sqrt
	.type	sqrt, @function

sqrt:
	pxor	%xmm1, %xmm1		# xmm1 = 0
	comisd	%xmm1, %xmm0		# cehck for negative input. xmm0 < 0
	jb	negative_sqrt
	sqrtsd	%xmm0, %xmm0		# Compute Square Root of Scalar Double-Precision Floating-Point Value.
	movl	$1, %eax
	ret
	negative_sqrt:
		ret

	.size		sqrt, .-sqrt
	.section	.note.GNU-stack,"",@progbits

