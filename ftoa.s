	.file	"ftoa.c"
	.text
	.globl	ftoa
	.type	ftoa, @function
ftoa:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movsd	%xmm0, -16(%rbp)
#APP
# 32 "./src/stdlib/ftoa.c" 1
	.set	integer_part, -24	
	.set	decimal_part, -32	
	.set	ten_const, -40		
	
# 0 "" 2
# 38 "./src/stdlib/ftoa.c" 1
	movl	$10, ten_const(%rbp)	
	
# 0 "" 2
# 42 "./src/stdlib/ftoa.c" 1
	movsd	%xmm0, decimal_part(%rbp)	
	xor	%ecx, %ecx			
	mov	%rdi, %rbx			
	next_decimal:					
	inc		%cl			
	fldl		decimal_part(%rbp)	
	fimull		ten_const(%rbp)		
	fisttpq	integer_part(%rbp)	
	fildq		integer_part(%rbp)	
	fldl		decimal_part(%rbp)	
	fimull		ten_const(%rbp)		
	fstl		decimal_part(%rbp)	
	fcomip		%st(1)  		
	jne		next_decimal		
	fisttpq	decimal_part(%rbp)		
	movsd		%xmm0, integer_part(%rbp)	
	fldl		integer_part(%rbp)		
	fisttpq	integer_part(%rbp)		
	movq	decimal_part(%rbp), %rax	
	call		pow10i			
	
# 0 "" 2
#NO_APP
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	ftoa, .-ftoa
	.ident	"GCC: (Debian 12.2.0-14) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
