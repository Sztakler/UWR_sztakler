	.file	"2.c"
	.text
	.globl	puzzle
	.def	puzzle;	.scl	2;	.type	32;	.endef
	.seh_proc	puzzle
puzzle:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	%rdx, 24(%rbp)
.L7:
	movq	16(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L2
.L6:
	movq	24(%rbp), %rax
	movzbl	(%rax), %eax
	movb	%al, -9(%rbp)
	addq	$1, 24(%rbp)
	cmpb	$0, -9(%rbp)
	jne	.L3
	movq	-8(%rbp), %rax
	subq	16(%rbp), %rax
	jmp	.L8
.L3:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	%al, -9(%rbp)
	jne	.L2
	addq	$1, -8(%rbp)
	jmp	.L5
.L2:
	movq	24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L6
.L5:
	jmp	.L7
.L8:
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "abdac\0"
.LC1:
	.ascii "aaabc\0"
.LC2:
	.ascii "%d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	leaq	.LC0(%rip), %rdx
	leaq	.LC1(%rip), %rcx
	call	puzzle
	movl	%eax, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	printf;	.scl	2;	.type	32;	.endef
