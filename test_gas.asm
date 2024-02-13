.extern printResult

.data
                radius:   .quad 1.7
                result:   .space 

                .equ      SYS_EXIT, 60
                .equ      EXIT_CODE, 0

MISMATCH: "global _start"
.text

_start: 
                fldll radius
                fldll radius
                fmul

                fldpi
                fmul
                fstpll result

                movl $0, rax
MISMATCH: "                movq xmm0, [result]"
                call printResult

MISMATCH: "                mov rax, SYS_EXIT"
MISMATCH: "                mov rdi, EXIT_CODE"
MISMATCH: "                syscall"

