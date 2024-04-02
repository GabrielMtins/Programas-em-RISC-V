	.data
	.text
	.globl main
main:
	.align 2
	li a7, 5
	ecall
	mv t0, a0
	li t1, 0
	
inicio:
	add t1, t1, t0
	addi t0, t0, -1
	bne t0, zero, inicio
	
	mv a0, t1
	li a7, 1
	ecall