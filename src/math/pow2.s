/*
 *░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
 *░ This file is part of libfastact.					░
 *░									░
 *░ libfastact is free software: you can redistribute it and/or modify	░
 *░ it under the terms of the GNU General Public License as published by░
 *░ the Free Software Foundation, either version 3 of the License, or	░
 *░ (at your option) any later version.					░
 *░									░
 *░ libfastact is distributed in the hope that it will be useful,	░
 *░ but WITHOUT ANY WARRANTY; without even the implied warranty of	░
 *░ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the	░
 *░ GNU General Public License for more details.			░
 *░									░
 *░ You should have received a copy of the GNU General Public License	░
 *░ along with libfastact.  If not, see <https://www.gnu.org/licenses/>.░
 *░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
 *┌─────────────────────────────────────┐
 *│ computes 2^n			│
 *│ input:				│
 *│			rdi = n		│
 *│ output:				│
 *│			rax = 2^n	│
 *└─────────────────────────────────────┘
 */
	.file	"pow2.s"
	.text
	.globl	pow2
	.type	pow2, @function

pow2:
	xor	%eax, %eax	# rax = 0
	bts	%rdi, %rax	# set bit(n) of rax. this gives 2^n.		

	ret
	
	.size	pow2, .-pow2
	.section	.note.GNU-stack,"",@progbits

