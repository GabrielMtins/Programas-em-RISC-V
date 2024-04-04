	.data
	.align 0
	str1: .asciz "teste"
	.align 0
	str2: .asciz "teste"
	.text
	.globl main
main:
	.align 2
	la a0, str1
	la a1, str2

	jal strcmp
	
	li a7, 1
	ecall
	
	li a7, 10
	ecall

strcmp: # a0 é o endereço de str1 e a1 é o endereço de str2 # a0 retorna se é igual ou não
	addi sp, sp, -4
	sw ra, (sp)

	mv t0, a0
	mv t1, a1

strcmp_init_loop:
	lb t3, (t0)
	lb t4, (t1)

	li t2, 0 # t2 armazena o valor verdadeiro ou falso
	bne t3, t4, strcmp_end
	li t2, 1
	beq t3, zero, strcmp_end # visto que ambos são iguais, se forem iguais a 0, podemos retornar 1

	addi t0, t0, 1
	addi t1, t1, 1
	j strcmp_init_loop

strcmp_end:
	lw ra, (sp)
	addi sp, sp, 4
	mv a0, t2
	ret

