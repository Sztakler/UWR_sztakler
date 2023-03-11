	.file	"bit_reversal.c"
	.text
	.p2align 4
	.globl	bitrev
	.type	bitrev, @function
bitrev:
.LFB23:
	.cfi_startproc
	endbr64
	movabsq	$6148914691236517205, %rdx
	movq	%rdi, %rax
	shrq	%rdi
	movabsq	$1085102592571150095, %rcx
	andq	%rdx, %rdi
	addq	%rax, %rax
	movabsq	$-6148914691236517206, %rdx
	andq	%rdx, %rax
	orq	%rax, %rdi
	movabsq	$3689348814741910323, %rax
	movq	%rdi, %rdx
	salq	$2, %rdi
	shrq	$2, %rdx
	andq	%rax, %rdx
	movabsq	$-3689348814741910324, %rax
	andq	%rax, %rdi
	orq	%rdi, %rdx
	movq	%rdx, %rax
	salq	$4, %rdx
	shrq	$4, %rax
	andq	%rcx, %rax
	movabsq	$-1085102592571150096, %rcx
	andq	%rcx, %rdx
	orq	%rax, %rdx
	movq	%rdx, %rax
	bswap	%rax
	ret
	.cfi_endproc
.LFE23:
	.size	bitrev, .-bitrev
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%#16lx\n%#16lx"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	xorl	%eax, %eax
	movabsq	$6148914691236517205, %rcx
	movabsq	$-6148914691236517206, %rdx
	call	__printf_chk@PLT
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
