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
 *│ computes 10^n			│
 *│ input:				│
 *│			rdi = n		│
 *│ output:				│
 *│			rax = 10^n	│
 *└─────────────────────────────────────┘
 */
long pow10i(long n) {
	// based on fact that 10^n = 2^n * 5^n
	asm volatile (
		"mov	$5, %ebx		\n\t"	// for 5^n loop multiplier
		"xor	%eax, %eax		\n\t"	// rax = 0
		"bts	%rdi, %rax		\n\t"	// set bit(n) of rax. this gives 2^n.
		"mov	%rdi, %rcx		\n\t"	// set loop counter

		"five_power_loop:		\n\t"
			"mul	%rbx		\n\t"
			"loop	five_power_loop	\n\t"	// rcx = n = loop counter
	);
}
