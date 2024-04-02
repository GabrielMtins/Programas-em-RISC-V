	.data
	.text
	.globl main
main:
	.align 2
	li a7, 5
	ecall # ler um inteiro
	mv t0, a0 # salvar no registrador t0
	li t1, 1
	
inicio:
	beq t0, zero, fim
	mul t1, t1, t0
	addi t0, t0, -1
	j inicio
fim:
	li a7, 1
	mv a0, t1
	ecall
	
	li a7, 10
	ecall